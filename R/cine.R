
utils::globalVariables(c("as.tibble", "word", "value", "df_LEMMA", "unite", "AcademicLevel_COD"))

options(dplyr.summarise.inform = FALSE)

#' Classifies educational programs using lemmatization and CINE classification
#'
#' @description Uses the lemmatization of the education program name to combine with the CINE dataframe.
#'
#' @import dplyr
#' @import tm
#' @import tidytext
#'
#' @param df Name of dataframe
#' @param EducationProgram Name of Education Program
#' @param filterBy Academic level code. Use 'AUX' for 'Auxiliar técnico', 'TEC' for 'Técnico', 'PTC' for 'Profesional técnico', 'PRF' for 'Profesional', '2DA' for 'Segunda especialidad', 'MAG' for 'Maestría' and 'PHD' for 'Doctorado'
#'
#' @return A dataframe with CINE classification result fields
#' @export
#'
#' @examples
#' df <- data.frame(c("Administración de Negocios Internacionales",
#' "Ingeniería de Telecomunicaciones",
#' "Ingeniería Geográfica",
#' "Psicología Organizacional y de la Gestión Humana",
#' "Educación Secundaria Especialidad Lengua y Literatura",
#' "Educación Secundaria, Mención en: Ciencias Matemáticas",
#' "Ciencias de la Comunicación con Especialidad en Periodismo",
#' "Ingeniería Pesquera",
#' "Medicina Humana",
#' "Medicina Veterinaria",
#' "Carrera de Economía",
#' "Radiología",
#' "Biología - Microbiología",
#' "Marketing y Negocios Internacionales",
#' "Tecnología Médica con Especialidad en Laboratorio Clínico"))
#' colnames(df) <- "ProgramaEducativo"
#' cine(df=df, EducationProgram="ProgramaEducativo", filterBy='PRF')
#'

cine <- function(df, EducationProgram, filterBy){

  d <- df[,colnames(df)==EducationProgram]

  d <- data.frame(d)

  colnames(d) = "x"

  d = d$x

  d <- VCorpus(VectorSource(d))

  d <- tm_map(d, tolower)
  d <- tm_map(d, stripWhitespace)
  d <- tm_map(d, removePunctuation)
  d <- tm_map(d, removeNumbers)

  MyStopWords <- CINE::MyStopWords

  d <- tm_map(d, removeWords, c(stopwords("spanish"), MyStopWords))

  z <- data.frame(text = get("content", d))
  Programa_TXT <- t(z)

  Programa_TXT <- trimws(Programa_TXT)

  for (i in 1:length(Programa_TXT)) {
    Programa_TXT[i] = gsub("\\s+", " ", Programa_TXT[i])
  }

  largo <- vector()
  for (i in 1:length(Programa_TXT)) {
    largo[i] = nchar(Programa_TXT[i])
  }

  m <- df[,colnames(df)==EducationProgram]
  m <- data.frame(m)

  colnames(m) = "x"
  m = m$x

  VF = largo==0

  lista_eli <- m[VF]

  if(sum(VF)!=0){
    message("The following programs do not contain information to be classified:")
    message(lista_eli)
  }

  VF = largo!=0

  Programa_TXT <- Programa_TXT[VF]

  df <- filter(df, largo!=0)

  a <- vector()
  for (i in 1:length(Programa_TXT)) {

    b <- as_tibble(Programa_TXT[i]) %>%
      unnest_tokens(word, value)

    b <- left_join(b, df_LEMMA, by=c("word"))

    if (dim(b)[1]==0){
      l = "-"
    } else {
      l <- unique(b)
      l <- data.frame(t(l))
      l <- tidyr::unite(l, l, sep=" ")
    }

    a[i] <- l
  }

  aa <- data.frame(text = sapply(a, as.character), stringsAsFactors = FALSE)
  aa <- data.frame(t(aa))

  Programa_LEMMA <- aa$X2

  df["EducationProgram_Lemma"] <- Programa_LEMMA

  df_CINE <- CINE::df_CINE

  df_CINE <- dplyr::filter(df_CINE, AcademicLevel_COD==filterBy)

  df_CINE$EducationProgram <- NULL

  df_CINE <- unique(df_CINE)

  dX <- left_join(df, df_CINE, by=c("EducationProgram_Lemma"))

  return(dX)

}

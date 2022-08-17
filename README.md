
# CINE <img src="imgs/hex_emblema_CINE.png" align="right" width="120"/>

<!-- badges: start -->

![errero](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
<img src="imgs/logo_infinito.png" width="50"/>
[![Open Source Love](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![Project-Status:Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Linux](https://svgshare.com/i/Zhy.svg)](https://svgshare.com/i/Zhy.svg)
![LinuxMint](https://img.shields.io/badge/Linux_Mint-87CF3E?style=for-the2-badge&logo=linux-mint&logoColor=white)
[![CRAN-status](https://www.r-pkg.org/badges/version/CINE)](https://CRAN.R-project.org/package=CINE)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/CINE?color=yellow)](https://CRAN.R-project.org/package=CINE)

<!-- badges: end -->

[**CINE**](https://github.com/musajajorge/cine/) 

## Installation :arrow_double_down:

Install **CINE** from [**CRAN**](https://CRAN.R-project.org/package=CINE):

``` r
install.packages("CINE")
```

or install **CINE** with

``` r
library(remotes)
install_github("musajajorge/CINE")
```

## Usage :muscle:

### Creating a dataframe

``` r
df <- data.frame(c("Administración de Negocios Internacionales",
"Ingeniería de Telecomunicaciones",
"Ingeniería Geográfica",
"Psicología Organizacional y de la Gestión Humana",
"Educación Secundaria Especialidad Lengua y Literatura",
"Educación Secundaria, Mención en: Ciencias Matemáticas",
"Ciencias de la Comunicación con Especialidad en Periodismo",
"Ingeniería Pesquera",
"Medicina Humana",
"Medicina Veterinaria",
"Carrera de Economía",
"Radiología",
"Biología - Microbiología",
"Marketing y Negocios Internacionales",
"Tecnología Médica con Especialidad en Laboratorio Clínico"))

colnames(df) <- "ProgramaEducativo"

cine(df=df, EducationProgram="ProgramaEducativo", filterBy='PRF')
```

### Importing a dataframe

``` r

```

------------

<p align="center">
    <img src="imgs/item_infinito.png" width="40%">
</p>

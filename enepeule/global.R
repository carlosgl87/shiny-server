library(shiny)
library(shinymaterial)
library(tidyverse)
library(ggiraph)
library(data.table)
library(extrafont)

setwd("C:/Users/arojas/Documents/QROMA/Proyecto/qroma_dashboard_movil2")

# font_import(pattern = "Roboto")
# loadfonts(device = "win")

#------------------------------------------------------------------------

data_cuotas <- fread("./CAA_Dashboard_Cuotas.csv",
                     colClasses = c(CO_VEND = "character"),
                     stringsAsFactors = FALSE, 
                     na.strings=c("","NA"))

data_cuotas <- data_cuotas %>% filter(TIPO_CUOTA != "FEP_MENSUAL")

lista_vendedores <- unique(data_cuotas %>% pull(CO_VEND))

#------------------------------------------------------------------------


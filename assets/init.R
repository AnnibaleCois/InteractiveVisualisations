####################################################################################################
# Initialisation R scripts & settings                                                              #
# acois@sun.ac.za, 17/02/2022                                                                      #
####################################################################################################

## @knitr init

library(RefManageR)
library(xaringanExtra)
library(chromote)
library(kableExtra)
library(flipbookr)
library(tidyverse)

library(ggplot2)
library(ggthemes)
library(ggfortify)
library(scales)
library(vangogh)
library(hexbin)

library(fBasics)

library(raster)
library(rgdal)
library(rgeos)
library(sp)

knitr::opts_chunk$set(message = FALSE, warning = FALSE, comment = "", cache = F)

# Graphics
theme_set(theme_gray())
AnniTheme <- theme_update(
  #plot.background = element_blank(),
  axis.text.x = element_text(colour = "black"),
  axis.text.y = element_text(colour = "black"),
  legend.text = element_text(colour = "black"),
  legend.title = element_text(colour = "black"),
  strip.text.x = element_text(colour = "black"),
  strip.text.y = element_text(colour = "black"),
  axis.title.x = element_text(colour = "black"),
  axis.title.y = element_text(colour = "black"),
  axis.line.x.bottom = element_line(colour = "gray"),
  plot.caption = element_text(hjust = 0)
)

# References
BibOptions(check.entries = FALSE, 
           bib.style = "authoryear", 
           cite.style = 'authoryear', 
           first.inits = TRUE,
           style = "markdown",
           hyperlink = FALSE, 
           dashed = FALSE)
bib <- ReadBib("references/references.bib", check = FALSE)

# Insert icons
top_icon = function(x) {
  icons::icon_style(
    icons::fontawesome(x),
    position = "fixed", top = 38, right = 50,
    fill = "#561a34"  
  )
}

# XaringanExtra functions 
use_xaringan_extra(c("editable", "tile_view", "scribble"))
use_logo(
  image_url = "assets/sulogo_1.png",
  width = "150px",
  height = "46px",
  position = xaringanExtra::css_position(bottom = "1em", left = "60px"),
  link_url = NULL,
  exclude_class = c("title-slide", "inverse", "hide_logo")
)
use_webcam()
use_tile_view()
use_panelset()


# Function for exporting to other formats

printslide <- function(pres) {
  try(xaringanBuilder::build_all(paste(pres, ".Rmd", sep = ""), include = c("pdf","pptx")), silent = TRUE)
  file.rename(from = paste(pres,".pdf", sep = ""), to =  paste("pdf/",pres,".pdf", sep = ""))
  file.rename(from = paste(pres,".pptx", sep = ""), to =  paste("ppt/",pres,".pptx", sep = ""))
}




library(shiny)
library(shinyFiles)

setwd("../")

fluidPage(
  includeHTML(Sys.glob("workflow/output/multiqc/*/multiqc_report.html"))
)

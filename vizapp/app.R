library(shiny)
library(shinyFiles)

setwd("../")

ui <- fluidPage(
    includeHTML(Sys.glob("workflow/output/multiqc/*/multiqc_report.html"))
)

server <- function(input, output, session) {}

shinyApp(ui, server)

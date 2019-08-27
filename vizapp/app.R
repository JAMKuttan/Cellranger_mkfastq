library(shiny)
library(shinyFiles)

setwd("../")

ui <- fluidPage(
    includeHTML("workflow/output/multiqc/test/multiqc_report.html")
)

server <- function(input, output, session) {}

shinyApp(ui, server)

library(shiny)

options(shiny.host="0.0.0.0")
options(shiny.port=8888)

ui <- fluidPage(
  "Hello, world!"
  )
server <- function(input, output, session) {
}
shinyApp(ui, server)
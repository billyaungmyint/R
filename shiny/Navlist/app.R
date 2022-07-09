library(shiny)

options(shiny.host = "0.0.0.0")
options(shiny.port = 8887)

ui <- fluidPage(
  titlePanel("Navlist panel example"),
  
  
  
  navlistPanel(
    "Header",
    tabPanel("First",
             h3("This is the first panel"),
             selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
             verbatimTextOutput("summari"),
             tableOutput("tables")
    ),
    tabPanel("Second",
             h3("This is the second panel")
    ),
    tabPanel("Third",
             h3("This is the third panel")
    )
  )
)
server <- function(input, output, session) {
  
  # Create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summari <- renderPrint({
    # Use a reactive expression by calling it like a function
    summary(dataset())
  })
  
  output$tables <- renderTable({
    dataset()
  })
  
}
shinyApp(ui, server)

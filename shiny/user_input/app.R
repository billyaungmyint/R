library(shiny)
options(shiny.host = '0.0.0.0')
options(shiny.port = 8885)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("User Input") ,

    sidebarPanel( 
      
      textInput("name", "What's your name?"),
      numericInput("age", "How old are you?", value = NA)
      
    ),
    
    mainPanel(
      
      textOutput("greeting"),
      textOutput("age")
    )

)



# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$age <- renderText({
    input$age
    
  })
  
  output$greeting <- renderText({
    paste("Hello ", input$name)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

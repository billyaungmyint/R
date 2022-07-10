library(shiny)

options(shiny.host="0.0.0.0")
options(shiny.port=8885)

ui <- fluidPage(
  
  sidebarPanel({
    
    sliderInput("x",label = "if x is" , min = 1 , max = 50 , value = 30)
    
  }),
  
  
  mainPanel({
    
    "then x times 5 is"
    textOutput("product")
    
  }),

 
)
server <- function(input, output, session) {
  
  output$product <- renderText({
    input$x * 5
  })
  
}

shinyApp(ui, server)
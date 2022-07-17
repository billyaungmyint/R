library(shiny)
options(shiny.host = '0.0.0.0')
options(shiny.port = 8885)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("User Input") ,

    sidebarPanel( 
      
      textInput("name", "What's your name?"),
      numericInput("age", "How old are you?", value = NA) ,
      passwordInput("password","Pls enter your password" , value = "NA"),
      # textAreaInput("comments" ,"Please enter your comments" , value = NA),
      # numericInput("num", "Number one", value = 0, min = 0, max = 100),
      # sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
      # sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),
      dateInput("dob", "When were you born?"),
      dateRangeInput("holiday", "When do you want to go on vacation next?"),
      # selectInput("state", "What's your favourite state?", state.name),
      # radioButtons("animal", "What's your favourite animal?", animals),
      # 
      # # radioButtons("rb", "Choose one:",
      # #              choiceNames = list(
      # #                icon("angry"),
      # #                icon("smile"),
      # #                icon("sad-tear")
      # #              ),
      # #              choiceValues = list("angry", "happy", "sad"),
      #              
      fileInput("upload", NULL)
      #   actionButton("click", "Click me!"),
      #   actionButton("drink", "Drink me!", icon = icon("cocktail")),
      #   fluidRow(
      #     actionButton("click", "Click me!", class = "btn-danger"),
      #     actionButton("drink", "Drink me!", class = "btn-lg btn-success")
      #   ),
      #   fluidRow(
      #     actionButton("eat", "Eat me!", class = "btn-block")
      #   )
      # ),
      # 
      # selectInput(
      #   "state", "What's your favourite state?", state.name,
      #   multiple = TRUE
      # ),
      # 
      # checkboxGroupInput("animal", "What animals do you like?", animals),
      # 
      # checkboxInput("cleanup", "Clean up?", value = TRUE),
      # checkboxInput("shutdown", "Shutdown?")
      
    ),
    
    mainPanel(
      
      textOutput("greeting"),
      textOutput("age"),
      textOutput("pass"),
      textOutput("birthday"),
      textOutput("trip"),
      dataTableOutput("csvfile")
    )

)


server <- function(input, output,session) {
  
  output$age <- renderText({
    input$age
    
  })
  
  output$greeting <- renderText({
    paste("Hello ", input$name)
  })
  
  output$pass <- renderText({
    input$password
  } )
  
  output$birthday <- renderText({
    input$dob
  })
  
  output$trip <- renderText({
    input$holiday
  })
  
  output$csvfile <- renderDataTable({
    input$upload
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

library(shiny)
library(glue)
source("helper_functions.R")


# Define UI for app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Text Summarisation"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Select Summarisation Method
      selectInput(inputId = 'summary_method', label = 'Select Summarisation Method', choices = c("Relevance", "Singular Value Decomposition"), selectize=FALSE, selected = "Relevance"),
      
      # Sentences to Return
      numericInput(inputId = 'sentence_number', label = 'Number of Returned Sentences', value = 2, min = 1),
      
      actionButton(inputId = "run", label = "Run")
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      h2("Enter Text to Summarise"),
      
      h5("Read more about the summarisation methods", tags$a(href = "https://www.cs.bham.ac.uk/~pxt/IDA/text_summary.pdf", "here", target = "_blank")),
      
      textAreaInput(inputId = "input_text", label = "Input Text - Format them as sentences", width = "1000px", height = "250px"),
      
      h2("Summarised Text"),
      
      wellPanel(textOutput("summary"))
      #tags$style(type = "text/css", "#summary {white-space: pre-wrap;}")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
  
  
  summarised_text <- eventReactive(input$run, {
    
    switch(input$summary_method,
           "Relevance" = relevance_based_summary(document = input$input_text, sentences_to_return = input$sentence_number),
           "Singular Value Decomposition" = svd_based_summary(document = input$input_text, sentences_to_return = input$sentence_number))
    
  })
  
  
  output$summary <- renderText({  summarised_text()  })
  
  
  
}

shinyApp(ui = ui, server = server)


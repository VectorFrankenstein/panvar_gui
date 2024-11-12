# Load Shiny library
library(shiny)

# Define UI for the app
ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .input-group {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
      }
      .input-label {
        margin-right: 10px;
        font-weight: bold;
      }
      .required-tag {
        background-color: red;
        color: white;
        border-radius: 4px;
        padding: 2px 6px;
        margin-left: 10px;
      }
      .optional-tag {
        background-color: blue;
        color: white;
        border-radius: 4px;
        padding: 2px 6px;
        margin-left: 10px;
      }
      .default-tag {
        background-color: green;
        color: white;
        border-radius: 4px;
        padding: 2px 6px;
        margin-left: 10px;
      }
    "))
  ),
  titlePanel("Optional and Required Inputs with Default Values"),
  sidebarLayout(
    sidebarPanel(
      h4("Required Inputs"),
      div(class = "input-group",
          textInput("requiredText", "Required Text Input:", placeholder = "Must be provided"),
          tags$span("Required", class = "required-tag")
      ),
      
      h4("Optional Inputs"),
      div(class = "input-group",
          numericInput("optionalNumber", "Optional Numeric Input:", value = NULL),
          tags$span("Optional", class = "optional-tag")
      ),
      
      h4("Inputs with Default Values"),
      div(class = "input-group",
          selectInput("dropdown", "Dropdown with Default:", choices = c("Option 1", "Option 2", "Option 3"), selected = "Option 1"),
          tags$span("Default", class = "default-tag")
      ),
      div(class = "input-group",
          textInput("optionalText", "Optional Text Input with Default:", value = "Default Value"),
          tags$span("Default", class = "default-tag")
      ),
      
      actionButton("submit", "Submit")
    ),
    mainPanel(
      verbatimTextOutput("output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  observeEvent(input$submit, {
    req(input$requiredText)  # Ensure the required text input is provided
    
    output$output <- renderText({
      paste("Required Text Input:", input$requiredText,
            "\nOptional Numeric Input:", ifelse(is.null(input$optionalNumber), "Not provided", input$optionalNumber),
            "\nDropdown Selection:", input$dropdown,
            "\nOptional Text Input with Default:", input$optionalText)
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)

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
      .input-box {
        border: 1px solid #ccc;
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 5px;
      }
    "))
  ),
  titlePanel("Optional and Required Inputs with Default Values"),
  sidebarLayout(
    sidebarPanel(
      div(class = "input-box",
          h4("Required Inputs"),
          div(class = "input-group",
              textInput("requiredTextNoDefault", "Path to VCF file:", placeholder = "Must be provided"),
              tags$span("Required", class = "required-tag")
          ),
          div(class = "input-group",
              textInput("requiredTextDefault", "Required Text Input (With Default):", value = "Default Text"),
              tags$span("Required", class = "required-tag"),
              tags$span("Default: 'Default Text'", class = "default-tag")
          )
      ),
      
      div(class = "input-box",
          h4("Optional Inputs"),
          div(class = "input-group",
              numericInput("optionalNumber", "Optional Numeric Input:", value = NULL),
              tags$span("Optional", class = "optional-tag")
          )
      ),
      
      div(class = "input-box",
          h4("Inputs with Default Values"),
          div(class = "input-group",
              sliderInput("slider", "Slider with Default:", min = 1, max = 3, value = 1, step = 1),
              tags$span("Default: '1'", class = "default-tag")
          ),
          div(class = "input-group",
              textInput("optionalText", "Optional Text Input with Default:", value = "Default Value"),
              tags$span("Optional", class = "optional-tag"),
              tags$span("Default: 'Default Value'", class = "default-tag")
          )
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
    req(input$requiredTextNoDefault)  # Ensure the required text input without default is provided
    
    output$output <- renderText({
      paste("Required Text Input (No Default):", input$requiredTextNoDefault,
            "\nRequired Text Input (With Default):", input$requiredTextDefault,
            "\nOptional Numeric Input:", ifelse(is.null(input$optionalNumber), "Not provided", input$optionalNumber),
            "\nDropdown Selection:", input$dropdown,
            "\nOptional Text Input with Default:", input$optionalText)
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)

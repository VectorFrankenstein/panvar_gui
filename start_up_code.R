# Example R functions
my_table_function <- function() {
  head(mtcars)
}

my_plot_function <- function() {
  plot(mtcars$mpg, mtcars$hp, main="MPG vs HP", xlab="Miles Per Gallon", ylab="Bojack power")
}

# Load Shiny library
library(shiny)

# Define UI for the app
ui <- fluidPage(
  titlePanel("Integrating Existing R Functions with Shiny"),
  sidebarLayout(
    sidebarPanel(
      actionButton("showTable", "Show Table"),
      actionButton("showPlot", "Show Plot")
    ),
    mainPanel(
      tableOutput("table"),
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  observeEvent(input$showTable, {
    output$table <- renderTable({
      my_table_function()
    })
  })
  
  observeEvent(input$showPlot, {
    output$plot <- renderPlot({
      my_plot_function()
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)

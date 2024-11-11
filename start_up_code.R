# These are the two essential libarires for making a shiny app 
library(shiny)
library(bslib) # A module that comes attached with a shiny app

# Define UI for app that draws a histogram ----
#ui <- page_fluid(
#  layout_sidebar(
#    sidebar = sidebar("Sidebar",
#      sliderInput(
#        inputID = "bins",
#        label = "Number of bins",
#        min = 12,
#        max = 50,
#        value = 30
#      )
#    ),
#    plotOutput(outputID = "distPlot")
#  )
#)


ui <- page_fluid(
  # App title ----
  layout_sidebar(
    title = "Hello World!",
    # Sidebar panel for inputs ----
    sidebar = sidebar(
      # Input: Slider for the number of bins ----
      sliderInput(
        inputId = "bins",
        label = "Number of bins:",
        min = 12,
        max = 50,
        value = 30
      )
    ),
  ),
  # Output: Histogram ----
  plotOutput(outputId = "distPlot")
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({

    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = "#007bc2", border = "orange",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

    })

}

shinyApp(ui = ui, server = server)

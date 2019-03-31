library(shiny)

ui <- htmlTemplate("/Users/johnmalcolm/dev/landscapes_01/template.html",
	plot = plotOutput("dist"),
	slider = sliderInput("num", "Number of Points", 1, 100, 50)
)

server <- function(input, output) {
	output$dist <- renderPlot({
	 	x <- rnorm(input$num)
	 	y <- rnorm(input$num)
	 	plot(x,y)
	})
}

shinyApp(ui, server)
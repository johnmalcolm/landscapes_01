library(shiny)

ui <- fluidPage(
	sliderInput(
		inputId = "num",
		label = "Choose a number",
		value = 25, min = 1, max = 100
	 ),
	textInput(
		inputId = "title",
		label = "write a title",
		value = "histogram of random normal values"
	),
	actionButton(
		inputId = "clicks",
		label = "click me"
	),
	plotOutput("hist"),
	verbatimTextOutput("stats")
)

server <- function(input, output) {
	data <- reactive({
		rnorm(input$num)
	})

	output$hist <- renderPlot({
	 	hist(data(), main = isolate(input$title))
	})

	output$stats <- renderPrint({
	 	summary(data())
	})

	# Same as observe({print(as.numeric(input$clicks)})
	observeEvent(input$clicks, print(as.numeric(input$clicks)))
}

shinyApp(ui = ui, server = server)
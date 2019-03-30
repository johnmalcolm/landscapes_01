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
		label = "trigger server side event"
	),
	actionButton(
		inputId = "go",
		label = "Update"
	),
	actionButton(
		inputId = "uniform",
		label = "Uniform"
	),
	plotOutput("plot"),
	plotOutput("hist"),
	verbatimTextOutput("stats")
)

server <- function(input, output) {
	# data <- reactive({
	# 	rnorm(input$num)
	# })

	data <- eventReactive(input$go,{
		rnorm(input$num)
	})

	rv <- reactiveValues(data = rnorm(100))

	output$hist <- renderPlot({
	 	hist(data(), main = isolate(input$title))
	})

	output$stats <- renderPrint({
	 	summary(data())
	})

	output$plot <- renderPlot({
	 	plot(rv$data)
	})

	# Same as observe({print(as.numeric(input$clicks)})
	observeEvent(input$clicks, print(as.numeric(input$clicks)))
	observeEvent(input$uniform, {rv$data <- runif(100)})
}

shinyApp(ui = ui, server = server)
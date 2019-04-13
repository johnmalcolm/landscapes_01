# For R-IDE in Sublime Text
# install.packages("languageserver")
# install.packages("shiny")
# install.packages("tidytext")
# install.packages("tidyverse")
# install.packages("RMySQL")

library(shiny)
library(DBI)
library(tidytext)
library(tidyverse)

con <- dbConnect(RMySQL::MySQL(),
                 dbname = "L01_localelection",
                 host = "mutualcollective.crjhyx0oh3pw.us-east-2.rds.amazonaws.com",
                 port = 3306,
                 user = "mutualcollective",
                 password = "3YS7e(At$dD;")

# dbListTables(con)
custom_stop_words <- tibble("word" = c("t.co", 
                                       "https", 
                                       "rt", 
                                       "socdems", 
                                       "le19", 
                                       "amp",
                                       "day",
                                       "night",
                                       "time",
                                       "http",
                                       "II",
                                       "tonight",
                                       "week"))

tweets_preagg <- dbReadTable(con, "tweets_preagg")

tweets_word_preagg <- tweets_preagg %>%
  unnest_tokens(word, tweet_text) %>%
  anti_join(stop_words) %>%
  anti_join(custom_stop_words)

topic_engagement <- aggregate(
		tweets_word_preagg$favorite_count, 
		by=list(word=tweets_word_preagg$word), 
		FUN=sum
	)

sorted <- topic_engagement %>%
mutate(word = reorder(word, x))
head(sorted, 50)

ui <- htmlTemplate("/Users/johnmalcolm/dev/landscapes_01/www/template.html",
	plot = plotOutput("dist"),
	slider = sliderInput("num", "Number of results", 1, 50, 25)
)

server <- function(input, output) {
	output$dist <- renderPlot({
	 	words_with_count %>%
	 	top_n(input$num) %>%
		ggplot(aes(word, n)) +
		geom_col() +
		xlab(NULL) +
		coord_flip()
	})
}

shinyApp(ui, server)
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


#read the data to csv files 
trips_by_hour <- read.csv("trips_by_hour.csv")
trips_by_month <- read.csv("trips_by_month.csv")
trips_by_hour_month <- read.csv("trips_by_hour_month.csv")
trips_by_hour_base <- read.csv("trips_by_hour_base.csv")
trips_everyday <- read.csv("trips_everyday.csv")
day_hour <- read.csv("day_hour.csv")
day_month <- read.csv("day_month.csv")
weekday_base <- read.csv("weekday_base.csv")


ui <- fluidPage(
  
  titlePanel("Uber Data"),
  
  sidebarPanel(
    selectInput("month_select", "Select a Month",
                choices = c("April", "May", "June", "July", "August", "September"),
                selected = "Apr"),
    selectInput("Day_select","Select a day", 
                choices = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",  "Saturday", "Sunday"),
                selected = "Sat")),
  
  mainPanel(
    tabsetPanel(
      tabPanel("trips by month", plotOutput("trips_by_month")),
      tabPanel("Trips by Hour and Month", plotOutput("trips_by_hour_month")),
      tabPanel("Trips by Hour", plotOutput("trips_per_hour")),
      tabPanel("Trips by Base and Hour", plotOutput("trips_by_hour_base")),
      tabPanel("Trips everyday", plotOutput("trips_everyday")),
      tabPanel("Heat Map 1", plotOutput("day_hour")),
      tabPanel("Heat Map 2", plotOutput("day_month")),
      tabPanel("Heat Map 3", plotOutput("weekday_base")), 
      tabPanel("Prediction Model", plotOutput("trips_by_hour_month")) 
      ) ) 
  
 ) 
                        


# Define server logic required to draw a histogram
server <- function(input, output) {
  output$trips_by_hour  <- renderPlot({ 
    ggplot(trips_by_hour, aes(x = hour, y = trip_count)) +
      geom_bar(stat = "identity", color = "black", fill = "pink") +
      labs(title = "Trips by Hour",
           x = "hour",
           y = "Trip Count") })
  
output$trips_by_month  <- renderPlot({  
  ggplot(trips_by_month, aes(x = month, y = trips)) +
    geom_col(fill = "blue") +
    labs(title = "Total number of trips by month",
         x = "Month",
         y = "Number of trips") })

output$trips_by_hour_month  <- renderPlot({   
ggplot(trips_by_hour_month, aes(x = hour, y = trips, group = month, color = month)) +
  geom_line() +
  labs(title = "Trips by Hour and Month", x = "Hour of Day", y = "Number of Trips", color = "Month") })

output$trips_by_hour_base  <- renderPlot({    
ggplot(trips_by_hour_base, aes(x = Base, y = trips, fill = month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Trips by Bases and Month",
       x = "Base",
       y = "Trips",
       fill = "Month") +
  theme_minimal() })


output$trips_everyday  <- renderPlot({
ggplot(trips_everyday, aes(x = day, y = trips, fill = factor(month))) +
  geom_col(position = "dodge") +
  labs(x = "Day of the Month", y = "Trips Taken",
       title = "Trips Taken Every Day of the Month") +
  scale_fill_discrete(name = "Month") })

}

# Run the application 
shinyApp(ui = ui, server = server)

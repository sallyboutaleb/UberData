# Uber Data Analysis

This project explores the data on Uber rides in different months and visualizes the patterns and trends in the data.

# Data Dictionary 

The main data frame 'final_df' includes the following columns: 
 

Date: Date of the uber rides 
Time: time of the uber rides 
Lat: Latitude of the uber rides 
Lon: Longitude of the uber rides 
Base: the Base of the uber rides 
hour: time of the uber rides hour only (%H) 
month: The date of the uber rides expressed in month (non numerical)
da:y The day of the month of the uber rides 
weekday: day of the week of the uber rides 

# Data Preparation 

The script reads in six different CSV files containing data on Uber rides in different months and combines them into one data frame using rbind(). It then separates the Date.Time column into separate Date and Time columns and converts the Time column to a format that only shows hour and minute. It also creates a new column for the month, day, and weekday by using the functions format() and as.integer(). 

```r
df1<- read.csv("uber-raw-data-apr14.csv")
df2<- read.csv("uber-raw-data-may14.csv")
df3<- read.csv("uber-raw-data-jun14.csv")
df4<- read.csv("uber-raw-data-jul14.csv")
df5<- read.csv("uber-raw-data-aug14.csv")
df6<- read.csv("uber-raw-data-sep14.csv")

combined_df <- rbind(df1, df2, df3, df4, df5, df6)
final_df <- separate(combined_df, Date.Time , into = c("Date", "Time"), sep = " ")

# change the time format to hour and minute
final_df$Time <- format(as.POSIXct(final_df$Time, format = "%H:%M:%S"), format = "%H:%M")
final_df$hour <- format(as.POSIXct(final_df$Time, format = "%H:%M"), format = "%H")

# Create a new column for month only for analysis
final_df$month <- format(as.Date(final_df$Date, "%m/%d/%Y"), "%B")
# Create a new column for day and weekday for analysis
final_df$date <- strptime(as.character(final_df$Date), "%m/%d/%Y")
final_df$day <- strftime(final_df$date, "%d")
final_df$weekday <- as.integer(format(final_df$date, "%u")) 

```


# ShinyApp Link 



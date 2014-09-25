###########################
# File: plot2.r
# Description: Prints plot1
# Date: 9/24/2014
# Author: Adam Dowell
# Notes:
# - set your wd to a folder containing the "household_power_consumption.txt" file
# - will install the packages "lubridate" and "dplyr" if not already downloaded
###########################

plot2 <- function() {
  
  ## install and load needed packages
  if (!require("lubridate")) {
    install.packages("lubridate")
  }
  if (!require("dplyr")) {
    install.packages("dplyr")
  }
  require("lubridate")
  require("dplyr")
  
  ## load data
  raw <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                    na.strings="//?", stringsAsFactors=FALSE)
  
  ## convert "Date" field to proper class
  raw$Date <- dmy(raw$Date)      ## uses "lubridate"
  raw$Date <- as.Date(raw$Date)
  
  ## filter to only needed dates
  data <- filter(raw, Date>="2007-02-01" & Date<="2007-02-02") ##uses "dplyr"
  
  ## convert most columns to numeric
  data$Global_active_power <- as.numeric(data$Global_active_power)
  data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
  data$Voltage <- as.numeric(data$Voltage)
  data$Global_intensity <- as.numeric(data$Global_intensity)
  data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
  data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
  data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
  
  ## create a new column that gives a full timestamp
  data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
  
  ## create plot2
  png(filename="plot2.png")
  with(data, plot(datetime,Global_active_power, type="l", xlab="",
                  ylab="Global Active Power (kilowatts)"))
  dev.off()
}

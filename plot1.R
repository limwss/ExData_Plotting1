setwd("C:/Users/Dell/Documents/coursera/course4")

## set the filename
filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, mode="wb")
}  

## unzip the dataset:
if (!file.exists("household_power_consumption.txt")) {
  unzip(filename) 
}



#Reading, naming and subsetting power consumption data
all_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
names(all_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions
all_data$Time <- strptime(paste(all_data$Date, all_data$Time), "%d/%m/%Y %H:%M:%S")
all_data$Date <- as.Date(all_data$Date, "%d/%m/%Y")

subset_data <- subset(all_data, Date %in% as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d"))

#calling the basic plot function
hist(as.numeric(as.character(subset_data$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# annotating graph
title(main="Global Active Power")


## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
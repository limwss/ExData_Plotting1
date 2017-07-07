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



## Plot 4
par(mfrow=c(2,2))	
## plot at Top Left
plot(subset_data$Time, subset_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
## plot at Top right
plot(subset_data$Time, subset_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
## plot at Bottom Left
plot(subset_data$Time, subset_data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(subset_data$Time, subset_data$Sub_metering_2, type="l", col="red")
lines(subset_data$Time, subset_data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"), bty="o")
## plot at Bottom right
plot(subset_data$Time, subset_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Active Power")	

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
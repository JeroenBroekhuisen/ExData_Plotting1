## Peer-graded Assignment: Course Project 1 / Exploratory Data Analysis
# Student: Jeroen Broekhuisen
# For questions please contact me at post4jeroen@gmail.com


# Download the raw data and unzip it
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data/Week1")

# Load data into R
dfClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
ElecUsed <- read.table("./data/Week1/household_power_consumption.txt", sep = ";", header = TRUE, colClasses = dfClasses, na.strings = "?", dec = ".")

# We only need date from the dates 2007-02-01 and 2007-02-02

library(dplyr)
library(lubridate)
smElecUsed <- filter(ElecUsed, ElecUsed$Date == "1/2/2007" | ElecUsed$Date == "2/2/2007")

rm(ElecUsed)

# Convert Date / Time to the right classes
smElecUsed <- mutate(smElecUsed, DateTime = paste(Date, Time, sep = " "))
smElecUsed <- mutate(smElecUsed, DateTime2 = dmy_hms(DateTime))


# Reconstruct plot3
# Please note weekdays are in Dutch as that is the standard on my laptop
layout(matrix(c(1), 2, 2, byrow = TRUE))
plot(x = smElecUsed$DateTime2, y = smElecUsed$Sub_metering_1, type = "l", ylab = "Enerygy sub metering", xlab = "", col = "black")
lines(x = smElecUsed$DateTime2, y = smElecUsed$Sub_metering_2, col = "red")
lines(x = smElecUsed$DateTime2, y = smElecUsed$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), text.col = "black", lty = c(1, 1, 1))
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()



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


# Reconstruct plot1
layout(matrix(c(1), 2, 2, byrow = TRUE))
hist(smElecUsed$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()



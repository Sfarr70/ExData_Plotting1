## Load libraries
library(tidyverse)

## household_power_consumption.txt is a large file with over 2 million
## lines. For this project, we will only need data from 02/01/2007 and
## 02/02/2007. The first date in the file is 12/16/2006, reading the
## first 100,000 lines of the file should be sufficient to ensure that 
## the required dates are included.

db1<-read_delim("household_power_consumption.txt",delim=";",na=c("","?"),n_max=100000)

## Create subsets of db1 for dates 1/2/2007 & 2/2/2007. Then merge the
## two files. Date is of class character. 

temp <- subset(db1, Date=="1/2/2007")
temp2 <- subset(db1, Date=="2/2/2007")
powerdb <- rbind.data.frame(temp,temp2,make.row.names=FALSE)

## clean environment
rm(db1,temp,temp2)

## Plot2.png is a time series plot Global Active Power variable. This
## plot requires datetime data. Date is currently a string, so we need
## to convert it to type date.

powerdb$Date <- as.Date(powerdb$Date, format= "%e/%m/%Y")

## Combine Date and Time columns so each observation is one string with the
## format "YYYY-mm-dd HH:MM:SS"

dateandtime <- paste(powerdb$Date,powerdb$Time, sep=" ")

## convert dateandtime to POXIT class

datetime <- as.POSIXlt(dateandtime)

## Subset sub_metering columns

sub1 <- powerdb$Sub_metering_1
sub2 <- powerdb$Sub_metering_2
sub3 <- powerdb$Sub_metering_3

## Create PNG file with dims of 480x480.

png(file="plot3.png", width=480, height=480)

## Create plot

plot(datetime,sub1, type="l", xlab="", ylab="Energy Sub_metering")

## Add data for sub_metering 2 and 3

lines(datetime,sub2,col="red")
lines(datetime,sub3,col="blue")

## Add legend

legend("topright", legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), lwd=3, col=c("black","red","blue"))

## Turn off graphics

graphics.off()

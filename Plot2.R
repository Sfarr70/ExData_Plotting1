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

## Subset Global_active_power values from powerdb

gap <- powerdb$Global_active_power


## Create PNG file with dims of 480x480.

png(file="plot2.png", width=480, height=480)

## Create plot

plot(datetime,gap,type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Turn off graphics

graphics.off()

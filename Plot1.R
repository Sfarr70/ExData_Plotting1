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

## Plot1.png is a histogram of the Global Active Power variable. Pass
## those values into a numerical vector

gap <- powerdb$Global_active_power

## Create PNG file with dims of 480x480.

png(file="plot1.png", width=480, height=480)

## Create histogram

hist(gap,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Turn off graphics

graphics.off()

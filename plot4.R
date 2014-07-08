setwd("C:\\Users\\a0196320\\Documents\\training\\R\\Coursera")

## Read in the file from the web, unzip the directory, and read in the data tables.

  if (!file.exists("graphproject1")){dir.create("graphproject1")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./graphproject1/projectfiles.zip")
  list.files("./graphproject1")
  if (!file.exists("./graphproject1/zipdir")){dir.create("./graphproject1/zipdir")}

  unzip("./graphproject1/projectfiles.zip", exdir="./graphproject1/zipdir")
  list.files("./graphproject1/zipdir")

  alldata <- read.table("./graphproject1/zipdir/household_power_consumption.txt", sep = ";", 
                         header = TRUE, na.strings = "?")

## Convert date and time variables into usable format

  alldata$dattime <- paste(alldata$Date, alldata$Time, sep = " ")
  alldata$date <- as.Date(alldata$Date, format = "%d/%m/%Y")
  alldata$datetime <- strptime(alldata$dattime, "%d/%m/%Y %H:%M:%S")
  str(alldata)
  plotdata <- alldata[alldata$date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]

## Make 4 plots

outfile <- "./graphproject1/code/ExData_Plotting1/plot4.png"
png(outfile, type=c("windows"),width=480, height=480) 

par(mfrow = c(2, 2))

## UL Plot

plot(plotdata$datetime,plotdata$Global_active_power, ylab = "Global Active Power", 
     xlab = "", type = "l")

## UR Plot

plot(plotdata$datetime,plotdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

## LL Plot

plot(plotdata$datetime,plotdata$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
points(plotdata$datetime,plotdata$Sub_metering_1, type = "l", col = "black")
points(plotdata$datetime,plotdata$Sub_metering_2, type = "l", col = "red")
points(plotdata$datetime,plotdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## LR Plot

plot(plotdata$datetime,plotdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

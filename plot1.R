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

## Make histogram of Global Active Power

outfile <- "./graphproject1/code/ExData_Plotting1/plot1.png"
png(outfile, type=c("windows"),width=480, height=480)   
hist(plotdata$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

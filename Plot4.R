### Exploratory Data Assignment
### Peer Graded Assignment: Course Project 1 by Evgeniy Paskin

### Setting environment
library(lubridate)

### Downloading and Reading file

FileName <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",FileName)
DT <- read.table(unz(FileName, "household_power_consumption.txt"), header = TRUE, sep=";", stringsAsFactors = FALSE)
unlink(FileName) # closing connection

### Cleaning data and fixing variables types

### Cleaning and setting dates, numeric variables
DT1 <- DT
DT1$Date <- as.Date(DT1$Date, format="%d/%m/%Y" )
DT1$Time <- strptime(as.character(DT1$Time), "%H:%M:%S" )
date(DT1$Time) <- DT1$Date
DT1$Global_active_power <- as.numeric( DT1$Global_active_power)
DT1$Global_reactive_power <- as.numeric(DT1$Global_reactive_power)
DT1$Voltage <- as.numeric(DT1$Voltage)
DT1$Global_intensity <- as.numeric(DT1$Global_intensity)
DT1$Sub_metering_1 <- as.numeric(DT1$Sub_metering_1)
DT1$Sub_metering_2 <- as.numeric(DT1$Sub_metering_2)
DT1$Sub_metering_3 <- as.numeric(DT1$Sub_metering_3)


# Then subsetting the required dates between 2007-02-01 and 2007-02-02

minDate <- as.Date(c("2007-02-01"))
maxDate <- as.Date(c("2007-02-02"))
DT2 <- subset(DT1, (DT1$Date>= minDate & DT1$Date<=maxDate) )
DATA <- DT2


### Plot 4

#Starting PNG device
png(filename="plot4.png", height=480, width=480, bg="transparent")

        #Plotting
        par(mfrow=c(2,2)) #setting layout 2x2
                # Subplot 1
                plot(DATA$Time, DATA$Global_active_power,
                     type="l",
                     xlab="",
                     ylab="Global Active Power")
                
                # Subplot 2
                plot(DATA$Time, 
                     DATA$Voltage, 
                     type="l",
                     xlab="datetime", 
                     ylab="Voltage")
               
                # Subplot 3
                plot(DATA$Time, DATA$Sub_metering_1, 
                     type="l", 
                     col="black",
                     xlab="", 
                     ylab="Energy sub metering")
                
                lines(DATA$Time, DATA$Sub_metering_2, col="red")
                lines(DATA$Time, DATA$Sub_metering_3, col="blue")
                legend("topright",
                       col=c("black", "red", "blue"),
                       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       lty=1,
                       box.lwd=0)
                # Subplot 4
                plot(DATA$Time, DATA$Global_reactive_power, 
                     type="n",
                     xlab="datetime", 
                     ylab="Global_reactive_power")
                lines(DATA$Time, DATA$Global_reactive_power)

                # Saving the plot and closing device
                dev.off()




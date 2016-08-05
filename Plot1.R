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

        
### Plot 1
        
        # Starting PNG device
        png(filename="plot1.png", height=480, width=480, bg="transparent")
        
        # Adding histogram
        hist(DATA$Global_active_power,  #adding hist
             breaks = 15, #setting number of breaks
             col = "red", #setting color
             main = "Global active power", #setting chart title
             xlab = "Global Active Power (kilowatts)", #setting chart title
             cex.axis = 0.75, #reducing label sizes
             cex.lab = 0.75, #reducing label sizes
             cex.main = 0.8 #reducing label sizes
             ) 
        
        # Saving the plot and closing device
        dev.off()
        
        
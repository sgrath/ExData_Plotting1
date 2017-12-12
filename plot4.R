#Get data
#If zip file has to be downloaded
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
myData <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

#If zip file is already in the same folder as R script
#myData <- read.table(unz("exdata_data_household_power_consumption.zip","household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

#Create reduced data set (only Feb 1 and Feb 2, 2007)
reducedData <- subset(myData, myData$Date == "1/2/2007" | myData$Date == "2/2/2007")

#Needed as I usually have a German system (Do -> Thu, Fr -> Fri, Sa -> Sat)
Sys.setlocale("LC_ALL", "English")

#Modify Date and Time column as Date class (POSIXt) for proper time stamp
time <- strptime(paste(reducedData$Date, reducedData$Time),
                 format='%d/%m/%Y %T', tz='UTC')

#Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(time, reducedData$Global_active_power, 
     #xaxt = "n",
     type = "l", 
     xlab = "",
     ylab = "Global active power (kilowatts)",
     main = ""
)

plot(time, reducedData$Voltage, 
     type = "l", 
     xlab = "datetime",
     ylab = "Voltage",
     main = ""
)

plot(time, reducedData$Sub_metering_1, 
     type = "l", 
     xlab = "",
     ylab = "Energy sub metering",
     main = ""
)
lines(time, reducedData$Sub_metering_2, col = "red")
lines(time, reducedData$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=c(1,1,1), cex=0.8)

plot(time, reducedData$Global_reactive_power, 
     type = "l", 
     xlab = "datetime",
     ylab = "Global_reactive_power",
     main = ""
)

dev.off()
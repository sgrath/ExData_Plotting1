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

#Plot 2 

#Needed as I usually have a German system (Do -> Thu, Fr -> Fri, Sa -> Sat)
Sys.setlocale("LC_ALL", "English")

#Modify Date and Time column as Date class (POSIXt) for proper time stamp
time <- strptime(paste(reducedData$Date, reducedData$Time),
                 format='%d/%m/%Y %T', tz='UTC')

png(filename = "plot2.png", width = 480, height = 480)
plot(time, reducedData$Global_active_power, 
     #xaxt = "n",
     type = "l", 
     xlab = "",
     ylab = "Global active power (kilowatts)",
     main = ""
)
dev.off()

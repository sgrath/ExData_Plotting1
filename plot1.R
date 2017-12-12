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

#Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(reducedData$Global_active_power,
     main = "Global Active Power",
     xlab = "Global active power (kilowatts)",
     col = "red"
)
dev.off()

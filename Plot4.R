##This will read the data in the file household_power_consumption.txt that should be in the working directory
##The data read will be for two days (2007-02-01 and 2007-02-02)
##With the data we will create some plots as the ones in Readme.MD
##And export the plots to PNG in the working dir, 480x480 pixels

##first we need a function to get the subset of data - this is identical for all 4 plots
loadPowerData <- function(fileName) {
        dtPower <- read.csv("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", nrows = 2100000)
        dtPower$datetime <- strptime(paste(dtPower$Date, dtPower$Time), "%d/%m/%Y %H:%M:%S")  ##create a datetime column
        dtPower$Date <- as.Date(dtPower$Date, "%d/%m/%Y")   ##setting the date column as date
        
        ##subsetting the dataframe
        subset(dtPower, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
}


##get the data
dtPower <- loadPowerData("./household_power_consumption.txt")



##create the PNG dev
png("plot4.png", width = 480, height = 480)

##set the row and columns as 2x2
par(mfrow = c(2,2))

##plot the data

##top left
with(dtPower, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

##top right
with(temp, plot(datetime, Voltage, type = "l"))

##bottom left
with(dtPower, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))  ##create the plot area
with(dtPower, lines(datetime, Sub_metering_1, col = "black"))   ##add sub metering 1
with(dtPower, lines(datetime, Sub_metering_2, col = "red"))   ##add sub metering 2
with(dtPower, lines(datetime, Sub_metering_3, col = "blue"))   ##add sub metering 3
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

##bottom right
with(dtPower, plot(datetime, Global_reactive_power, type = "l"))

##close the dev!!
dev.off()


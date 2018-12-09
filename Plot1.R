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
png("plot1.png", width = 480, height = 480)

##plot the data
with(dtPower, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power"))

##close the dev!!
dev.off()

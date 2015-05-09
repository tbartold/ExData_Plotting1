# conditionally download and unzip the data file required
if(!file.exists("household_power_consumption.zip")) {
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
}
if(!file.exists("household_power_consumption.txt")) {
    unzip("household_power_consumption.zip")
}

# read in the table using the format the text file uses
power<-read.table("household_power_consumption.txt",na.strings="?",header=TRUE,sep=";")

# convert dates to a better format
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

# select two days worth of data
twodays <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]

# create a vector composite of date and time
datetime <- as.POSIXct(paste(twodays$Date,twodays$Time))

# prepare a png file as the device
png(file="plot4.png", width=480, height=480)

# create 2 x 2 grid for plots
par(mfrow=c(2,2))

# generate the plot upper left
plot(datetime, twodays$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# generate the upper right plot
plot(datetime, twodays$Voltage, type="l", ylab="Voltage")

# generate the lower left plot
plot(datetime, twodays$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, twodays$Sub_metering_2, col="red")
lines(datetime, twodays$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1), bty="n")

# generate the lower right plot
plot(datetime, twodays$Global_reactive_power, type="l", ylab="Global_reactive_power")

# save the plot(s) to a png file
dev.off()

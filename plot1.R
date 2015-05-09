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

# prepare a png file as the device
png(file="plot1.png", width=480, height=480)

# generate a histogram plot
hist(twodays$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

# save the plot to a png file
dev.off()

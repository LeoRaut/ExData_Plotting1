
# Quick check to see if you actually have the file in the local directory. 
# Could extend it to include a download mechanism if you don't but that's for another time.
analysis_file <- "household_power_consumption.txt"

if(!file.exists(analysis_file)){
  stop("file: household_power_consumption.txt does not exist in your current working directory. ")
}

# Gather the household data
hh_data <- read.csv("household_power_consumption.txt", sep=";")

# Reformat the data to be in easier to analyse formats
hh_data$Time <- strptime(paste(hh_data$Date, hh_data$Time), format="%d/%m/%Y%H:%M:%S")
hh_data$Date <- as.Date(hh_data$Date, format="%d/%m/%Y")

hh_data$Global_active_power <- as.numeric(as.character(hh_data$Global_active_power))
hh_data$Global_reactive_power <- as.numeric(as.character(hh_data$Global_reactive_power))

hh_data$Sub_metering_1 <- as.numeric(as.character(hh_data$Sub_metering_1))
hh_data$Sub_metering_2 <- as.numeric(as.character(hh_data$Sub_metering_2))
hh_data$Sub_metering_3 <- as.numeric(as.character(hh_data$Sub_metering_3))

hh_data$Voltage <- as.numeric(as.character(hh_data$Voltage))

# Subset the dataset to only include the two days as requested
hh_data <- subset(hh_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# The data subsetting seems a bit space ineffective, especially since you repeat it with each plot. Could try something like caching it like in one of the R examples? 
# Doesn't take too long with this data set so doesn't really matter..




## Plot 4,  trying to recreate the looks of the example one!
png(file="plot4.png", width=480, height=480)

# Setup the 2 by 2 graphics window to get all 4 graphs
par(mfrow=c(2,2))

with(hh_data, plot(Time, Global_active_power, type="l", ylab="Global Active Power", xlab=""))
with(hh_data, plot(Time, Voltage, type="l", ylab="Voltage", xlab="datetime"))
plot(hh_data$Time, hh_data$Sub_metering_1, type="l", ylab="Energy sub metering",  xlab="")
lines(hh_data$Time, hh_data$Sub_metering_2, type="l", col="red")
lines(hh_data$Time, hh_data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

with(hh_data, plot(Time, Global_reactive_power, type="l", xlab="datetime"))
dev.off()
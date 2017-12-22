

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


## Plot 2, trying to recreate the looks of the example one!
png(file="plot2.png", width=480, height=480)

with(hh_data, plot(Time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

dev.off()
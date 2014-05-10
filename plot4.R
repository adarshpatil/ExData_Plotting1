# plot4.R - Multiple plots line plot of 
#           global active power    |         voltage
#               submetering        |     global reactive power

# read data from file
data <- read.table("household_power_consumption.txt", 
                   colClasses = c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"), 
                   header=TRUE, sep=";", na.strings="?")

# Convert to date using strptime
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# subset to 2 days in February
subset_data <- subset(data, 
                      as.Date(DateTime) >= as.Date("2007-02-01") & 
                          as.Date(DateTime) <= as.Date("2007-02-02"))


# Open PNG graphics device plot3.png
png("plot4.png", height=480, width=480)


# Set up Multiple plots 2x2 canvas
par(mfrow=c(2,2))

# Sub_Plot1 - Global Active Power plot
plot(subset_data$DateTime, subset_data$Global_active_power, pch=NA, 
     xlab="", ylab="Global Active Power")
lines(subset_data$DateTime, subset_data$Global_active_power)

# Sub_Plot2 - Voltage plot
plot(subset_data$DateTime, subset_data$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(subset_data$DateTime, subset_data$Voltage)

# Sub_Plot3 - Submetering plot
plot(subset_data$DateTime, subset_data$Sub_metering_1, pch=NA, 
     xlab="", ylab="Energy sub metering")
lines(subset_data$DateTime, subset_data$Sub_metering_1)
lines(subset_data$DateTime, subset_data$Sub_metering_2, col='red')
lines(subset_data$DateTime, subset_data$Sub_metering_3, col='blue')
legend('topright', col = c('black', 'red', 'blue'), lty = c(1,1,1),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = 'n')

# Sub_Plot4 - Global reactive power plot
with(subset_data, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(subset_data, lines(DateTime, Global_reactive_power))

# Close PNG graphics device
dev.off()
# plot3.R - Line Graph of Global Active Power by sub_meter

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
png("plot3.png", height=480, width=480)

# Plot graph with pch=NA and use lines to connect
plot(subset_data$DateTime, subset_data$Sub_metering_1, pch=NA, 
     xlab="", ylab="Energy sub metering")

lines(subset_data$DateTime, subset_data$Sub_metering_1)
lines(subset_data$DateTime, subset_data$Sub_metering_2, col='red')
lines(subset_data$DateTime, subset_data$Sub_metering_3, col='blue')

# Show Legend
legend("topright", col = c('black', 'red', 'blue'), lty = c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close PNG graphics device
dev.off()
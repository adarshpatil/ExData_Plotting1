# plot2.R - Line plot of Global Active Power


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

# Open png graphics device plot2.png
png("plot2.png", height=480, width=480)


# Plot graph with pch=NA and use lines to connect
plot(subset_data$DateTime, subset_data$Global_active_power, pch=NA, 
     xlab="", ylab="Global Active Power (kilowatts)")

lines(subset_data$DateTime, subset_data$Global_active_power)

# Close PNG graphics device
dev.off()
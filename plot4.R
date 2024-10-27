#Library packages we need
library(data.table)

# Select data of specific dates
data_all <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

# Convert date variables
data_all[, Date := as.Date(Date, format = "%d/%m/%Y")]

# Select data from specific dates
data_all <- data_all[Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")]

data_all[, datetime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# Plotting and save figures
# set 2x2 subplots
par(mfrow = c(2, 2))

# plotting foure subplots
plot(data_all$Global_active_power ~ data_all$datetime, type = "l", ylab = "Global Active Power", 
     xlab = "")
plot(data_all$Voltage ~ data_all$datetime, type = "l", ylab = "Voltage", xlab = "")
plot(data_all$Sub_metering_1 ~ data_all$datetime, type = "l", ylab = "Energy sub metering", 
     xlab = "")
lines(data_all$Sub_metering_2 ~ data_all$datetime, col = "Red")
lines(data_all$Sub_metering_3 ~ data_all$datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(data_all$Global_reactive_power ~ data_all$datetime, type = "l", ylab = "Global Reactive Power", 
     xlab = "")

# save figures
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
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
png(filename = "plot3.png", width = 480, height = 480)
plot(data_all$Sub_metering_1 ~ data_all$datetime, type = "l", 
     ylab = "Energy sub metering", xlab = "Time", col = "black")
lines(data_all$Sub_metering_2 ~ data_all$datetime, col = "Red")
lines(data_all$Sub_metering_3 ~ data_all$datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
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
png(filename = "plot2.png", width = 480, height = 480)
plot(data_all$Global_active_power ~ data_all$datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "Time")
dev.off()
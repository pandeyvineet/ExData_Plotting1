# Read data
hpc <- read.csv("~/household_power_consumption.txt", 
                sep=";", na.strings = "?")

# Combine date and time, format it and add it to the data frame
datetime <- paste(hpc$Date, hpc$Time)
datetime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
hpc <- cbind(datetime, hpc)
# Convert Date column to date class
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
# Subset: first two days of Feb 2007

# Read data
hpc2 <- subset(x = hpc, subset = Date == "2007-02-01" | Date == "2007-02-02")

### PLOT
# 4 plots: Global active power, voltage, energy sub metering, 
# global reactive power
png("plot4.png")
par("mar") # 5.1 4.1 4.1 2.1
par(mar = c(4, 4, 4, 3))
par(mfrow = c(2, 2))

plot(hpc2$datetime, hpc2$Global_active_power, type = "l", xlab = " ",
     ylab = "Global active power")

plot(hpc2$datetime, hpc2$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

plot(hpc2$datetime, hpc2$Sub_metering_1, type="l", xlab = " ",
     ylab = "Energy sub metering")
lines(hpc2$datetime, hpc2$Sub_metering_2, col = "red", type = "l")
lines(hpc2$datetime, hpc2$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 2, col = c("black", "blue", "red"), 
       legend = colnames(hhp2[, 8:10]), bty = "n")

plot(hpc2$datetime, hhp2$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
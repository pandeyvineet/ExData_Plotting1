# Read data
hpc <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Combine date and time, format it and add it to the data frame
datetime <- paste(hpc$Date, hpc$Time)
datetime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
hpc <- cbind(datetime, hpc)
# Convert Date column to date class
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
# Subset: first two days of Feb 2007
hpc2 <- subset(x = hpc, subset = Date == "2007-02-01" | Date == "2007-02-02")

### PLOT
# Sub_metering time series plots
png("plot3.png")
plot(hpc2$datetime, hpc2$Sub_metering_1, type="l", xlab = " ",
     ylab = "Energy sub metering")
lines(hpc2$datetime, hpc2$Sub_metering_2, col = "red", type = "l")
lines(hpc2$datetime, hpc2$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 2, col = c("black", "blue", "red"), 
       legend = colnames(hpc2[, 8:10]))
dev.off()
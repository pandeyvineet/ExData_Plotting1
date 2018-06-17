
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
# Time series plot
png("plot2.png")
plot(hhp2$datetime, hpc2$Global_active_power, type = "l", xlab=" ", 
     ylab="Global active power (kilowatts)")
dev.off()
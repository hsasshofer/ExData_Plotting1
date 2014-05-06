workdir= file.path("", "home", "hms", "work", "R", "Ass", "ProgrammingAssignment3", "ExData_Plotting1")

read_data <- function() {
    data <- read.csv(file.path(workdir, "household_power_consumption.txt"), 
                     colClasses= "character", na.strings="?", sep= ";", stringsAsFactors = FALSE)
    data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
    data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    for (col in c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        data[[col]] <- as.numeric(data[[col]])
    data
}

data <- read_data()
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
png(file.path(workdir, "plot4.png"), width = 480, height = 480)
par(mfrow= c(2,2))

plot (data$Time, data$Global_active_power, type="n", 
      xlab= "", ylab= "Global Active Power",
      ylim=c(min(data$Global_active_power), 
             max(data$Global_active_power)))
lines (data$Time, data$Global_active_power, type="l")

plot (data$Time, data$Voltage, type="n", 
      xlab= "datetime", ylab= "Voltage",
      ylim=c(min(data$Voltage), 
             max(data$Voltage)))
lines (data$Time, data$Voltage, type="l")

plot (data$Time, data$Sub_metering_1, type="n", 
      xlab= "", ylab= "Energy sub metering", 
      ylim=c(min(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3)), 
             max(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))))
lines (data$Time, data$Sub_metering_1, type="l", col="black")
lines (data$Time, data$Sub_metering_2, type="l", col="red")
lines (data$Time, data$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lty= 1, bty= "n",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot (data$Time, data$Global_reactive_power, type="n", 
      xlab= "datetime", ylab= "Global_reactive_power",
      ylim=c(min(data$Global_reactive_power), 
             max(data$Global_reactive_power)))
lines (data$Time, data$Global_reactive_power, type="l")

dev.off()
Sys.setlocale("LC_TIME", lct)
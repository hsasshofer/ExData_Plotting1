workdir= file.path("", "home", "hms", "work", "R", "Ass", "ProgrammingAssignment3", "ExData_Plotting1")

read_data <- function() {
    data <- read.csv(file.path(workdir, "household_power_consumption.txt"), 
                     colClasses= "character", na.strings="?", sep= ";", stringsAsFactors = FALSE)
    data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
    data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    data$Global_active_power <- as.numeric(data$Global_active_power)
    data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
    data$Voltage <- as.numeric(data$Voltage)    
    data$Global_intensity <- as.numeric(data$Global_intensity)
    data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
    data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
    data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
    data
    
}

data <- read_data()
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
png(file.path(workdir, "plot2.png"), width = 480, height = 480)
plot (data$Time, data$Global_active_power, type="n", 
      xlab= "", ylab= "Global Active Power (kilowatts)",
      ylim=c(min(data$Global_active_power), 
             max(data$Global_active_power)))
lines (data$Time, data$Global_active_power, type="l")
dev.off()
Sys.setlocale("LC_TIME", lct)
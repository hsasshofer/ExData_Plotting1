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
png(file.path(workdir, "plot3.png"), width = 480, height = 480)
plot (data$Time, data$Sub_metering_1, type="n", 
      xlab= "", ylab= "Energy sub metering", 
      ylim=c(min(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3)), 
             max(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))))
lines (data$Time, data$Sub_metering_1, type="l", col="black")
lines (data$Time, data$Sub_metering_2, type="l", col="red")
lines (data$Time, data$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lty= 1, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
Sys.setlocale("LC_TIME", lct)
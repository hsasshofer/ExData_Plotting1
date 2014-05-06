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
png(file.path(workdir, "plot2.png"), width = 480, height = 480)
with (data, {
    plot (Time, Global_active_power, type="n", 
          xlab= "", ylab= "Global Active Power (kilowatts)")
    lines (Time, Global_active_power, type="l")
})
dev.off()
Sys.setlocale("LC_TIME", lct)
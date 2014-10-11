# -----------------------------------------------------
# read in the data file
# -----------------------------------------------------

data <- read.table('../../household_power_consumption.txt', sep = ';', header = TRUE, 
                   stringsAsFactors = FALSE)
plotData <- data[data$Date %in% c('1/2/2007', '2/2/2007'),]

# remove the large data frame as we have subset the relevant part
rm(data)

# Create a column with date as column 1
# Create a date time as the second column
columns <- colnames(plotData)
dateTime <- data.frame(paste(plotData[,1], plotData[,2]))
dateTime <- cbind(data.frame(as.Date(dateTime[,1], '%m/%d/%Y')), 
                  data.frame(strptime(dateTime[,1], '%d/%m/%Y %H:%M:%S')))
colnames(dateTime) = c('Date', 'Date_Time')
plotData <- cbind(dateTime[,], plotData[,3:9])

# draw the plot
png(filename = 'figure/plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
with(plotData, {
    plot(Date_Time, Global_active_power, type = 'l', xlab = '', 
         ylab = 'Global Active Power')
    plot(Date_Time, Voltage, type = 'l', xlab = 'datetime', 
         ylab = 'Voltage')
    plot(Date_Time,Sub_metering_1, xlab = '', type = 'l',
         ylab = 'Energy sub metering')
    lines(Date_Time, Sub_metering_2, col = 'red')
    lines(Date_Time, Sub_metering_3, col = 'blue')
    legend(x='topright', col = c('black', 'red', 'blue'), 
           legend = colnames(plotData[,7:9]), lty=1, bty = 'n', cex = 0.8)
    plot(Date_Time, Global_reactive_power, type = 'l', xlab = 'datetime', 
         ylab = 'Global_reactive_power')
})
dev.off()
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
png(filename = 'figure/plot2.png', width = 480, height = 480)
plot(plotData$Date_Time, plotData$Global_active_power, type = 'l', xlab = '', 
     ylab = 'Global Active Power (kilowatts)')
dev.off()
#Getting and cleaning the Data

#get data
	fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileURL,destfile="./Project 1.zip")
	unzip(zipfile = "./Project 1.zip",exdir="./Project 1")
	path_rf <- file.path("./Project 1")

#load and subset data
	power.consumption<-read.table("./Project 1/household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
	power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]
	
#add column names
	cols<-c('Date','Time','ActivePower','ReactivePower','Voltage','Intensity',
          'SubMetering1','SubMetering2','SubMetering3')
	colnames(power.consumption)<-cols
	
#add column that features both date and time
	power.consumption$DateTime <- paste(power.consumption$Date,power.consumption$Time)
	power.consumption$DateTime <- strptime(power.consumption$DateTime,"%d/%m/%Y %H:%M:%S")
	
# make sure the plots folder exists
if (!file.exists('plots')) {
  dir.create('plots')
}

# open device
png(filename='plots/plot2.png',width=480,height=480,units='px')

# plot data
plot(power.consumption$DateTime,power.consumption$ActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

# close device
dev.off()
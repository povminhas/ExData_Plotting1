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
	png(filename='plots/plot3.png',width=480,height=480,units='px')

# make 4 plots
	par(mfrow = c(2,2))

#plot data on top left
	plot(power.consumption$DateTime,power.consumption$ActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

#plot data on top right
	plot(power.consumption$DateTime,power.consumption$Voltage,xlab='datetime',ylab='Voltage',type='l')
	
#plot data on bottom left
	lncol<-c('black','red','blue')
	lbls<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
	plot(power.consumption$DateTime,power.consumption$SubMetering1,type='l',col=lncol[1],xlab='',ylab='Energy sub metering')
	lines(power.consumption$DateTime,power.consumption$SubMetering2,col=lncol[2])
	lines(power.consumption$DateTime,power.consumption$SubMetering3,col=lncol[3])
	legend('topright',legend=lbls,col=lncol,lty='solid')

#plot data on bottom right
	plot(power.consumption$DateTime,power.consumption$ReactivePower,xlab='datetime',ylab='Global_reactive_power',type='l')

# close device
	dev.off()
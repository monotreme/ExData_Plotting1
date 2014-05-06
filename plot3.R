# programming assignment 1 Plot3

myReadData <- function()
{
  ##read data from file 
  # it would be nice to read in only the required data, so try reading these directly first.  
  #If, however, the data is not the same as expected, then read the whole file and subset it by date.
  # get column names from file
  cnames <- names(read.table("~/R course/ExData_Plotting1/household_power_consumption.txt", sep=";", quote="\"",
                             header=TRUE,nrow=1))
  
  ## read in only required data
  expected_rows = 2880
  skipped_rows = 66637
  date_format = "%d/%m/%Y"
  time_format = "%"
  myWarning = "Reading partial file has not resulted in expected data.  Reading complete file."
  household_power_consumption <- 
    household_power_consumption <- 
    read.table("~/R course/ExData_Plotting1/household_power_consumption.txt", sep=";", quote="\"",
               header=FALSE, col.names=cnames,skip=skipped_rows,nrow=expected_rows,
               colClasses=c("factor","factor",rep("numeric",7)))
  
  # check that we have the expected number of time periods for the nominated two days: i.e. 2880
  ## set up vector containing required dates
  rd <- c(strptime("01/02/2007","%d/%m/%Y"),strptime("02/02/2007","%d/%m/%Y"))
  ## place subset of required dates in hpc
  hpc <-subset(household_power_consumption, strptime(household_power_consumption$Date,"%d/%m/%Y") %in% rd)
  if(nrow(hpc) != expected_rows){# we don't have the required data. So, instead of taking a shortcut, read the entire file
    warning(paste(nrow(hpc), "rows found in required date range.", expected_rows,"expected."))
    warning(myWarning)
    household_power_consumption <- read.table("~/R course/ExData_Plotting1/household_power_consumption.txt", sep=";", quote="\"",
                                              header=TRUE,colClasses=c("factor","factor",rep("numeric",7)))  
    hpc <-subset(household_power_consumption, strptime(household_power_consumption$Date,"%d/%m/%Y") %in% rd)
  }
  if(nrow(hpc) != expected_rows){ warning(paste(nrow(hpc), "rows found in required date range from complete file.", expected_rows,"expected."))
  }
  
  hpc$DateTime <- strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")
  hpc # return data frame with read data, plus a column with the date/time.
}
hpc <- myReadData()
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)
plot(hpc$Sub_metering_1 ,xaxt = "n",type="n",ylab="Energy sub metering",xlab="")
lines(hpc$Sub_metering_1)
lines(hpc$Sub_metering_1)
lines(hpc$Sub_metering_2,col="red")
lines(hpc$Sub_metering_3,col="blue")
axis(1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

dev.off()
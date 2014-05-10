#JHU- Exploratory Data Analysis Project1- Plot2
#========================================================

#The supplied datafile "household_power_consumption.txt" is downloaded to my local directory, e:\courses\jh-dataexplore\ws_dataexplore
#This script show how the data is subsetted and the plot into a PNG file

#```{r grep to extract data with 2007-02-01 and 2007-02-02}
# set localdirectory 
setwd("e://courses//jh-dataexplore//ws_dataexplore")
f <- file("household_power_consumption.txt","rt");

# setup a pipe to extract data that matches 2007-02-01 and 2007-02-02
nolines <- 100
greped<-c()
repeat {
  lines=readLines(f,n=nolines)       #read lines
  idx <- grep("^[12]/2/2007", lines) #find those that match
  greped<-c(greped, lines[idx])      #add the found lines
  #
  if(nolines!=length(lines)) {
    break #are we at the end of the file?
  }
}

#now we create a text connection and load data
tc<-textConnection(greped,"rt")
df<-read.csv(tc,sep=";",header=TRUE)
close(f)

# rename the column of dataframe df into original meaningful names
names(df)[1] <- "Date"
names(df)[2] <- "Time"
names(df)[3] <- "Global_active_power"
names(df)[4] <- "Global_reactive_power"
names(df)[5] <- "Voltage"
names(df)[6] <- "Global_intensity"
names(df)[7] <- "Sub_metering_1"
names(df)[8] <- "Sub_metering_2"
names(df)[9] <- "Sub_metering_3"

#``` 
# change the date time into column into dateTime class and append to 
#  the a new data.frame df2
datetime <- as.POSIXct(strptime(paste(df$Date, df$Time),format='%d/%m/%Y %H:%M:%S'))
df2 <- cbind(df, datetime)


#  The aboves lines are exactly the same procedure as for plot2


#Plot the required graph with PNG devices

#```{r plot1, width=480px  height=480px}
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
# plot the first line with sub_metering_1, then add other lines and legend
with(df2, plot(datetime, Sub_metering_1, type="l", col="blue4", xlab="", ylab="Energy sub metering") )
with(df2, lines(datetime, Sub_metering_2, col="red") )
with(df2, lines(datetime, Sub_metering_3, col="blue") )
legend("topright", col=c("blue4","red","blue"), lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.7)

dev.off()

#```

library(lubridate)
library(rvest)

get_df <- function(month, year){
  ##Get number of days of the month
  if(month < 12){
    n_days <- day (as.Date(paste(year,month + 1,1, sep="-")) - 1)   
  }else{
    n_days <- day (as.Date(paste(year+1, 1, 1, sep="-")) - 1) 
  }
  
  url = paste("http://www.ogimet.com/cgi-bin/gsynres?ord=REV&decoded=yes&ndays=",n_days, "&ano=", year, "&mes=", month, "&day=", n_days,"&hora=24&ind=08221", sep="")
  webpage <- read_html(url)
  data_table <- html_table(html_nodes(webpage, "table table")[[2]])
  df <- data.frame(date = as.Date(data_table[-1,1], format="%d/%m/%Y"), hour= data_table[-1,2], "T(C)" = data_table[-1,3], "ddd" = data_table[-1,7], "ff-kmh" = data_table[-1,8], stringsAsFactors = FALSE)  
}

result <- lapply(1:12, get_df, 2008 )

df <- do.call("rbind", result)

colnames(df) <- c("date", "hour", "T(C)", "ddd", "ff kmh")

sorted_df<- df[order(df[,1], df[,2]),]


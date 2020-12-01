#' for, box, list, rbindlist

library(data.table)
library(rvest)
car_links <- c('https://www.ultimatespecs.com/car-specs/BMW/M9639/X2-F39',
                'https://www.ultimatespecs.com/car-specs/Chrysler/M8452/300C-Touring',
               'https://www.ultimatespecs.com/car-specs/Peugeot/122261/Peugeot-Expert-Traveller-e-Traveller-Long-50kWh-VIP.html')
               
my_link <- 'https://www.ultimatespecs.com/car-specs/Peugeot/122261/Peugeot-Expert-Traveller-e-Traveller-Long-50kWh-VIP.html'
# key value
# column name and value

t <- read_html(my_link)
data_list <- list()

tkey <- gsub(':', '', trimws(t %>% html_nodes('.tabletd') %>% html_text()), fixed = T)
# tkey <- t %>% html_nodes('.tabletd') %>% html_text(trim = TRUE)
tvalues <- t %>% html_nodes('.tabletd_right') %>% html_text()

if(length(tkey) == length(tvalues)){
  for (key_id in 1:length(tvalues)) {
    # name of the value
    data_list[[ tkey[key_id] ]] <- tvalues[key_id]
  }
}

process_one_car <- function(my_link){
  my_link <- 'https://www.ultimatespecs.com/car-specs/Peugeot/122261/Peugeot-Expert-Traveller-e-Traveller-Long-50kWh-VIP.html'
  # key value
  # column name and value
  
  t <- read_html(my_link)
  data_list <- list()
  data_list[['link']] <- my_link
  data_list[['name']] <- t %>% html_node('.breadcrumb') %>% html_text()
  
  tkey <- gsub(':', '', t %>% html_nodes('.tabletd') %>% html_text(trim = TRUE), fixed = T)
  # tkey <- t %>% html_nodes('.tabletd') %>% html_text(trim = TRUE)
  tvalues <- t %>% html_nodes('.tabletd_right') %>% html_text(trim = TRUE)
  
  if(length(tkey) == length(tvalues)){
    for (key_id in 1:length(tvalues)) {
      # name of the value
      data_list[[ tkey[key_id] ]] <- tvalues[key_id]
    }
  }
  
  return(data_list)
}

what <- process_one_car(my_link)
what
# converting list to dataframe
what_df <- rbindlist(lapply(car_links, process_one_car))

# t() is function, transports the dataframe, switch the columns

# breadcrumb 
# values top
# values in the middle



library(jsonlite)

df <- fromJSON('https://www.nasdaq.com/api/v1/screener?page=4&pageSize=20')
# count - 8258 stocks

tdf <- df$data
# this is a dataframe itself
tdf$dividendData

# here dividendData was a column (column containing dataframe)

df <- fromJSON('https://www.nasdaq.com/api/v1/screener?page=4&pageSize=20', flatten = TRUE)
tdf <- df$data

# but here dividendData is not column, its simply df
tdf$dividendData.dividend

# ?cbind()


tdf$articles
# empty. so lets delete

tdf$articles <- NULL


# get how much the price changed in last 7 days in percentage
tdf$priceChartSevenDay

# this is a dataframe
x <- tdf$priceChartSevenDay[1]

lapply(tdf$priceChartSevenDay, function(x){
  if(nrow(x) == 0){
    return(0)
  } else {
    first_value <- head(x$price, 1)
    last_value <- tail(x$price, 1)
    price_change <- (((last_value/first_value)-1)*100)
    return(price_change)
  }
  
 
  })

# what we see is a list of list

# with unlist we made a dataframe that contains normal vectors


# task 2
# function arg: page number
# apply your function to get 1000 biggest companies


# skyscanner api documentation >> travel apis
# quotes is flights

# task 3
# 

# https://www.skyscanner.hu/
# https://www.nasdaq.com/api/v1/screener?page=1&pageSize=20
# nasdaq company list
# https://www.nasdaq.com/market-activity/stocks/screener




# if you use read_html with NASDAQ, you cant read data because it is not loaded yet
# NASDAQ >> Network >> Reload >> screener?page=1&pageSize=20 >> sector: "technology"
# sectorName: "Technology"
# ticker: "AAPL
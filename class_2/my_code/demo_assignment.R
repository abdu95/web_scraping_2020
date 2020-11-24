

# posted_date <- 
#  file_html %>% 
#  html_nodes('.c-byline__item span') %>% 
#  html_text() 


# author <- 
#  file_html %>% 
#  html_nodes('.c-byline__item') %>% 
#  .[[2]] %>% 
#  html_text() 

paste0('https://insidebigdata.com/page/', 2:5, '/?s=big+data')
# character vector of 4 items
item <- paste0('https://insidebigdata.com/page/', 2:5, '/?s=big+data')       
str(item)
class(item)


results <- file_html %>% html_nodes('.c-byline__item')

second_result <- results[2]
second_result %>% html_nodes("time")
date <- second_result %>% html_nodes("time") %>% html_text(trim = TRUE)

xml_contents(second_result)



# alternative for trim = TRUE:
# author <- gsub("[\n]", "", author)
# author <- trimws(author)
# if date contains Updated, remove Updated

#dates <- file_html %>% 
#  html_nodes('time') %>% 
#  html_attrs() %>% 
#  map(1) %>% 
#  # Parse the string into a datetime object with lubridate
#  ymd_hms() %>%                 
#  unlist()



get_one_page_from_techworld  <- function(my_url) {
  print(my_url)
  t <- read_html(my_url)
  boxes <- t %>% 
    html_nodes('.shadow')
  x <- boxes[[1]]
  boxes_df <- lapply(boxes, function(x){
    t_list <- list()
    t_list[['title']] <- x %>% html_nodes('.searchtitle') %>% html_text()
    t_list[['link']] <- x %>% html_nodes('.searchtitle') %>% html_attr('href')
    t_list[['teaser']] <-  paste0(x %>% html_nodes('p') %>% html_text(), collapse = ' ')
    return(data.frame(t_list))  
  })
  df <- rbindlist(boxes_df)
  return(df)
}

my_url <- 'https://www.technewsworld.com/perl/search.pl?x=16&y=10&query=big+data'
result_df <- get_one_page_from_techworld(my_url)




my_demo_fun <- function(x,y) {
  return((x+y)^2)
}

lapply(my_list, my_demo_fun, y=2)
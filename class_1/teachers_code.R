library(rvest)
get_insidebigdata_page <- function(my_url) {
  print(my_url)
  t <- read_html(my_url)
  #write_html(t, 't.html')
  titles <- 
    t %>% 
    html_nodes('.entry-title-link') %>% 
    html_text()
  times <- 
    t %>% 
    html_nodes('.time') %>% 
    html_text()
  my_link <- 
    t %>% 
    html_nodes('.entry-title-link') %>% 
    html_attr('href')
  text_summary <- 
    t %>% 
    html_nodes('#content p') %>% 
    html_text()
  df <- data.frame('title'=titles, 'links'= my_link, 'summary'= text_summary)  
  return(df)
}
t_urls <- paste0('https://insidebigdata.com/page/', 2:5, '/?s=big+data' )
t <- get_insidebigdata_page('https://insidebigdata.com/page/2/?s=big+data')
df_list <- lapply(t_urls, get_insidebigdata_page)
df <- rbindlist(df_list)
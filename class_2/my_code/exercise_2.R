library(rvest)
library(data.table)

url <- 'https://www.technewsworld.com/perl/search.pl?x=0&y=0&query=big+data'
t <- read_html(url)

boxes <- 
    t %>% 
    html_nodes('.shadow')
  
  box_dfs <- lapply(boxes, function(x){
    tlist <- list()
    tlist[['my_title']] <- 
      x %>% 
      html_nodes('.searchtitle')%>%
      html_text()
    
    my_relative_link <- 
      x%>% 
      html_nodes('.headline-link')%>%
      html_attr('href')
    
    tlist[['my_link']] <- paste0('https://www.economist.com/', my_relative_link)
    
    tlist[['my_teaser']] <-
      x %>% 
      html_nodes('.teaser__text')%>%
      html_text()
    
    #
    
    return(tlist)
    
  })


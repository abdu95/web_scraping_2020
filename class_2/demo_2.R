tl <- list()

tl[['first_element']] <- 2

tl
#named variable
tl$second_element <- 'ceu'

tl[['first_vector']] <- 1:10
tl$first_vector

tl[['cars']] <- mtcars
tl$cars

list_2 <- list('a'=2, b=1:10, c=mtcars)
# why quote used and not used?

# [[]] - we are writing a key of a list
# named list
temp_list <- letters
  
for (i in 1:length(letters)) {
  tl[[paste0('letters_', i)]] <- letters[i]
}

# [] - returns list
# [[]] -returns character

names(tl)

notnamed_list <- list()
for (i in 1:length(letters)) {
  notnamed_list[[i]] <- letters[i]
}

names(notnamed_list)

str(notnamed_list[1])
str(notnamed_list[[1]])

library(jsonlite)
tl

#toJSON is a function creates JSON object from list
toJSON(tl)

# weird thing: 0:2
# because our characters became list

# this fixes problem
toJSON(tl, auto_unbox = T)

toJSON(tl, auto_unbox = T, pretty = T)

write_json(tl, path = 'my_res.json', auto_unbox = T, pretty = T)

from_list <- fromJSON('my_res.json')

getwd()


# get a box, list of dataframe


# economist ---------------------------------------------------------------
library(rvest)
library(data.table)

my_url <- 'https://www.economist.com/finance-and-economics/'


get_economist <- function(my_url){
  t <- read_html(my_url)
  
  boxes <- t %>% 
    html_nodes('.teaser')
  
  x <- boxes[[1]]
  
  boxes_dfs <- lapply(boxes, function(x){
    #create and put element to list
    tl <- list()
    tl[['title']] <- x %>% html_nodes('.headline-link') %>% html_text()
    tl[['link']] <- paste0('https://www.economist.com', x %>% html_nodes('.headline-link') %>% html_attr('href'))
    tl[['teaser']] <- x %>% html_nodes('.teaser__description') %>% html_text()
    
    # dataframe out of list
    return(data.frame(tl))
  })
  
  df <- rbindlist(boxes_dfs, fill = T)
  # rbindlist takes list of list or list of dataframes
  return(df)
}

View(data.frame(tl))
View(data.table(tl))

df <- get_economist('https://www.economist.com/finance-and-economics/?page=3')


# when he changed dataframe to list - problem solved

# function requires URL
# number of pages
# if you can, keyword also

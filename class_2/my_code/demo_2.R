# Option 1: we can declare a list and assign values later with [[]] or $
tl <- list()

# assign values of a list with [[]] 
tl[['first_element']] <- 2

tl
# assign values of a list with $
#named variable
tl$second_element <- 'ceu'

tl[['first_vector']] <- 1:10
tl$first_vector

tl[['cars']] <- mtcars
tl$cars
# now list contains number, character, vector and dataframe


# Option 2: we can declare a list and assign values immediately
# elements of list can be written with ('a') and w/out quotes (b)
list_2 <- list('a'=2, b=1:10, c=mtcars)
# why quote used and not used?

# [[]] - we are writing a key of a list
# named list
temp_list <- letters


#existing elements of list is staying as they are, we are just adding new elements
for (i in 1:length(letters)) {
  tl[[paste0('letters_', i)]] <- letters[i]
}

# show the names of elements of a list
names(tl)

notnamed_list <- list()
for (i in 1:length(letters)) {
  notnamed_list[[i]] <- letters[i]
}

names(notnamed_list)
# returns NULL
# just numbers [[1]], [[2]] assigned as a name of elements

# [] - returns list
list_of_one_element <- notnamed_list[1]

str(notnamed_list[1])
# $: chr "a"
class(notnamed_list[1])
# "list"

# [[]] -returns character
char_type <- notnamed_list[[1]]

str(notnamed_list[[1]])
# chr "a"

class(notnamed_list[[1]])
# "character"

str(mtcars)
# data.frame
as.character(2)

library(jsonlite)
tl

#toJSON is a function creates JSON object from list
toJSON(tl)

json_object <- toJSON(tl)
json_object
str(json_object)
# 'json' chr {}


# weird thing: 0:2, 0: 'ceu. our characters became list
# each element became a list (values of a list elements became list themselves)
# list elements values turne into key value: key is the position, value is list elements value

# time 9:00
# "letter_20":["t"] >> it is a list as it has square bracket

# this fixes problem
toJSON(tl, auto_unbox = T)
# "letter_20":"t" >> square bracket disappeared

# formats text as JSON
toJSON(tl, auto_unbox = T, pretty = T)

write_json(tl, path = 'my_res.json', auto_unbox = T, pretty = T)

# reading JSON object (you can pass website as well)

from_list <- fromJSON('my_res.json')
# reading back JSON into JSON object

getwd()
# ctrl + shift + H >> set working directory


# economist ---------------------------------------------------------------
library(rvest)
library(data.table)

# title, teaser, link
# get box, create list, list will return dataframe
my_url <- 'https://www.economist.com/finance-and-economics/'


get_economist <- function(my_url){
  t <- read_html(my_url)
  
  # boxes is a list of 12 elements (xml_nodeset)
  boxes <- t %>% 
    html_nodes('.teaser')
  
  # list of 2 elements: xml_node
  x <- boxes[[1]]
  
  #'lapply gets boxes, creates a list, 
  #'assigns t/l/t of a box as a element to list, 
  #'converts list to dataframe and returns it
  boxes_dfs <- lapply(boxes, function(x){
    #create and put element to list
    tl <- list()
    tl[['title']] <- x %>% html_nodes('.headline-link') %>% html_text()
    tl[['link']] <- paste0('https://www.economist.com', x %>% html_nodes('.headline-link') %>% html_attr('href'))
    tl[['teaser']] <- x %>% html_nodes('.teaser__description') %>% html_text()
    
    # tl is a named list with 3 elements
    
    # dataframe out of list
    View(data.frame(tl))
    return(data.frame(tl))
  })
  
  # if any value has character 0, then fill = T fixes it >> empty string
  df <- rbindlist(boxes_dfs, fill = T)
  # rbindlist takes list of list or list of dataframes
  return(df)
}

View(data.frame(tl))
# data table is not working properly with list
View(data.table(tl))

df <- get_economist('https://www.economist.com/finance-and-economics/?page=3')

# when he changed dataframe to list - problem solved
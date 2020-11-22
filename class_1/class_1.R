
# lapply ------------------------------------------------------------------

my_list <- 1:10

my_list^2

my_numbers <- NULL
for (variable in my_list) {
  my_numbers <- c(my_numbers, variable^2)
}

lapply(1:10, function(x){
  return(x^2)
})


#1st element is a vector
#2nd element is a function. function will be applied to each element of vector

my_square <- function(x){
  return(x^2)
}

lapply(1:10, my_square)

#Exercise
to_upper <- function(x){
  return(paste0("#", toupper(x), "#"))
}

lapply(letters, to_upper)

result_list <- lapply(letters, to_upper)
result_vector <- sapply(letters, to_upper)

# lapply - returns list
# sapply - returns vector

#3rd element 
result_list[[3]]
str(result_list[[3]])

#making sapply of lapply

result_unlist <- unlist(
  lapply(letters, function(x){
    return(paste0("#", toupper(x), "#"))
  })
)


#sapply - Named chr [1:26] - named character vector
#unlist - chr [1:26] - just vector



# rvest -------------------------------------------------------------------

library(rvest)

t <- read_html('https://www.wired.com/search/?q=big%20data&page=1&sort=score')

write_html(t, 't.html')

#10
titles <-
  t %>% 
  html_nodes('.archive-item-component__title') %>% 
  html_text

#9
times <- 
  t %>% 
  html_nodes('time') %>% 
  html_text()

#9
authors <- 
  t %>% 
  html_nodes('.byline-component__link') %>% 
  html_text()

#10
text_summary <- 
  t %>% 
  html_nodes('.archive-item-component__desc') %>% 
  html_text()

#duplicates
#20

#10
my_link <-
  unique(
  t %>% 
  html_nodes('.archive-item-component__link') %>% 
  html_attr('href'))

df <- data.frame('title' = titles, 'links' = my_link, 'summary' = text_summary, 'date' = times, fill = TRUE)

cbind('title' = titles, 'links' = my_link, 'summary' = text_summary, 'date' = times, fill = TRUE)


#list of dataframes

library(data.table)

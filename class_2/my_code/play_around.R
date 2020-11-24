# Can vector contain integer and char? No, it will convert integer to char also and creates vector of characters
check_v <- c(1, "a")
# Can vector contain a vector inside? No, it will convert inner vector elements into chars of outer vector
check_v <- c(1, "a", c(1,2))
# Can vector contain a function? No, when function given as an element of vector, this vector converted into list
check_v <- c(1, "a", c(1,2), function(){})

my_list <- c(1:10)

my_demo_fun <- function(x) {
  return(x^2)
}

result <- lapply(my_list, my_demo_fun)

result_u <- unlist(lapply(my_list, my_demo_fun))

result_s <- sapply(my_list, my_demo_fun)

# assignment hint:
author[seq(1, length(author), 3)]
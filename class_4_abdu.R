library(rvest)
library(data.table)
library(jsonlite)

# IMDB: opened html, got text, got JSON that is embedded in HTML 
t <- read_html('https://www.imdb.com/title/tt0800369/')
write_html(t, 't.html')

# without xpath it will select as css (with xpath it will select as XML?)
df <- fromJSON(t %>% html_node(xpath = '//script[@type="application/ld+json"]') %>% html_text())

p <- read_html('https://www.payscale.com/research/US/Job=Data_Scientist/Salary')
write_html(p, 'payscale.html')

# ld+json and json: difference is ld. ld does not contain data we want
pay_df <- fromJSON(p %>% html_node(xpath = '//script[@type="application/json"]') %>% html_text())

toJSON(pay_df, auto_unbox = T)
# http://jsonviewer.stack.hu/

tdf <- pay_df$props$pageProps$pageData$byDimension$`Job by Location`$rows
# list
what <- pay_df$props
# list
what <- pay_df$props$pageProps
# list
what <- pay_df$props$pageProps$pageData
# df
what <- pay_df$props$pageProps$pageData$byDimension$`Job by Location`$rows
# pink - vector & pink/green squares - list that has job property 
# it also contains dataframe


# Payscale ----------------------------------------------------------------

# getting links from each department (account, finance, IT)

# function: open each element, open each links (jobs)

# Mihalyi: scrape website every 5 seconds
# robots.txt - to show users and web scrapers what they are allowed/not allowed to scrape

# project: get salary for all jobs in Payscale

# project EU funding: https://www.palyazat.gov.hu/tamogatott_projektkereso

# countByPost
# find2

# find2 >> POST request
# form data >> Filter
# find2 >> right click >> copy >> Copy as cURL (bash). you copied curl command
# then https://curl.trillworks.com/#r
# it gives R code
# you are passing JSON object to that URL


# res is response. Status 200 - successful
# to get all data, change limit in filter
# skip is string, limit is int (its fine because its JSON)
# verbose(info=TRUE): it shows steps what curl is doing
# res/t is a list

require(httr)

headers = c(
  `Connection` = 'keep-alive',
  `Accept` = 'application/json, text/plain, */*',
  `User-Agent` = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36',
  `Content-Type` = 'application/x-www-form-urlencoded',
  `Origin` = 'https://www.palyazat.gov.hu',
  `Sec-Fetch-Site` = 'same-site',
  `Sec-Fetch-Mode` = 'cors',
  `Sec-Fetch-Dest` = 'empty',
  `Referer` = 'https://www.palyazat.gov.hu/',
  `Accept-Language` = 'en-US,en;q=0.9,uz;q=0.8,ru;q=0.7,tg;q=0.6'
)

data = list(
  `filter` = '{"where":{"fejlesztesi_program_nev":"Sz\xE9chenyi 2020"},"skip":"0","limit":10,"order":"konstrukcio_kod, palyazo_neve ASC"}'
)

res <- httr::POST(url = 'https://pghrest.fair.gov.hu/api/tamogatott_proj_kereso/find2', httr::add_headers(.headers=headers), body = data)

new_tdf <- fromJSON(content(res, 'text'))

# res shows response message of your POST request: response message is 'ok'

# find website and get most data from website: e.g. Payscale, Car (last lesson), Yachts
# before you start, email me: I want to scrape this website, this data. Plot data
# data cleaning is important. 
# deadline: 14 December

# Maybe I should do this payscale project as a project?
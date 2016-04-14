
devtools::install_github("rstudio/addinexamples", type = "source")
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate) # for working withe dates and times

#remove all variables and values the environment
rm(list=ls(all=TRUE)) 

max_pages=1000 # be respectful, limit the number of pages being polled.
df=data.frame() #stores the consolidated list of issues from SeeClickFix
for (i in 1:max_pages) 
{
  #construct the URL to retrieve a page of data
  url = paste0("http://test.seeclicktest.com/api/issues.json?at=Burlington,+VT&start=50000&end=0&page=", toString(i), "&num_results=100&sort=issues.created_at")
  # print(url)
  seeclick_data <- fromJSON(paste(readLines(url), collapse=""))
  df1 = ldply (seeclick_data, data.frame, stringsAsFactors = FALSE )
  
  if ( length(df1)== 0 ) {  #if no more data is available, an empy record is returned. 
    breakFlag = TRUE
    break
  }
  df = rbind(df,df1)        # append the page of data to the overall results. 
  
}
page_num = 1
#page_num =3367
per_page = 100
url = paste0("https://test.seeclickfix.com/api/v2/issues?page=",page_num,"&per_page=", per_page = 100)
data1 <- fromJSON(url, flatten =TRUE)
names(data1)
scf_issues = data.frame(data1$issues)  
scf_meta_list = data1$metadata
scf_meta_list$pagination$entries
scf_meta_list$pagination$page
scf_meta_list$pagination$per_page
scf_meta_list$pagination$pages
scf_meta_list$pagination$next_page
scf_meta_list$pagination$next_page_url
scf_meta_list$pagination$previous_page
scf_meta_list$pagination$previous_page_url
scf_error_list = data1$errors

get_page_of_issues <- function(url,page_num,per_page)
{
  final_url = paste0(url,page_num,"&per_page=", per_page)
  print (final_url)
  issue_list = fromJSON(final_url, flatten =TRUE)
  return (issue_list)
}
df=data.frame()

get_multiple_pages_of_issues<- function(url,page_num,per_page,number_of_pages) 
{

  for (i in 1:number_of_pages) 
  {
    print("page number")
    print(i)
    print(" number of pages to fetch")
    print(number_of_pages)
    res = get_page_of_issues(url,i,per_page)
    rissues = res$issues
    df = rbind(df,rissues)
    
  }
   return(df)
}

for (i in 1:3)
{
  print(i)
}


url_base = "https://test.seeclickfix.com/api/v2/issues?page="
page_num = 3
per_page = 60
d1 = get_page_of_issues(url_base,page_num,per_page )
nrow(d1$issues)
page_num = 2
d2 =get_page_of_issues(url_base,page_num,per_page )
nrow(d2$issues)
d3_issues <- rbind(d1$issues,d2$issues)
nrow(d3_issues)
number_of_pages = 3
dx =get_multiple_pages_of_issues(url_base,page_num,per_page,number_of_pages)
d4 =get_page_of_issues(url_base,3,per_page )
d4d = data.frame(d4$issues)
d
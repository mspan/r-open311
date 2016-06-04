#SCF helper functions
get_page_of_issues <- function(url,page_num,per_page)
{
  final_url = paste0(url,page_num,"&per_page=", per_page)
  print (final_url)
  issue_list = fromJSON(final_url, flatten =TRUE)
  return (issue_list)
}

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
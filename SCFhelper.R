#SCF helper functions
get_multiple_pages_of_issues<- function(url,page_num,per_page,number_of_pages) 
{
  df=data.frame()
  for (i in 1:number_of_pages) 
  {
    #print("page number")
    #print(i)
    #print(" number of pages to fetch")
    #print(number_of_pages)
    res = get_page_of_issues(url,i,per_page)
    rissues = res$issues
    df = rbind(df,rissues)
    
  }
  
  return(df)
}

get_page_of_issues <- function(url,page_num,per_page)
{
  final_url = paste0(url,page_num,"&per_page=", per_page)
  #print (final_url)
  issue_list = fromJSON(final_url, flatten =TRUE)
  return (issue_list)
}

plot_scf_issues<- function(dsp)
{
  p = ggplot(dsp, aes(created_at, acknowledged_at)) + 
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=4)) +
    geom_point(aes(color = status), alpha = 0.7) 
  (gg <- ggplotly(p))
}

get_open_311 = function(url)
{
  print (url)
  res = fromJSON(url, flatten =TRUE)
  return(res)
  }


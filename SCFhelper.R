#SCF helper functions
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate) # for working withe dates and times
get_page_of_results <- function(url,page_num,per_page)
{
  final_url = paste0(url,page_num,"&per_page=", per_page)
  #print (final_url)
  issue_list = fromJSON(final_url, flatten =TRUE)
  return (issue_list)
}

get_multiple_pages_of_issues<- function(url,page_num,per_page,number_of_pages) 
{
  df=data.frame()
  for (i in 1:number_of_pages) 
  {
    res = get_page_of_results(url,i,per_page)
    rissues = res$issues
    # print("ncol")
    # print(names(rissues))
    # ncol(rissues)
    df = bind_rows(df,rissues)
  }
  
  return(df)
}



plot_scf_issues<- function(dsp)
{
  dsp$new_created_at =  ymd_hms(dsp$created_at)
  dsp$new_acknowledged_at =  ymd_hms(dsp$acknowledged_at)
  p = ggplot(dsp, aes(new_created_at, new_acknowledged_at, z = description)) + 
    scale_x_datetime(date_breaks = "5 min")+
    scale_y_datetime(date_breaks = "5 min")+
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8)) +
    geom_point(aes(color = status), alpha = 0.7) 
  gg <- ggplotly(p, tooltip = c("x", "y", "z"))
  return(gg)
}

get_open_311 = function(url)
{
  print (url)
  res = fromJSON(url, flatten =TRUE)
  return(res)
  }


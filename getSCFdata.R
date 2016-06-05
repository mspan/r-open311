library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate) # for working withe dates and times

rm(list=ls(all=TRUE)) 
source("SCFhelper.R")
library(plotly)
#install.packages(c("shiny", "htmlwidgets"))




#remove all variables and values the environment

# 
# max_pages=1000 # be respectful, limit the number of pages being polled.
# df=data.frame() #stores the consolidated list of issues from 
# page_num = 1
# 
# per_page = 500
# url = paste0("https://www.seeclickfix.com/api/v2/issues?page=",page_num,"&per_page=", per_page = 500)
# data1 <- fromJSON(url, flatten =TRUE)
# dataa1_open_issues= data1$issues %>% filter(status=="Open")
# names(data1)
# 
# scf_issues = data1$issues  
# scf_meta_list = data1$metadata
# scf_meta_list$pagination$entries
# scf_meta_list$pagination$page
# scf_meta_list$pagination$per_page
# scf_meta_list$pagination$pages
# scf_meta_list$pagination$next_page
# scf_meta_list$pagination$next_page_url
# scf_meta_list$pagination$previous_page
# scf_meta_list$pagination$previous_page_url
# scf_error_list = data1$errors

url_base = "https://www.seeclickfix.com/api/v2/issues?page="
url311discover = "https://www.seeclickfix.com/open311/v2/29/discovery.json"
url311req = "https://www.seeclickfix.com/open311/v2/29/requests.json"
page_num = 2
per_page = 80




d_single_page =get_page_of_issues(url_base,page_num,per_page )
dsp = data.frame(d_single_page$issues)
plot_scf_issues(dsp)

number_of_pages = 2

dmultp =get_multiple_pages_of_issues(url_base,page_num,per_page,number_of_pages)
plot_scf_issues(dmultp)

dmultp$new_created_at =  ymd_hms(dmultp$created_at)
summary(dmultp$created_at)
summary(dmultp$new_created_at)
str(dmultp$new_created_at)

p = ggplot(dmultp, aes(new_created_at, acknowledged_at)) + 
    scale_x_datetime(date_breaks = "1 min")+
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8)) +
  geom_point(aes(color = status), alpha = 0.7) 
(gg <- ggplotly(p))



x = head(dmultp$created_at,50)
x
length(x)

#311
resreq = get_open_311(url311req )
resdisc = get_open_311(url311discover  )
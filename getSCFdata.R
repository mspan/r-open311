source("SCFhelper.R")
library(plotly)
library(feather)

url_base = "https://test.seeclickfix.com/api/v2/issues?page="
url311discover = "https://test.seeclickfix.com/open311/v2/29/discovery.json"
url311req = "https://test.seeclickfix.com/open311/v2/29/requests.json"
page_num = 1
per_page = 100
number_of_pages = 3
#number_of_pages = 50


d_single_page =get_page_of_results(url_base,page_num,per_page )





dmultp =get_multiple_pages_of_issues(url_base,page_num,per_page,number_of_pages)
res_filename = paste0("dmultp", date(), "last_",(per_page*number_of_pages), ".Rda")
save(dmultp,file=res_filename)
#load("dmultp20160605_latest_5000.Rda")

gg = plot_scf_issues(dmultp)
gg


#311
resreq = get_open_311(url311req )
resdisc = get_open_311(url311discover  )
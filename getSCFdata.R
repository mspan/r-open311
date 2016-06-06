source("SCFhelper.R")
library(plotly)


url_base = "https://www.seeclickfix.com/api/v2/issues?page="
url311discover = "https://www.seeclickfix.com/open311/v2/29/discovery.json"
url311req = "https://www.seeclickfix.com/open311/v2/29/requests.json"
page_num = 1
per_page = 75
number_of_pages = 3



d_single_page =get_page_of_results(url_base,page_num,per_page )

plot_scf_issues(d_single_page$issues)



dmultp =get_multiple_pages_of_issues(url_base,page_num,per_page,number_of_pages)

plot_scf_issues(dmultp)

#311
resreq = get_open_311(url311req )
resdisc = get_open_311(url311discover  )
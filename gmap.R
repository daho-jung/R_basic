# install.packages("ggmap")
# library(ggmap)
# library(dplyr)
# register_google(key ="")
# get_map(location="",
#         zoom=15,maptype = 'hybrid',
#         source='google') %>% ggmap()

# ##
# install.packages("rvest")
# library(rvest)
# library(stringr)
rm(list=ls())
title=c()
press=c()
time=c()
body=c()
url=c()


url_base="https://news.daum.net/breakingnews?page=1"
# for(i in 1:100){
#   
# }

t_css="#mArticle .tit_thumb .link_txt"
pt_css=".into_news"
b_css=".desc_thumb"

hdoc=read_html(url_base)
t_node=html_nodes(hdoc,t_css)
pt_node=html_nodes(hdoc,pt_css)
b_node=html_nodes(hdoc,b_css)

title_part=html_text(t_node)
pt_part=html_text(pt_node)
b_part=html_text(b_node)

body_part=gsub("\n","",b_part)
time_part=str_sub(pt_part,-5)
press_part=str_sub(pt_part,end=-9)
body_part = str_trim(body_part,side='both')
url_part = html_attr(t_node,"href")

title=c(title,title_part)
press=c(press,press_part)
time=c(time,time_part)
body=c(body,body_part)
url=c(url,url_part)

news = cbind(title,press,time,body,url)

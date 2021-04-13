install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
library("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library(KoNLP)
install.packages("wordcloud")
library("wordcloud")
install.packages("wordcloud2")
library("wordcloud2")



t = readLines("hong.txt")
t=gsub("저","",t) #저 삭제
n = sapply(t,extractNoun,USE.NAMES = F)
n = Filter(function(x){nchar(x) >=2},n)
class(n)
head(unlist(n),30)
write(unlist(n),"hong2.txt")
rev=read.table("hong2.txt")
wc = table(rev)
library(RColorBrewer)
palate=brewer.pal(9,"Set1")
wordcloud(names(wc),freq = wc,scale=c(5,0.5),rot.per = 0.25,
          min.freq = 3,random.order = F,random.color = T,
          colors = palate)
wordcloud2(data=wc,
           size=0.4,
           shape='diamond')

t = readLines("noh.txt")
n = sapply(t,extractNoun,USE.NAMES = F)
n = Filter(function(x){nchar(x) >=2},n)
n2 = head(unlist(n),30)
write(n2,"noh2.txt")
rev = read.table("noh2.txt")
wc = table(rev)
tv = head(sort(wc,decreasing = T),20)
k = barplot(tv,ylim = c(0,10),las=2,col=rainbow(20))
text(k,tv*1.03,label=paste(tv,"",sep=""),col=2,cex=1.5,pos=3)
wordcloud(names(wc),freq = wc,scale=c(5,0.5),rot.per = 0.25,
          min.freq = 1,random.order = F,random.color = T,
          colors = palate)
wordcloud2(data=wc,
           size=0.4,
           shape='diamond')

t = readLines("park.txt")
n = sapply(t,extractNoun,USE.NAMES = F)
n = unlist(n)
n = Filter(function(x){nchar(x) >=2},n)
write(n,"park2.txt")
rev = read.table("park2.txt")
wc = table(rev)
tv = head(sort(wc,decreasing = T),20)
k = barplot(tv,ylim = c(0,50),las=2,col=rainbow(20))
text(k,tv*1.03,label=paste(tv,"",sep=""),col=2,cex=1.5,pos=3)
wordcloud(names(wc),freq = wc,scale=c(5,0.5),rot.per = 0.25,
          min.freq = 1,random.order = F,random.color = T,
          colors = palate)
wordcloud2(data=wc,
           size=0.4,
           shape='diamond')
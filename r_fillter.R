mpg = data.frame(ggplot2::mpg)
mpg

mp2 = mpg
mp2 %>% mutate(pl=cty+hwy) %>% mutate(av=pl/2)%>%
  arrange(desc(av)) %>% head(3)

fuel = data.frame(fl = c("c","d","e","p","r"),
                  price_fl = c(2.35,2.38,2.11,2.76,2.22),
                  stringAsFactors = F)

mp2 = mpg
mp2 = left_join(mp2,fuel,by="fl")
mp2 = mp2 %>% select(model,fl,price_fl) %>% head(5)
mp2

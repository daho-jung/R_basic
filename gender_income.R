library(ggplot2)
install.packages("readxl")
library(readxl)
f = read.spss(file="Koweps_hpc10_2015_beta1.sav",to.data.frame = T)
ff = f
ff = rename(ff,sex=h10_g3,birth=h10_g4,
            marriage=h10_g10,religion=h10_g11,
            income=p1002_8aq1,code_job=h10_eco9,
            code_region=h10_reg7)
ff$sex = ifelse(ff$sex == 9,NA,ff$sex)
ff$sex=ifelse(ff$sex==1,"male","female")
qplot(ff$sex)
gen = table(ff$sex)
gx=barplot(gen,col=rainbow(2), ylim=c(0,10000))
text(gx,gen,label=paste0(gen,"명"),pos=3,col='red',cex=2)
plot.new()
###############
ff$income=ifelse(ff$income %in% c(0,9999),NA,ff$income)
fin=ff %>% filter(!is.na(income)) %>% group_by(sex) %>% 
  summarise(mean_income=round(mean(income)),2)
ggplot(data=fin,aes(x=sex,y=mean_income))+geom_col(fill=rainbow(2))+
  geom_text(aes(label=paste(fin$mean_income,"")),vjust=-0.2,col=2,cex=8)+
  xlab("gender")+ylab("income")
##################
age = (2015-ff$birth)
ff <- cbind(ff,age)
fin2 = ff %>% filter(!is.na(income)) %>% group_by(age) %>% 
  summarise(mean_income=round(mean(income),2))
g = ggplot(data=fin2,aes(x=age,y=mean_income))+geom_col(fill=rainbow(length(fin2$age)))
library(plotly)
ggplotly(g)
ff <- ff %>% mutate(age_c = ifelse(age<30,"young",
                                   ifelse(age<60,"middle",
                                          "old")))
fin3 = ff %>% filter(!is.na(income)) %>% group_by(age_c) %>% 
  summarise(mean_income=round(mean(income),1))
ggplot(data=fin3,aes(x=age_c,y=mean_income))+geom_col(fill=rainbow(3))+
  geom_text(aes(label=paste(fin3$mean_income,"만원")),vjust = -0.2,col=4,cex=6)+
  xlab("age bound")+ylab("income")
###############
sex_age = ff %>% filter(!is.na(income)) %>% group_by(age, sex) %>% 
  summarise(mean_income=mean(income))
fin4 = ggplot(data=sex_age,aes(x=age,y=mean_income,col=sex))+geom_line()
ggplotly(fin4)
###########
sex_income=ff %>% filter(!is.na(income)) %>% 
  group_by(age_c,sex) %>% summarise(mean_income=mean(income))
ggplot(data=sex_income,aes(x=age_c,y=mean_income,fill=sex))+
  geom_col(position="dodge")+
  scale_x_discrete(limits=c("young","middle","old"))
############
list_job=read_excel("Koweps_Codebook.xlsx",col_names=T,sheet=2)
ff = left_join(ff,list_job,id="code_job")
job_income = ff %>% filter(!is.na(job)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income=round(mean(income),2))
top10 = job_income %>% arrange(desc(mean_income)) %>% head(10)
fin5=ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col(fill=rainbow(10)) +
  coord_flip()+xlab("job")+ylab("income")
fin5

low10 = job_income %>% arrange(mean_income) %>% head(10)
fin6 = ggplot(data=low10,aes(x=reorder(job,mean_income),y=mean_income))+
  geom_col(fill=rainbow(10))+
  geom_text(aes(label=paste0(low10$mean_income,"만원")),
            hjust=-0.02,col=2,cex=6)+
  coord_flip()+xlab("job")+ylab("income")
fin6











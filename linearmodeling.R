dt<- read.table("D:/Dati/vito.tranquillo/Desktop/IntroductionBayes-master/slides/data/button_press.dat", quote="\"", comment.char="")

dt<-dt[, -c(1,4,7)]

names(dt)<-c("type", "item", "wordn", "word", "y")

library(tidyverse)

dt %>% 
  ggplot(aes(x=y))+geom_density()+
  geom_vline(aes(xintercept=mean(y)),
            color="blue", size=0.2)


x<-data.frame(x=(dt$y-mean(dt$y)))

x %>% 
  ggplot(aes(x=x))+geom_density()+
  geom_vline(aes(xintercept=mean(x)),
             color="blue", size=0.2)

m<-rnorm(1e4, 0,2000)
s<-rnorm(1e4, 0, 500)

dens(m)
dens(s)

Yp<-rnorm(1e4, m, s)


priorpred<-"data {
      int N;
}
parameters{
real<lower=0> mu;
real<lower=0> sigma;
}
model{
mu~normal(0, 2000);
sigma~normal(0, 500);
}
generated quantities{
vector[N] y_sim;
for(i in 1:N){
y_sim[i]=normal_rng(mu, sigma)
}}"

library(rstan)
library(brms)

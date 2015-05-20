library(data.table)
library(magrittr)
library(dplyr)
library(ggplot2)

system("cut -f 2,5,7 TIL_F2_chr1_GT_angst_q40_7_1e6_975_F.geno > q40_1e6_975.txt")
system("cut -f 2,5,7 TIL_F2_chr1_GT_angst_q40_7_1e6_F.geno > q40_1e6.txt")
system("cut -f 2,5,7 TIL_F2_chr1_GT_angst_q60_7_1e6_F.geno > q60_1e6.txt")
system("cut -f 2,5,7 TIL_F2_chr1_GT_angst_q60_7_1e6_975_F.geno > q60_1e6_975.txt")
system("cut -f 2,5,7 TIL_F2_chr1_GT_angst_q40_7_1e6_uniform_F.geno > q40_1e6_u.txt")
system("cut -f 2,5,7 TIL_F2_chr1_GT_angst_q60_7_1e6_uniform_F.geno > q60_1e6_u.txt")

system("cut -f 2,5,7 TIL_F2_chr3_GT_angst_q40_7_1e6_F.geno > c3_q40_1e6.txt")
system("cut -f 2,5,7 TIL_F2_chr3_GT_angst_q40_7_1e6_975_F.geno > c3_q40_1e6_975.txt")
system("cut -f 2,5,7 TIL_F2_chr3_GT_angst_q60_7_1e6_F.geno > c3_q60_1e6.txt")
system("cut -f 2,5,7 TIL_F2_chr3_GT_angst_q60_7_1e6_975_F.geno > c3_q60_1e6_975.txt")
system("cut -f 2,5,7 TIL_F2_chr3_GT_angst_q40_7_1e6_uniform_F.geno > c3_q40_1e6_u.txt")
system("cut -f 2,5,7 TIL_F2_chr3_GT_angst_q60_7_1e6_uniform_F.geno > c3_q60_1e6_u.txt")

system("cut -f 2,5,7 TIL_F2_chr4_GT_angst_q40_7_1e6_F.geno > c4_q40_1e6.txt")
system("cut -f 2,5,7 TIL_F2_chr4_GT_angst_q40_7_1e6_975_F.geno > c4_q40_1e6_975.txt")
system("cut -f 2,5,7 TIL_F2_chr4_GT_angst_q60_7_1e6_F.geno > c4_q60_1e6.txt")
system("cut -f 2,5,7 TIL_F2_chr4_GT_angst_q60_7_1e6_975_F.geno > c4_q60_1e6_975.txt")

plot_all<-function(file_name, round, title){
  filter_data<-fread(file_name) %>% 
    setnames(c("pos","til","f2")) %>% 
    #filter(til==allele) %>%
    mutate(win=round(pos,round)) %>%
    group_by(win) %>%
    summarize(n=length(til),two=sum(f2==2),one=sum(f2==1),zero=sum(f2==0)) %>% 
    mutate(prop2=two/n,prop1=one/n,prop0=zero/n)
    grouped_dim<-dim(filter_data)
  #Plot
  #make matrix of heights for barplot
  plot_matrix=t(matrix(c(filter_data$prop2,filter_data$prop1,filter_data$prop0),ncol=3))
  bplot<-barplot(plot_matrix,col=c("red","green","blue"),main=title)
  bplot
  return(list(grouped_dim))
  
}


plot_filter<-function(file_name, round, allele, title){
  filter_data<-fread(file_name) %>% 
    setnames(c("pos","til","f2")) %>% 
    filter(til==allele) %>%
    mutate(win=round(pos,round)) %>%
    group_by(win) %>%
    summarize(n=length(til),two=sum(f2==2),one=sum(f2==1),zero=sum(f2==0)) %>% 
    mutate(prop2=two/n,prop1=one/n,prop0=zero/n)
  grouped_dim<-dim(filter_data)
  #Plot
  #make matrix of heights for barplot
  plot_matrix=t(matrix(c(filter_data$prop2,filter_data$prop1,filter_data$prop0),ncol=3))
  bplot<-barplot(plot_matrix,col=c("red","green","blue"),main=title)
  bplot
  return(list(grouped_dim))
  
}

dims<-function(file_name){
    filter_data<-fread(file_name) %>% 
    setnames(c("pos","til","f2"))  
    non_ref<-dim(filter(filter_data,til==2))[1]
    ref<-dim(filter(filter_data,til==0))[1]
    all<-dim(filter_data)[1]
    return(list(all,ref,non_ref))
}

plot_all("q40_1e6.txt", -6, "q40_1e6 all")
plot_all("q40_1e6_u.txt", -6, "q40_1e6_u all")
#plot_all("q40_1e6_975.txt", -6, "q40_1e6 all")
plot_all("q60_1e6.txt", -6, "q60_1e6.txt all")
plot_all("q60_1e6_u.txt", -6, "q60_1e6_u all")
#plot_all("q60_1e6_975.txt", -6, "q60_1e6_975 all")

plot_filter("q40_1e6.txt", -6, 0, "q40_1e6 ref")
plot_filter("q40_1e6_u.txt", -6, 0, "q40_1e6_u ref")
#plot_filter("q40_1e6_975.txt", -6, 0, "q40_1e6_975 ref")
plot_filter("q60_1e6.txt", -6, 0, "q60_1e6 ref")
plot_filter("q60_1e6_u.txt", -6, 0, "q60_1e6_u ref")
#plot_filter("q60_1e6_975.txt", -6, 0, "q60_1e6_975 ref")

plot_filter("q40_1e6.txt", -6, 2, "q40_1e6 TIL")
plot_filter("q40_1e6_u.txt", -6, 2, "q40_1e6_u TIL")
#plot_filter("q40_1e6_975.txt", -6, 2, "q40_1e6_975 TIL")
plot_filter("q60_1e6.txt", -6, 2, "q60_1e6 TIL")
plot_filter("q60_1e6_u.txt", -6, 2, "q60_1e6_u TIL")
#plot_filter("q60_1e6_975.txt", -6, 2, "q60_1e6_975 TIL")

dims("q40_1e6.txt")
dims("q40_1e6_u.txt")
#dims("q40_1e6_975.txt")
dims("q60_1e6.txt")
dims("q40_1e6_u.txt")
#dims("q60_1e6_975.txt")

plot_all("c3_q40_1e6.txt", -6, "q40_1e6 all")
plot_all("c3_q40_1e6_u.txt", -6, "q40_1e6_u all")
#plot_all("c3_q40_1e6_975.txt", -6, "q40_1e6 all")
plot_all("c3_q60_1e6.txt", -6, "q60_1e6.txt all")
plot_all("c3_q60_1e6_u.txt", -6, "q60_1e6_u all")
#plot_all("c3_q60_1e6_975.txt", -6, "q60_1e6_975 all")

plot_filter("c3_q40_1e6.txt", -6, 0, "q40_1e6 ref")
plot_filter("c3_q40_1e6_u.txt", -6, 0, "q40_1e6_u ref")
#plot_filter("c3_q40_1e6_975.txt", -6, 0, "q40_1e6_975 ref")
plot_filter("c3_q60_1e6.txt", -6, 0, "q60_1e6 ref")
plot_filter("c3_q60_1e6_u.txt", -6, 0, "q60_1e6_u ref")
#plot_filter("c3_q60_1e6_975.txt", -6, 0, "q60_1e6_975 ref")

plot_filter("c3_q40_1e6.txt", -6, 2, "q40_1e6 TIL")
plot_filter("c3_q40_1e6_u.txt", -6, 2, "q40_1e6_u TIL")
#plot_filter("c3_q40_1e6_975.txt", -6, 2, "q40_1e6_975 TIL")
plot_filter("c3_q60_1e6.txt", -6, 2, "q60_1e6 TIL")
plot_filter("c3_q60_1e6_u.txt", -6, 2, "q60_1e6_u TIL")
#plot_filter("c3_q60_1e6_975.txt", -6, 2, "q60_1e6_975 TIL")

dims("c3_q40_1e6.txt")
dims("c3_q40_1e6_u.txt")
#dims("c3_q40_1e6_975.txt")
dims("c3_q60_1e6.txt")
dims("c3_q60_1e6_u.txt")
#dims("c3_q60_1e6_975.txt")

plot_all("c4_q40_1e6.txt", -6, "q40_1e6 all")
plot_all("c4_q40_1e6_975.txt", -6, "q40_1e6 all")
plot_all("c4_q60_1e6.txt", -6, "q60_1e6.txt all")
plot_all("c4_q60_1e6_975.txt", -6, "q60_1e6_975 all")

plot_filter("c4_q40_1e6.txt", -6, 0, "q40_1e6 ref")
plot_filter("c4_q40_1e6_975.txt", -6, 0, "q40_1e6_975 ref")
plot_filter("c4_q60_1e6.txt", -6, 0, "q60_1e6 ref")
plot_filter("c4_q60_1e6_975.txt", -6, 0, "q60_1e6_975 ref")

plot_filter("c4_q40_1e6.txt", -6, 2, "q40_1e6 TIL")
plot_filter("c4_q40_1e6_975.txt", -6, 2, "q40_1e6_975 TIL")
plot_filter("c4_q60_1e6.txt", -6, 2, "q60_1e6 TIL")
plot_filter("c4_q60_1e6_975.txt", -6, 2, "q60_1e6_975 TIL")

dims("c4_q40_1e6.txt")
dims("c4_q40_1e6_975.txt")
dims("c4_q60_1e6.txt")
dims("c4_q60_1e6_975.txt")
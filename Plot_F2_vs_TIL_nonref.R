library(data.table)
library(magrittr)
library(dplyr)
library(ggplot2)

file_name="GT_F2_TIL_chr1_call_no_sample.txt" #arg[1]
q=30 #as.integer(arg[2])
winsize=100000 #as.integer(arg[3])
win_file<-"TIL_homo_no_ref_Windows_chr1_q30.txt" #arg[4]

geno_file<-fread(file_name)
setnames(geno_file,c('chr','pos','qual','TIL','F2'))
 
genotypes=as.data.frame(subset(geno_file, !duplicated(geno_file$pos)))

snps_all<-filter(genotypes,qual>=q)
snps_ref<-filter(genotypes,qual>=q & TIL=="0/0")
snps_het<-filter(genotypes,qual>=q & TIL=="0/1" | TIL=="./.")
prop_het<-dim(snps_het)[1]/dim(snps_all)[1]
 
##only want definitely homozygous non-reference SNPs. This should hopefully help filter out bad calls in the F2. Try raising different quality scores, in mpileup and here. See if that makes a difference in the number of definitive SNPs kept. How will I do this for my real data? Take only SNPs that are homozygous reference in B73? Or is that going to be run dependant? Or will a high enough stringency make it so that shouldn't happen?

num_win<-as.integer(length(snps$TIL)/winsize)
if(length(snps$TIL)%%winsize>0){
	num_win<-as.integer(length(snps$TIL)/winsize) +1
}
win=c(sapply(1:num_win, function(X) rep(X,winsize)))

win=win[1:length(snps$TIL)]
snp_win=data.frame(snps,win)

grouped_snps<-group_by(snp_win,win)

write.table(grouped_snps,win_file,row.names=FALSE,sep='\t')

#summarize(grouped_snps,het=table(F2)[1])
##table lines are more or less sanity checks
#table(snps$TIL) #expect (and get) only 1/1 counts--total number of SNPs being called
#table(snps$F2) #expect a table of all the combos at the  cleaned TIL sites.  

#table(snps$F2)['0/1']/sum(table(snps$F2)) #the proportion of SNPs that are heterozygous in the F2
   
#het_bins<-summarize(grouped_snps,het=table(F2)['0/1']/sum(table(F2))) #give these proportions for each window, chromosome-wide

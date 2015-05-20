#Vince Buffalo Codealo
#For cluster do:
#library(data.table)
#for these datasets, 32000 not enough for GRanges call, 40000
library(GenomicRanges)
library(data.table)
library(ggbio)
library(plyr)
summarizeByTile <-
  # given a GRanges (or some sort of ranged data) object `x`, and a
  # *corresponding* vector values to summarize `y` (these *must*
  # correspond), calculate the summary per tile with the function `fun`.
  # Note: this is still beta; wider tests coming, use with caution.
  function(x, y, tiles, fun, mcol_name="y") {
    stopifnot(length(x) == length(y))
    
    if (is(tiles, "GRangesList"))
      tiles <- unlist(tiles)
    
    # find overlaps between ranges object x and tiles
    hits <- findOverlaps(x, tiles)
    message(sprintf("summarizeByTile: %d overlaps found between x (%d rows) and genome tiles (%d rows)",
                    length(hits), length(x), length(tiles)))
    
    # split y by hits in tiles
    split_y <- split(y[queryHits(hits)], subjectHits(hits))
    
    if (!is.null(mcol_name)) {
      tile_summaries <- tiles[unique(subjectHits(hits))]
      mcols(tile_summaries)[mcol_name] <- sapply(split_y, fun)
      return(tile_summaries)
    } else
      sapply(split_y, fun)
  }

args=commandArgs(trailingOnly=TRUE)

file_name="C50_temp.txt" #args[1]
tilesize=10000 #as.integer(args[2])
pdf_name=plot3.jpg #args[3]

geno_file<-fread(file_name)
setnames(geno_file,c('chr','pos','qual','GT'))
 
genotypes=as.data.frame(subset(geno_file, !duplicated(geno_file$pos)))
size=as.integer(dim(genotypes)[1]/300)
for(i in 1:300){
     strt=((i-1)*size)+1
     stop=i*size
     genobloc=genotypes[strt:stop,]
     if(i==1){
     	minpos=1
     }
     else{
     minpos=max(genos$pos)+1
     }
	 maxpos=max(genobloc$pos)
     #print(c(minpos, maxpos))
	all=as.data.frame(c(minpos:maxpos))
	names(all)<-'pos'
	genobloc<-join(all,genobloc,by="pos")
	if(i==1){
		genos<-genobloc
	}
	else{
	genos<-rbind(genos,genobloc)
	}
	}

maxpos=max(genotypes$pos)
minpos=max(genos$pos)+1
strt=strt+1
stop=as.integer(dim(genotypes)[1])
final_range=genotypes[strt:stop,]
all_fr<-as.data.frame(c(minpos:maxpos))
names(all_fr)<-'pos'
finalbloc<-join(all_fr,final_range,by='pos')

genos<-rbind(genos,finalbloc)
print(dim(genos))

chr1<-c(chr1=maxpos)
ranges=IRanges(seq_len(chr1),width=1)
snps<-GRanges('chr1',ranges,genotype=genos$GT)

tiles<-tileGenome(chr1,tilewidth=tilesize)

tile_hets<-summarizeByTile(snps, mcols(snps)$genotype, tiles, fun=function(x) sum("0/1" == x,na.rm=TRUE)/length(x))
oldm<-as.data.frame(values(tile_hets))
gt<- rep("0/1",length(tile_hets))
new.meta<-cbind(oldm,gt)
values(tile_hets)<-new.meta

tile_rhom<-summarizeByTile(snps, mcols(snps)$genotype, tiles, fun=function(x) sum("0/0" == x,na.rm=TRUE)/length(x))
oldm<-as.data.frame(values(tile_rhom))
gt<- rep("0/0",length(tile_rhom))
new.meta<-cbind(oldm,gt)
values(tile_rhom)<-new.meta

tile_ahom<-summarizeByTile(snps, mcols(snps)$genotype, tiles, fun=function(x) sum("1/1" == x,na.rm=TRUE)/length(x))
oldm<-as.data.frame(values(tile_ahom))
gt<- rep("1/1",length(tile_ahom))
new.meta<-cbind(oldm,gt)
values(tile_ahom)<-new.meta

tile_phet<-summarizeByTile(snps, mcols(snps)$genotype, tiles, fun=function(x) sum("1/2" == x,na.rm=TRUE)/length(x))
oldm<-as.data.frame(values(tile_phet))
gt<- rep("1/2",length(tile_phet))
new.meta<-cbind(oldm,gt)
values(tile_phet)<-new.meta

tile_pbad<-summarizeByTile(snps, mcols(snps)$genotype, tiles, fun=function(x) sum("./." == x,na.rm=TRUE)/length(x))
oldm<-as.data.frame(values(tile_pbad))
gt<- rep("./.",length(tile_pbad))
new.meta<-cbind(oldm,gt)
values(tile_pbad)<-new.meta

tiled<-c(tile_hets,tile_rhom,tile_ahom,tile_phet,tile_pbad)

jpeg(pdf_name, width=1200,height=400)
autoplot(tiled,geom="bar",aes(y=y,fill=gt))
dev.off()

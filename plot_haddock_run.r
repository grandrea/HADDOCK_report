library(ggplot2)
library(gridExtra)
library(ggrepel)
library(bio3d)
library(reshape2)
library(plyr)
library(parallel)
library(gplots)
library(gclus)

myvol=15000 #volume of common core, select after looking at core.png and then rerun

data<-read.table('structures_haddock-sorted.stat', 
                 comment.char = '!', 
                 header=TRUE)

data$X.struc[1]
#HADDOCK PLOTS---------------

p1<-ggplot(data, aes(rmsd_all, haddock.score,label=X.struc)) +
  geom_point()+
  ggtitle(getwd())+
  geom_text_repel(data= head(data))

p2<-ggplot(data, aes(rmsd_all, Eair))+
  geom_point()

p3<-ggplot(data, aes(Eair, haddock.score, color=rmsd_all))+
  geom_point()


grid.arrange(p1, p2, p3)



#BIO3D PLOTS--------------------------------
#Use structures with chain ids and no DU.

myFileNames = list.files(path=".", pattern="*.pdb")
pdbs<-pdbaln(myFileNames, fit =TRUE, ncore = 4)
gaps <- gap.inspect(pdbs$xyz)
core <- core.find(pdbs)


col=rep("black", length(core$volume))
col[core$volume<myvol]="pink"; col[core$volume<10]="red"
png("core.png")
plot(core, col=col)
dev.off()
#
#
core.inds <- print(core, vol=myvol)
xyz <- pdbfit( pdbs, core.inds, outpath = "./fitdir", ncore=4)
#

##
#### Find gap regions
gaps.res <- gap.inspect(pdbs$ali)
gaps.pos <- gap.inspect(pdbs$xyz)
##
#### RMSD vs the first structure
#rmsd(pdbs$xyz[1,gaps.pos$f.inds], pdbs$xyz[,gaps.pos$f.inds], fit=TRUE)
##
#### RMSD all vs all
rd <- rmsd(xyz[,gaps.pos$f.inds])
##
colnames(rd) <- pdbs$id
rownames(rd) <- pdbs$id
##
#### Plot RMSD values in a heatmap, or histogram
title<-'structure-based alignment rmsd'
library(RColorBrewer)

#coul = colorRampPalette(brewer.pal(9,"Blues"))(200)

heatmap.2(rd,
          main = title, # heat map title
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          #          col = coul,      # use on color palette defined earlier
          #          breaks=lcol_breaks,
          dendrogram="both",    # only draw a row dendrogram
          xlab = 'pdb',
          ylab = 'pdb',
          margins=c(17,17)
          #          lhei = c(1,30),
          #          Colv="NA"
          #          scale="row"
)           

hist(rd[upper.tri(rd)], breaks = 30, main = "", xlab = "RMSD (Å)")

##
### RMSF
rf <- rmsf(xyz)
pdb<-read.pdb(file=as.character(data$X.struc[1]))
sse <- dssp(pdb)
plot.bio3d(rf, sse = sse, ylab = "RMSF (Å)", xlab = "Residue No.")
##
#### Clustering

dis <- as.dist(rd)
hc <- hclust(dis)
hc1 <- reorder.hclust(hc, dis)
id <- substr(basename(pdbs$id), 1, 6)
plot(hc1, labels = id, main = "", ylab = "RMSD (Å)", xlab = "")
##
##
#### PCA
pc.xray <- pca.xyz(xyz[, gaps.pos$f.inds], use.svd = TRUE)
##

plot(pc.xray)
##
##
a <- mktrj.pca(pc.xray, pc=1, file="pc1.pdb",
               resno = pdbs$resno[1, gaps.res$f.inds],
               resid = aa123(pdbs$ali[1, gaps.res$f.inds]) )

b <- mktrj.pca(pc.xray, pc=2, file="pc2.pdb",
               resno = pdbs$resno[1, gaps.res$f.inds],
               resid = aa123(pdbs$ali[1, gaps.res$f.inds]) )
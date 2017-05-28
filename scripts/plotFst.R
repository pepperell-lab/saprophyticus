import(ggplot2)

fst <- read.delim("wcFst.txt", header=F)
#qplot(fst$V5)
#qplot(fst$V2, fst$V5)
fst$V5[fst$V5 < 0] <- 0
fst_plot <- ggplot(fst, aes(x=V2, y=V5)) + geom_point() +
  xlab("Position") + ylab("Fst") + theme_bw()

p <- read.delim("pFst.txt", header=F)
qplot(p$V2, log10(p$V3)) + scale_y_reverse()

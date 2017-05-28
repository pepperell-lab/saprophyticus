library(ggplot2)
library(cowplot)
ehh <- read.delim("meltEHH.txt", header=F)
ggplot(ehh, aes(V1, V2)) + 
  geom_point(aes(color=V3)) + 
  xlab("Genomic Position (bp)") + 
  ylab("EHH") +
  theme(legend.position="none")

diversity <- read.delim("sequenceDiversity.txt", header=F)
diversity$pos <- (diversity$V3 + diversity$V2)/2
ggplot(diversity, aes(pos, V4)) + geom_point()
ggplot(diversity, aes(pos, V5)) + geom_point()

nsl <- read.delim("nsl.txt.nsl.out.100bins.norm", header=F)
ggplot(nsl, aes(V2, abs(V7))) + geom_point()

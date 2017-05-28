library(ggplot2)
library(reshape2)
library(cowplot)

sfs <- read.delim("sfs.txt", header=T, stringsAsFactors = F)
sfs.melt <- melt(sfs[1:42,], id.vars = c("Frequency"))
genic_sfs <- sfs.melt[sfs.melt$variable == "Synonymous" | sfs.melt$variable == "Nonsynonymous",]
genic_sfs$variable <- factor(genic_sfs$variable, levels = c("Nonsynonymous", "Synonymous"))

sfs_plot <- ggplot(sfs.melt, aes(Frequency, value)) + geom_bar(stat="identity") + ylab("Count")
plot(sfs_plot + facet_wrap(~ variable))

combined_plot <- ggplot(genic_sfs, aes(Frequency, value)) + 
  geom_bar(aes(fill=variable), position = "dodge", stat = "identity") +
  ylab("Count") + scale_fill_manual(values=c("#b2df8a", "#1f78b4")) +
  theme(legend.title = element_blank())
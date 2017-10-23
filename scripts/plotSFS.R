library(ggplot2)
library(reshape2)
library(cowplot)
library(dplyr)

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


observed <- read.table("demography/dadi_lineageU_noreco//observedSFS.txt")
bestFit <- read.table("demography/dadi_lineageU_noreco//bottleneckModelSFS.txt")
neutral <- read.table("demography/dadi_lineageU_noreco/neutralModelSFS.txt")

dadi_results <- bind_cols(observed, neutral, bestFit)
colnames(dadi_results) <-c("Observed", "Neutral", "Best Fit Model")
dadi_results$Frequency <- row.names(dadi_results)
dadi_results.melt <- melt(dadi_results, id.vars = c("Frequency"))
dadi_results.melt$Frequency <- as.numeric(dadi_results.melt$Frequency)
colnames(dadi_results.melt) <- c("Frequency", "Model", "Count")
dadi_plot <- ggplot(dadi_results.melt, aes(Frequency, Count, group=Model)) + 
  geom_bar(stat="identity", position="dodge", aes(fill=Model))

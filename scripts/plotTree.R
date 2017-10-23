library(ggplot2)
library(ape)
library(phangorn)
library(ggtree)

tree <- read.tree("trees/RAxML_bipartitionsBranchLabels.sapro_101216_combine")
data <- read.table("strain_description.txt", sep="\t", header=F, stringsAsFactors = FALSE)
data$V1 <- paste(data$V1, data$V5, sep=" ")
tree$tip.label<-data[[1]][match(tree$tip.label, data[[2]])]
midpoint_rooted <- midpoint(tree) 
tree_plot <- ggtree(midpoint_rooted) + geom_tiplab(size=2)


tree_plot <- tree_plot %<+% data + geom_tippoint(aes(color=V4)) +
  theme(legend.position="right", legend.title=element_blank()) +
  geom_cladelabel(node=115, label="Clade P", align=T, offset=0.0005, angle=270, hjust="center", offset.text=0.0001) + 
  geom_cladelabel(node=65, label="Clade E", align=T, offset=0.0005, angle=270, hjust="center", offset.text=0.0001) + 
#  geom_hilight(node=67, fill="steelblue", alpha=.2)
  geom_treescale(fontsize=3, offset=0.1) 
tree_plot

# plot recombination free tree

noLGT_tree <- read.tree("recombination/masked_sapro_merged_withRef_101216.final_tree.tre")
noLGT_tree$tip.label<-data[[1]][match(tree$tip.label, data[[2]])]
noLGT_midpoint_rooted <- midpoint(noLGT_tree) 
noLGT_tree_plot <- ggtree(midpoint_rooted) + geom_tiplab(size=2)
noLGT_tree_plot <- noLGT_tree_plot %<+% data + geom_tippoint(aes(color=V4)) +
  theme(legend.position="right", legend.title=element_blank()) +
  geom_treescale(fontsize=2, offset=0.1) 
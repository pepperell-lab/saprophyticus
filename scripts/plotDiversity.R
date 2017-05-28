library(ggplot2)
library(cowplot)
library(dplyr)
library(reshape2)

sapros_stats <- read.delim("egglib/windowStats_masked_sapro_merged_withRef_101216.txt", na.strings="None")
lineageU_stats <- read.delim("egglib/windowStats_masked_lineageU.txt", na.strings="None")

sapros_stats$Position <- (sapros_stats$Stop + sapros_stats$Start)/2
lineageU_stats$Position <- (lineageU_stats$Stop + lineageU_stats$Start)/2
windows <- data.frame(c(1760000), 
                     c(1820000), 
                     c(0), 
                     c(max(lineageU_stats$Pi, na.rm = TRUE)), 
                     c(min(lineageU_stats$TajimasD, na.rm = TRUE)), 
                     c(max(lineageU_stats$TajimasD, na.rm = TRUE)))
colnames(windows) <- c("start","stop", "zero", "maxPi", "minTD", "maxTD")

TD <- ggplot(lineageU_stats, aes(x=Position, y=TajimasD)) + 
  geom_line() + 
  xlab("Position") + ylab("Tajima's D") + theme_bw() + 
#  annotate("rect", xmin = 1809572, xmax = 1813963, ymin = -Inf, ymax = windows$minTD, color="pink" )
  geom_vline(xintercept = 1790000)
#  geom_rect(data = windows, aes(xmin=start, 
#                                xmax=stop, 
#                                ymin=-Inf, 
#                                ymax=Inf,
#                                fill="grey10",
#                                alpha=0.1),
#            show.legend=FALSE, inherit.aes=FALSE)


div <- ggplot(lineageU_stats) + 
  geom_line(aes(x=Position, y=Pi), color=c("#b2df8a")) + 
  geom_line(aes(x=Position, y=Theta), color=c("#1f78b4")) +
  xlab("Position") + ylab("Diversity") + theme_bw() + 
#  annotate("rect", xmin = 1809572, xmax = 1813963, ymin = -Inf, ymax = 0 , color = "pink")
  geom_vline(xintercept = 1790000)
#  geom_rect(data = windows, aes(xmin=start, 
#                xmax=stop, 
#                ymin=-Inf, 
#                ymax=Inf,
#                fill="grey10",
#                alpha=0.1),
#                show.legend=FALSE, inherit.aes=FALSE)

plot_grid(TD, div, labels = c("A", "B"), nrow=2, align=("v"))


randomSample_pi <- read.delim("egglib/sampled_pi.txt", na.strings="None", header=F)

randomSample_pi.melt <- melt(randomSample_pi, id.vars = c("V1", "V2"))
colnames(randomSample_pi.melt) <- c("start", "stop", "sample", "Pi")
randomSample_pi.melt$position <- (randomSample_pi.melt$start + randomSample_pi.melt$stop)/2

pi <- randomSample_pi.melt %>%
  group_by(position) %>%
  summarise(min_pi = min(Pi), max_pi = max(Pi), mean_pi = mean(Pi))

pi_plot <- ggplot(pi, aes(x=position)) + 
  geom_ribbon(aes(ymin = min_pi, ymax = max_pi), fill = "grey70") +
  geom_line(aes(y=mean_pi)) + 
  xlab("Position") + ylab("Nucleotide Diversity") + theme_bw()

randomSample_theta <- read.delim("egglib/sampled_theta.txt", na.strings="None", header=F)

randomSample_theta.melt <- melt(randomSample_theta, id.vars = c("V1", "V2"))
colnames(randomSample_theta.melt) <- c("start", "stop", "sample", "Theta")
randomSample_theta.melt$position <- (randomSample_theta.melt$start + randomSample_theta.melt$stop)/2

theta <- randomSample_theta.melt %>%
  group_by(position) %>%
  summarise(min_theta = min(Theta), max_theta = max(Theta), mean_theta = mean(Theta))

theta_plot <- ggplot(theta, aes(x=position)) + 
  geom_ribbon(aes(ymin = min_theta, ymax = max_theta), fill = "grey70") +
  geom_line(aes(y=mean_theta)) + 
  xlab("Position") + ylab("Watterson's theta") + theme_bw()


randomSample_td <- read.delim("egglib/sampled_tajimasD.txt", na.strings="None", header=F)
randomSample_td.melt <- melt(randomSample_td, id.vars = c("V1", "V2"))
colnames(randomSample_td.melt) <- c("start", "stop", "sample", "TD")
randomSample_td.melt$position <- (randomSample_td.melt$start + randomSample_td.melt$stop)/2

td <- randomSample_td.melt %>%
  group_by(position) %>%
  summarise(min_td = min(TD), max_td = max(TD), mean_td = mean(TD))

td_plot <- ggplot(td, aes(x=position)) + 
  geom_ribbon(aes(ymin = min_td, ymax = max_td), fill = "grey70") +
  geom_line(aes(y=mean_td)) + 
  xlab("Position") + ylab("Tajima's D") + theme_bw()

plot_grid(pi_plot, theta_plot, td_plot, labels = c("A", "B", "C"), nrow=3, align=("v"))


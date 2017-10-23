library(dplyr)
library(viridis)
library(ggplot2)
library(cowplot)

params <- read.table("simulations/parameters.txt", header=F)
stats <- read.table("simulations/selectionStats.txt", header=F)

colnames(params) <- c('set', 'internal', 'external', 'diversity')
colnames(stats) <- c('set', 'iteration', 'theta', 'pi', 'td')

stats <- left_join(stats, params) %>% arrange(set, iteration)

stats_summary <- stats %>%
  group_by(set) %>%
  summarize(theta_mean = mean(theta), pi_mean = mean(pi), td_mean = mean(td)) %>%
  left_join(params)

p1 <- ggplot(filter(stats, internal == 0, external == 0), aes(x=td)) +
  geom_histogram(binwidth=0.1) + 
  theme_bw()

p2 <- ggplot(filter(stats, external == 0), aes(x=log10(internal), y=td)) +
  geom_point() + 
  ylab("Tajima's D") +
  xlab("Internal recombination rate (log10)") +
  theme_bw()

p3 <- ggplot(filter(stats, internal == 0.003), aes(x=log10(external), y=td)) +
  geom_point(aes(color=diversity)) +
  scale_color_viridis("Upper bound of divergence") +
  ylab("Tajima's D") +
  xlab("External recombination rate (log10)") +
  theme_bw()

p4 <- ggplot(stats_summary, aes(x=log10(external), y=td_mean, group=diversity)) + 
  geom_point(aes(color=diversity)) +
  scale_color_viridis() + 
  theme_bw()

plot_grid(p2, p3, labels = c("A", "B"))

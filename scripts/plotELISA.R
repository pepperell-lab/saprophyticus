library(ggplot2)
library(cowplot)
library(dplyr)

fb <- read.table("elisa/fibronectinBinding.txt", header=T)
fb$R1abPlated <- as.factor(fb$R1abPlated)


th <- read.table("elisa/thrombospondinBinding.txt", header=T)
th$R1abPlated <- as.factor(th$R1abPlated)

bind_fb_th <- bind_rows(fb, th, .id = "Glycoprotein")
bind_fb_th$Glycoprotein[bind_fb_th$Glycoprotein == 1] <- "Fibronectin"
bind_fb_th$Glycoprotein[bind_fb_th$Glycoprotein == 2] <- "Thrombospondin"

binding_plot <- ggplot(bind_fb_th, aes(x=GlycoproteinAdded, y=PercentMaxBinding, shape=R1abPlated, color=Strain)) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin=PercentMaxBinding-SD, ymax=PercentMaxBinding+SD), width=.1) + 
  xlab(expression(paste("Glycoprotein Added (", mu, "g/mL)")))+
  ylab(expression(paste("Binding (% of derived allele + 10 ", mu, "g/mL glycoprotein)"))) +
  scale_color_manual(values=c("#b2df8a", "#1f78b4")) +
  facet_wrap(~ Glycoprotein, nrow=2, ncol=1) +
  panel_border()

binding_plot$labels$shape <- expression(paste("R1ab Plated (", mu, "g/mL)"))
binding_plot$labels$linetype <- expression(paste("R1ab Plated (", mu, "g/mL)"))

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
bind_fb_th_mean <- summarise(group_by(bind_fb_th, Glycoprotein, Strain, GlycoproteinAdded, R1abPlated),
                             mean=mean(PercentMaxBinding))

binding_plot <- ggplot() +
  geom_point(data=bind_fb_th, aes(x=GlycoproteinAdded, y=PercentMaxBinding, shape=R1abPlated, color=Strain)) +
  geom_line(data=bind_fb_th_mean, aes(x=GlycoproteinAdded, y=mean, linetype=R1abPlated, color=Strain)) +
  xlab(expression(paste("Glycoprotein Added (", mu, "g/mL)")))+
  ylab("Binding (Percent of Control)") +
  scale_color_manual(values=c("#b2df8a", "#1f78b4")) +
  facet_wrap(~ Glycoprotein, nrow=2, ncol=1) +
  panel_border()

binding_plot$labels$shape <- expression(paste("R1ab Plated (", mu, "g/mL)"))
binding_plot$labels$linetype <- expression(paste("R1ab Plated (", mu, "g/mL)"))

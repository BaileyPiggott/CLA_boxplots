# CLA boxplots for subtasks of the CLA (performance task and selected response)

source("CLA_boxplots_setup.R")

# CHOOSE PROGRAM ----------------------------------------------------------
df <- dram
prog_name <- "Drama"
dummy <- dummy_2 %>% mutate(Subject = "DRAM")

df <- psyc
prog_name <- "Psychology"
dummy <- fix

df <- phys
prog_name <- "Physics"
dummy <- dummy_2 %>% mutate(Subject = "PHYS")

df <- eng
prog_name <- "Engineering"
dummy <- dummy_4 %>% mutate(Subject = "QUEENS") # not working

# SAMPLE SIZES ---------------------------------------------------------

#calculate sample sizes:
n_1 <-  sum(with(df, class == 1 & score_total >= 1), na.rm = TRUE)     
year1 <- paste0("First Year\nn = ", n_1, "   n = ", n_q_1) #text string for xlabel including sample size
n_2 <-  sum(with(df, class == 2 & score_total >= 1), na.rm = TRUE)     
year2 <- paste0("Second Year\nn = ", n_2, "   n = ", n_q_2) #text string for xlabel
n_3 <-  sum(with(df, class == 3 & score_total >= 1), na.rm = TRUE)     
year3 <- paste0("Third Year\nn = ", n_3, "   n = ", n_q_3) #text string for xlabel
n_4 <-  sum(with(df, class == 4 & score_total >= 1), na.rm = TRUE)     
year4 <- paste0("Fourth Year\nn = ", n_4, "   n = ", n_q_4) #text string for xlabel

df <- rbind(df, queens, fix, dummy) # combine with all queens data
graph_title <- paste0(prog_name, " CLA Scores") # graph title


# CREATE PLOT -------------------------------------------------------------

ggplot(
  data = df, 
  aes(
    x = as.factor(class), y = score_sr, 
    fill = Subject)
  ) +
  geom_boxplot(width = 0.5) +    
  coord_cartesian(xlim = c(0.5,4.5),ylim = c(500, 1850)) +
  scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
  labs(title = graph_title, x = "Year", y = "CLA+ Selected Response Score")  +
  scale_fill_manual(
    values =  c("darkgoldenrod1", "steelblue3"),
    labels = c(prog_name, "Queen's")
    )+
  theme(
    panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
    panel.background = element_rect("white"), #change background colour
    panel.grid.major.x = element_blank(), # remove vertical lines
    #panel.grid.major.y = element_blank(), # remove horizontal lines
    #panel.grid.minor.y = element_blank(),
    legend.title = element_blank(), #remove legend title
    legend.key = element_blank(), # remove background from legend items
    plot.title = element_text(size = 15),
    axis.title.x = element_blank(), # remove x axis title
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12) #size of x axis labels
  ) 

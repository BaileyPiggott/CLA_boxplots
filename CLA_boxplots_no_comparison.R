
# CLA boxplot totals
source("CLA_boxplots_setup.R")

# CHOOSE PROGRAM ----------------------------------------------------------
df <- dram
prog_name <- "Drama"

df <- psyc
prog_name <- "Psychology"

df <- phys
prog_name <- "Physics"

df <- eng
prog_name <- "Engineering"

df <- queens
prog_name <- "Queen's"


# CREATE BOXPLOTS ---------------------------------------------------------

graph_title <- paste0(prog_name, " CLA Scores") # graph title

#calculate sample sizes:
n_1 <-  sum(with(df, class == 1 & score_total >= 1), na.rm = TRUE)     
year1 <- paste0("First Year\nn = ", n_1) #text string for xlabel including sample size
n_2 <-  sum(with(df, class == 2 & score_total >= 1), na.rm = TRUE)     
year2 <- paste0("Second Year\nn = ", n_2) #text string for xlabel
n_3 <-  sum(with(df, class == 3 & score_total >= 1), na.rm = TRUE)     
year3 <- paste0("Third Year\nn = ", n_3) #text string for xlabel
n_4 <-  sum(with(df, class == 4 & score_total >= 1), na.rm = TRUE)     
year4 <- paste0("Fourth Year\nn = ", n_4) #text string for xlabel

## plot description
ggplot(
  data = df, 
  aes(x = as.factor(class), y = score_total)
  ) +
  geom_hline(
    yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
    colour = "red", 
    linetype = 'dashed'
  ) +
  stat_boxplot(geom = "errorbar", stat_params = list(width = 0.3)) +
  geom_boxplot(width = 0.5 , fill = "darkgoldenrod1") +    
  coord_cartesian(xlim = c(0.5,6),ylim = c(600, 1650)) +
  scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
  labs(title = graph_title, x = "Year", y = "CLA+ Score")  +
  theme(
    panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
    panel.background = element_rect("white"), #change background colour
    panel.grid.major.x = element_blank(), # remove vertical lines
    panel.grid.major.y = element_blank(), # remove horizontal lines
    panel.grid.minor.y = element_blank(),
    legend.title = element_blank(), #remove legend title
    plot.title = element_text(size = 15),
    axis.title.x = element_blank(), # remove x axis title
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12) #size of x axis labels
  ) +
  annotate( # add labels for CLA mastery levels
    "text", 
    fontface = "bold", 
    size = 4,
    alpha = c(0.5, 0.5,0.5,0.5,0.5, 0.8), # transparency (0-1)
    x = 5.2, y = c(900, 1030, 1164, 1300, 1430, 1530), 
    label = c("Below Basic", "Basic", "Proficient", "Accomplished", "Advanced", "CLA Mastery Levels"), 
    colour = "red"
  ) 

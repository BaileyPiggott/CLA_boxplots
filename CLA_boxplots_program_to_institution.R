
#CLA test

source("CLA_boxplots_setup.R")

# choose what to plot
df <- dram
prog_name <- "Drama"

df <- psyc
prog_name <- "Psychology"

df <- phys
prog_name <- "Physics"

df <- eng
prog_name <- "Engineering"


#calculate sample sizes:
n_1 <-  sum(with(df, class == 1 & score_total >= 1), na.rm = TRUE)     
year1 <- paste0("First Year\nn = ", n_1, "   n = ", n_q_1) #text string for xlabel including sample size
n_2 <-  sum(with(df, class == 2 & score_total >= 1), na.rm = TRUE)     
year2 <- paste0("Second Year\nn = ", n_2, "   n = ", n_q_2) #text string for xlabel
n_3 <-  sum(with(df, class == 3 & score_total >= 1), na.rm = TRUE)     
year3 <- paste0("Third Year\nn = ", n_3, "   n = ", n_q_3) #text string for xlabel
n_4 <-  sum(with(df, class == 4 & score_total >= 1), na.rm = TRUE)     
year4 <- paste0("Fourth Year\nn = ", n_4, "   n = ", 0) #text string for xlabel

df <- rbind(df, queens, fix) # combine with all queens data
graph_title <- paste0(prog_name, " CLA Scores") # graph title

## plot description
ggplot(
  data = df, 
  aes(x = as.factor(class), y = score_total, fill = Subject)
  ) +
  geom_hline(
    yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
    colour = "red", 
    linetype = 'dashed'
    ) +
  geom_boxplot(width = 0.5) +    
  coord_cartesian(xlim = c(0.5,6),ylim = c(600, 1650)) +
  scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
  labs(title = graph_title, x = "Year", y = "CLA+ Score")  +
  scale_fill_manual(
    values =  c("darkgoldenrod1", "steelblue3"),
    labels = c(prog_name, "Queen's")
  )+
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


# adjust box width for 4th year
dd<-ggplot_build(p) # characteristics of plot

#missing 4th year
dd$data[[2]]$xmin[5]<-4 # fix width of 4th box
dd$data[[2]]$x[5]<-4.09375 # move whisker to middle of 4th box

#missing 2nd and 4th year
dd$data[[2]]$xmin[3]<-2 # fix width of 2nd box
dd$data[[2]]$x[3]<-2.09375 # move whisker to middle of 2nd box
dd$data[[2]]$xmin[4]<-4 # fix width of 4th box
dd$data[[2]]$x[4]<-4.09375 # move whisker to middle of 4th box

#engineering - no 4th year institutional level
dd$data[[2]]$xmax[5]<-4 # fix width of 4th box
dd$data[[2]]$x[5]<-3.90625 # move whisker to middle of 4th box


grid.draw(ggplot_gtable(dd)) # plot new graph

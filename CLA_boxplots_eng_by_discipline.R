# CLA boxplots by engineering discipline

source("setup_eng_CLA.R") #MUST RUN EVERY TIME... eng_vs_artsci USES SOME OF THE SAME VARIABLE NAMES

# CHOOSE DISICPLINE -------------------------------------------------------

  df = mech
  disc_name = "Mechanical Engineering" # text string for title and legend

  df = elec
  disc_name = "Electrical Engineering"

  df = cmpe
  disc_name = "Computer Engineering"
  dummy <- dummy_4 %>% mutate(plan = "CMPE")

  df = civl
  disc_name = "Civil Engineering"

  df = chem
  disc_name = "Chemical Engineering"

  df = ench
  disc_name = "Engineering Chemistry"
  dummy <- dummy_4 %>% mutate(plan = "ENCH")

  df = mine
  disc_name = "Mining Engineering"
  dummy <-dummy_4 %>% mutate(plan = "MINE")

  df = geoe
  disc_name = "Geological Engineering"

  df = enph
  disc_name = "Engineering Physics"
  dummy <- bind_rows(dummy_1, dummy_2) %>% mutate(plan = "ENPH")

  df = mthe
  disc_name = "Math and Engineering"
  dummy <- dummy_4 %>% mutate(plan = "MTHE")

# CREATE PLOT -------------------------------------------------------------

#calculate sample sizes:
n_1 <-  sum(with(df, year == 1 & score_total >= 1), na.rm = TRUE)     
year1 <- paste0("First Year\nn = ", n_1, "   n = ", n_eng_1) #text string for xlabel including sample size
n_2 <-  sum(with(df, year == 2 & score_total >= 1), na.rm = TRUE)     
year2 <- paste0("Second Year\nn = ", n_2, "   n = ", n_eng_2) #text string for xlabel
n_3 <-  sum(with(df, year == 3 & score_total >= 1), na.rm = TRUE)     
year3 <- paste0("Third Year\nn = ", n_3, "   n = ", n_eng_3) #text string for xlabel
n_4 <-  sum(with(df, year == 4 & score_total >= 1), na.rm = TRUE)     
year4 <- paste0("Fourth Year\nn = ", n_4, "   n = ", n_eng_4) #text string for xlabel


df <- rbind(df, all_eng, fix, dummy) # combine with all queens data
graph_title <- paste0(disc_name, " CLA Scores") # graph title

## plot description
ggplot(
  data = df, 
  aes(x = as.factor(year), y = score_total, fill = plan)
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
    labels = c(disc_name, "All Engineering")
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

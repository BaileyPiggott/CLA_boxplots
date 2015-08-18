# boxplot with all engineering disciplines

source("setup_eng_CLA.R")
#SET UP DATA FRAME FOR PLOTTING --------------------
all_disp <- bind_rows(chem, civl, cmpe, elec, ench, enph, geoe, mech, mine, mthe)

cla_eng_mean <- mean(all_disp$score_total, na.rm = TRUE)

# add dummy data for disciplines that are missing a year of data
cmpe_4 <- data.frame("studentid" = NA,	"score_total" = 10, 	"semester" = NA, 	"plan" = "CMPE",	"course" = NA,	"year" = 4)
ench_4 <- data.frame("studentid" = NA,  "score_total" = 10, 	"semester" = NA, 	"plan" = "ENCH",	"course" = NA,	"year" = 4)
enph_2 <- data.frame("studentid" = NA,  "score_total" = 10, 	"semester" = NA, 	"plan" = "ENPH",	"course" = NA,	"year" = 2)
mine_4 <- data.frame("studentid" = NA,  "score_total" = 10, 	"semester" = NA, 	"plan" = "MINE",	"course" = NA,	"year" = 4)
mthe_4 <- data.frame("studentid" = NA,  "score_total" = 10, 	"semester" = NA, 	"plan" = "MTHE",	"course" = NA,	"year" = 4)

# combine with actual data
all_disp <- bind_rows(all_disp, cmpe_4, ench_4, enph_2, mine_4, mthe_4)

# change year column to better titles for plotting
all_disp$year <- as.character(all_disp$year)

all_disp$year[all_disp$year== "1"] <- "Year 1"
all_disp$year[all_disp$year== "2"] <- "Year 2"
all_disp$year[all_disp$year== "4"] <- "Year 4"

# AVERAGED YEARS ----------------------------

ggplot(data = all_disp, aes(x = plan, y = score_total)) +
  geom_hline(
    yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
    colour = "red", 
    linetype = 'dashed'
    ) +
  geom_hline(yintercept = cla_eng_mean, colour = "steelblue4") +
  geom_boxplot(width = 0.5, fill = "steelblue") +  
  coord_cartesian(xlim = c(0.5,12),ylim = c(650, 1650)) +
  labs(title = "Engineering CLA+ Scores", x = "Engineering Discipline", y = "CLA+ Score")  +
  theme(
    panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
    panel.background = element_rect("white"), #change background colour
    panel.grid.major.x = element_blank(), # remove vertical lines
    panel.grid.major.y = element_blank(), # remove horizontal lines
    panel.grid.minor.y = element_blank(),
    legend.key = element_blank(), # delete legend
    legend.title = element_blank(),
    plot.title = element_text(size = 15),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12) #size of x axis labels
  ) +
  annotate( # add labels for CLA mastery levels
    "text", 
    fontface = "bold", 
    size = 4,
    hjust = 1,
    alpha = c(0.5, 0.5,0.5,0.5,0.5, 0.8), # transparency (0-1)
    x = 11.8, y = c(900, 1030, 1164, 1300, 1430, 1530), 
    label = c("Below Basic", "Basic", "Proficient", "Accomplished", "Advanced", "CLA Mastery Levels"), 
    colour = "red"
  ) 

# DODGED YEARS ----------------------------

ggplot(data = all_disp, aes(x = plan, y = score_total, fill = year)) +
  geom_hline(
    yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
    colour = "red", 
    linetype = 'dashed'
    ) +
  geom_boxplot(width = 0.5) +  
  coord_cartesian(xlim = c(0.5,12),ylim = c(650, 1650)) +
  labs(title = "Engineering CLA+ Scores", x = "Engineering Discipline", y = "CLA+ Score")  +
  scale_fill_manual(
    values =  c("lightskyblue1", "steelblue2", "steelblue4")
    )+
  theme(
    panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
    panel.background = element_rect("white"), #change background colour
    panel.grid.major.x = element_blank(), # remove vertical lines
    panel.grid.major.y = element_blank(), # remove horizontal lines
    panel.grid.minor.y = element_blank(),
    legend.key = element_blank(), # delete legend
    legend.title = element_blank(),
    plot.title = element_text(size = 15),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12) #size of x axis labels
  ) +
  annotate( # add labels for CLA mastery levels
    "text", 
    fontface = "bold", 
    size = 4,
    hjust = 1,
    alpha = c(0.5, 0.5,0.5,0.5,0.5, 0.8), # transparency (0-1)
    x = 11.8, y = c(900, 1030, 1164, 1300, 1430, 1530), 
    label = c("Below Basic", "Basic", "Proficient", "Accomplished", "Advanced", "CLA Mastery Levels"), 
    colour = "red"
  ) 

# FACET PLOT BY YEAR-----------------------

ggplot(data = all_disp, aes(x = plan, y = score_total, fill = year)) +
  geom_hline(
    yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
    colour = "red", 
    linetype = 'dashed'
  ) +
  geom_boxplot(width = 0.5) +  
  facet_grid(year~.) +
  coord_cartesian(xlim = c(0.5,12),ylim = c(650, 1650)) +
  #scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
  labs(title = "Engineering CLA+ Scores", x = "Engineering Discipline", y = "CLA+ Score")  +
  scale_fill_manual(
    values =  c("lightskyblue1", "steelblue2", "steelblue4")
    )+
  theme(
    panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
    panel.background = element_rect("white"), #change background colour
    panel.grid.major.x = element_blank(), # remove vertical lines
    panel.grid.major.y = element_blank(), # remove horizontal lines
    panel.grid.minor.y = element_blank(),
    legend.position = "none", # delete legend
    plot.title = element_text(size = 15),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12) #size of x axis labels
  ) +
  annotate( # add labels for CLA mastery levels
    "text", 
    fontface = "bold", 
    size = 4,
    hjust = 1,
    alpha = c(0.5, 0.5,0.5,0.5,0.5, 0.8), # transparency (0-1)
    x = 11.8, y = c(900, 1030, 1164, 1300, 1430, 1530), 
    label = c("Below Basic", "Basic", "Proficient", "Accomplished", "Advanced", "CLA Mastery Levels"), 
    colour = "red"
  ) 
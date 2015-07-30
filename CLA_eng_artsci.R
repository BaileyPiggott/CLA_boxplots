
## set up data frames for each program and add column with program name
source("CLA_boxplots_setup.R") 

# SET UP DATA FRAMES AND SAMPLE SIZES ------------------------------------------------------

# engineering
eng <- cla %>% subset(major_primary == 11) %>% 
  mutate(Subject = "Eng")  %>% 
  select(-major_primary) # remove major primary column

n_eng_1 <-  sum(with(eng, class == 1 & score_total > 1), na.rm = TRUE)  
n_eng_2 <-  sum(with(eng, class == 2 & score_total > 1), na.rm = TRUE) 
n_eng_3 <-  sum(with(eng, class == 3 & score_total > 1), na.rm = TRUE) 
n_eng_4 <-  sum(with(eng, class == 4 & score_total > 1), na.rm = TRUE) 


# artsci students and sample sizes
artsci <- bind_rows(psyc, dram, phys) %>% mutate(Subject = "ArtSci") %>% unique()%>% select(-major_primary)

n_artsci_1 <-  sum(with(artsci, class == 1 & score_total > 1), na.rm = TRUE)  
n_artsci_2 <-  sum(with(artsci, class == 2 & score_total > 1), na.rm = TRUE) 
n_artsci_3 <-  sum(with(artsci, class == 3 & score_total > 1), na.rm = TRUE) 
n_artsci_4 <-  sum(with(artsci, class == 4 & score_total > 1), na.rm = TRUE) 

#some programs do not have data in some years
#need to add null scores for each year so plots work properly
fix <- data.frame(c(NA,NA,NA,NA),c(1,2,3,4),c(NA,NA,NA,NA),c(NA,NA,NA,NA),c(NA,NA,NA,NA))
colnames(fix) <- colnames(artsci)

dummy_4 <- data.frame(NA, 4, 60, "ArtSci") # fix box width in 4th year
colnames(dummy_4) <- colnames(artsci)

# combine data frames:

all_cla <- bind_rows(eng, artsci, dummy_4, fix)


#x labels
year1 <- paste0("First Year\nn = ", n_artsci_1, "   n = ", n_eng_1) #text string for xlabel including sample size   
year2 <- paste0("Second Year\nn = ", n_artsci_2, "   n = ", n_eng_2) #text string for xlabel   
year3 <- paste0("Third Year\nn = ", n_artsci_3, "   n = ", n_eng_3) #text string for xlabel  
year4 <- paste0("Fourth Year\nn = ", n_artsci_4, "   n = ", n_eng_4) #text string for xlabel


# CREATE PLOT -------------------------------------------------------------

ggplot(
  data = all_cla, 
  aes(x = as.factor(class), y = score_total, fill = Subject)
) +
  geom_hline(
    yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
    colour = "red", 
    linetype = 'dashed'
  ) +
  geom_boxplot(width = 0.5) +    
  coord_cartesian(xlim = c(0.5,5.9),ylim = c(600, 1650)) +
  scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
  labs(title = "CLA Scores", x = "Year", y = "CLA+ Score")  +
  scale_fill_manual(
    values = c("firebrick2", "darkgoldenrod1")
  ) +
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



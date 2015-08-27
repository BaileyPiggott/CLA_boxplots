### CLA Boxplots
Various boxplots of Queen's CLA scores.

####File Descriptions:

**CLA_boxplots_program_to_institution**: Boxplots of a chosen program's(engineering, psychology, physics, or drama) CLA scores compared to the institutional level.

**CLA_boxplots_eng_by_disicipline**: Boxplots comparing chosen engineering disicpline to all engineering CLA scores.

**CLA_boxplots_all_engineering**: Boxplots with all 10 engineering discipline CLA scores. Has a plot of all years' scores averaged for each discipline, a plot with the boxes dodged by years, and a plot with separate facet for each year.

**CLA_eng_artsci**: Boxplot comparing engineering CLA scores to artsci(psychology, physics, and drama combined).

**CLA_by_task**: Boxplots of a chosen program's(engineering, psychology, physics, or drama) CLA sub-score(performance task or selected response) compared to the institutional level.

**CLA_boxplots_no_comparison**: Boxplots of chosen program scores (engineering, physics, psychology, or drama).

**CLA_boxplots_setup**: Creates dataframes of CLA scores for each program by joining spreadsheet of scores with class lists by student ID. So a student who took multiple classes(e.g. PSYC100 and DRAM100) will have their score appear in multiple programs' scores. However, their score is not duplicated in the institutional level dataframe.

**setup_eng_CLA**: separates engineering score dataframe created in *CLA_boxplots_setup* into dataframes for each of the 10 engineering disciplines.

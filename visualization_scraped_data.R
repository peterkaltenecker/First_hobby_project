library(tidyverse)
library(scales)

###############
# data import #
###############

scraped_data_df <- read_csv("goodreads_best_book_cat_data.csv", 
                            col_types = cols(year = col_integer(), 
                                             total_votes = col_integer(), 
                                             bestbook_votes = col_integer()))

#######################################
# visualization of the collected data #
#######################################

# defining colors for the categories of votes
colors <- c("Total votes" = "#3371ff", 'Best book votes' = "#ff9633")

# plot
scraped_data_df %>% 
  ggplot() +
  geom_col(aes(total_votes, category, fill = "Total votes"), 
           alpha = 0.75, width = 0.9) +
  geom_col(aes(bestbook_votes, category, fill = "Best book votes"), 
           alpha = 1, width = 0.9) +
  facet_wrap("year") +
  scale_x_continuous(limits = c(0, 650000), expand = c(0, 0), 
                     labels = scales::label_number_si()) +
  labs(title = "Number of votes per year",
       x = "Number of votes",
       y = "Category",
       fill = "Legend") +
  scale_fill_manual(values = colors) +
  theme_light() +
  theme(axis.title = element_text(face = "bold", size = 8),
        axis.text = element_text(size = 6),
        legend.title = element_blank(),
        legend.text = element_text(size = 8),
        legend.position = "bottom",
        panel.grid.major.y = element_blank(),
        strip.background = element_rect(fill = "#878787"),
        strip.text = element_text(face = "bold"),
        aspect.ratio = 0.7)

# saving the created plot
ggsave("visualization_book_votes.jpg", dpi = 300)
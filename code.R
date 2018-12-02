install.packages("tidyverse")
install.packages("ggplot2")
library(tidyverse) 
library(ggplot2)

#Living planet data ----
LPI <- read_csv("./data/LPIdata_Feb2016.csv")

LPI <- LPI %>% 
  gather(key = "year", value = "population", select = 26:70) %>%
  mutate(binomial = paste(Genus, Species, sep = "_")) %>% 
  filter(population >= 0) %>% 
  group_by(binomial) %>% 
  mutate(max_year = max(year), min_year = min(year),  
         lengthyear = as.integer(max_year) - as.integer(min_year), 
         pop_trend = (population - min(population))/(max(population) - min(population))) %>% 
  ungroup() 

eu_puffins <- filter(LPI_l, Genus == "Fratercula", Species == "arctica", 
                     `Country list` !="Russian Federation") %>%
  select(`Country list`, year, pop_trend, id) %>% 
  group_by(id) %>%
  filter(length(year)>10) 


write_csv(eu_puffins, file.path("puffin_toplot.csv")) 


#Climate data -----
climate_data <- read_csv("./data/Lerwick_temp_data.csv")

mean_t_data <- climate_data %>% 
  group_by(year) %>%  
  summarise(mean_tmax = mean(tmax),  
            mean_tmin = mean(tmin)) %>% 
  write_csv(file.path("mean_t_data.csv")) # new csv with mean t data

puffin_temp <- merge(eu_puffins, mean_t_data) %>%
  write_csv(file.path("puffins_temp.csv")) 

# Compare Puffin populations with temperature-----

# Max temps
ggplot(puffin_temp) + 
  ggtitle("Comparison between puffin abundance and max. temperature changes (1930-2018)") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, size = 11, face = "bold"),
        panel.background = element_rect(fill = "white"),
        panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
        panel.border = element_rect(colour = "grey", fill = NA)) +
  scale_colour_discrete(name = "Puffins i.d.") +
  xlab("Mean max. temperature (°C)") + ylab("Population trend") +
  geom_point(aes(x = mean_tmax, y = pop_trend, 
                 colour = as.factor(id))) +
  geom_smooth(aes(x = mean_tmax, y = pop_trend, 
                  colour = as.factor(id)), method = 'lm')

ggsave("pop_tmax.png", last_plot(),
       width = 20, height = 10,
       dpi = 500) #saved fourth plot

# Min temps
ggplot(puffin_temp) + 
  ggtitle("Comparison between puffin abundance and min. temperature changes (1930-2018)") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, size = 11, face = "bold"),
        panel.background = element_rect(fill = "white"),
        panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
        panel.border = element_rect(colour = "grey", fill = NA)) +
  scale_colour_discrete(name = "Puffins i.d.") +
  xlab("Mean min. temperature (°C)") + ylab("Population trend") +
  geom_point(aes(x = mean_tmin, y = pop_trend, 
                 colour = as.factor(id))) + 
  geom_smooth(aes(x = mean_tmin, y = pop_trend, 
                  colour = as.factor(id)), 
              method = 'lm') 

ggsave("./main_fig/pop_tmin.png", last_plot(),
       width = 20, height = 10,
       dpi = 500) #saved fifth plot

# Selected values to correlate------
corpuffin_temp <- puffin_temp %>% 
  select(id, year, mean_tmax, mean_tmin, pop_trend) %>%
  spread(key = "id", value = "pop_trend") %>%
  drop_na() %>% 
  
  write_csv(file.path("corr_values.csv")) 

# Reshape data, opened package-------
library(reshape2)

cormat <- round(cor(corpuffin_temp[, c(2:9)]),2) %>%
  melt() 

# plot of correlation mat----
ggplot(cormat, 
       aes(x = Var1, y = Var2, fill = value)) + 
  ggtitle("Correlation mat of population trends") +
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, 
                                  size = 11, face = "bold")) +
  geom_tile()

ggsave("cormat.png", last_plot(),
       width = 20, height = 10, 
       dpi = 500) 
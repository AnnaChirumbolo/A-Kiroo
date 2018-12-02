library(tidyverse) 
library(reshape2)
library(ggplot2)

# Living planet data
LPI <- read_csv("./data/LPIdata_Feb2016.csv")

# Climate data 
climate_data <- read_csv("./data/Lerwick_temp_data.csv")

# Puffins data transformation
LPI <- LPI %>% 
  gather(key = "year", value = "population", select = 26:70) %>% 
  mutate(binomial_id = paste(Genus, Species, id, sep = "_")) %>% 
  filter(population >= 0) %>% 
  group_by(binomial_id) %>% 
  mutate(max_year = max(year), min_year = min(year), 
         lengthyear = as.integer(max_year) - as.integer(min_year), 
         pop_trend = (population - min(population))/(max(population) - min(population))) %>%
  ungroup() 

# European puffins only 

eu_puffins <- filter(LPI, Genus == "Fratercula", Species == "arctica",
         `Country list` !="Russian Federation") %>% 
  select(`Country list`, year, pop_trend, id)  %>% 
  group_by(id) %>%
  filter(length(year)>10) 

# Mean T 

mean_t_data <- climate_data %>% 
  group_by(year) %>%
  summarise(mean_tmax = mean(tmax),  
            mean_tmin = mean(tmin)) 

# Merging EU puffins and mean T

puffin_temp <- merge(eu_puffins, mean_t_data) 

# Select values to correlate
corpuffin_temp <- puffin_temp %>% 
  select(id, year, mean_tmax, mean_tmin, pop_trend) %>%
  spread(key = "id", value = "pop_trend") %>%
  drop_na() 

# Correlation 

cormat <- round(cor(corpuffin_temp[, c(2:9)]),2) %>%
  melt() 

# Puffins EU (Norway)
ggplot(eu_puffins, aes(x = year, y = pop_trend, 
                colour = as.factor(id))) +
       geom_line(group = "id") +
       geom_point() +
  ggtitle("European puffins population trends (1930-2018)") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, face = "bold"),
        panel.background = element_rect(fill = "white"),
        panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
        panel.border = element_rect(colour = "grey", fill = NA)) +
  ylab("Population trends") + 
  xlab("Years") +
  labs(colour = "ID")

ggsave("./main_fig/pop_tmin.png", last_plot(),
       width = 20, height = 10,
       dpi = 500) #saved fifth plot

# Compare Puffin populations with temperature

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
                  colour = as.factor(id)), 
              method = 'lm') 

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
# Correlation mat

ggplot(cormat, 
       aes(x = Var1, y = Var2, fill = value)) + 
  ggtitle("Correlation mat of population trends") +
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, 
                                  size = 11, face = "bold")) +
          geom_tile()


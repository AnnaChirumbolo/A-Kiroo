## Code used in appendix.Rmd file ----

# for blocking images in place in output

```{r}
knitr::knit_hooks$set(plot = function(x, options)  {
  hook_plot_tex(x, options)
})
```

# packages installed 

library(knitr)  # for dynamic report generation
library(kableExtra) # to build complex HTML or 'LaTex' tables
library(tidyverse) # for data manipulation
library(ggplot2) # to make beautiful graphs

# opened file - puffins 
puffins_t <- read.csv("./data/puffins_temp.csv")

# changed column titles 
puffins_t <- puffins_t %>%
  rename("Year" = year, "Country list" = Country.list,
  "Population trend" = pop_trend, "ID" = id, "Mean max. T (°C)" = mean_tmax,
  "Mean min. T (°C)" = mean_tmin)

# first table shown
puffins_t %>%
   slice(1:10) %>%   # the table is going to show only the first 10 lines (a sample of the data set)
   kable(digits = 2) %>% # each value has 2 decimal digits
   kable_styling(full_width = F,
                 position = "center", font_size = 10)
                 # table settings with the kableExtra package

# second table shown 
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(full_width = F,
                position = "center", font_size = 10) %>%
  column_spec(3, color = "red", bold = T)  %>% # one column
  column_spec(5:6, color = "green", bold = T) # set of columns

# three table shown 
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(full_width = F,
                position = "center", font_size = 10) %>%
  row_spec(0, bold = T, font_size= 12) # row '0' is the headings

# fourth table shown 
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(full_width = F,
                position = "center", font_size = 10) %>%
  add_header_above(c(" ", "EU puffins" = 3, "Mean Temperatue (°C)" = 2), bold=T,
                    font_size=13) %>% # this adds one header the columns 2-3-4,
                                        # and one for the columns 5-6.
  group_rows("1970s", 1,2) %>% # the first two rows are grouped as 1970s
  group_rows("1980s", 3,10) # the remaining rows are grouped as 1980s


# opened - climate data 
climate_data <- read.csv("./data/Lerwick_temp_data.csv")

  # filter climate data only during years 1979-2008.
  climate_data <- climate_data %>%
    filter(year >= 1979 & year <= 2008)

  # plot the climate data
  climate_plot <- ggplot(climate_data) +
    ggtitle("Temperature change (1930-2018)") +
    theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"),
          panel.background = element_rect(fill = "white"),
          panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
          panel.border = element_rect(colour = "grey", fill = NA),
          axis.text = element_text(size=15),
          axis.title = element_text(size = 20),
          legend.text = element_text(size=15),
          legend.title = element_blank()) +
    ylab("Temperature (°C)") + xlab(" ") +
    geom_line(aes(x = year, y = tmin, colour = "tmin")) +
    geom_point(aes(x = year, y = tmin, colour = "tmin")) +
    geom_line(aes(x = year, y = tmax, colour = "tmax")) +
    geom_point(aes(x = year, y = tmax, colour = "tmax")) +
    scale_color_discrete(name = "Temp.", labels = c ("Tmax", "Tmin"))

# find average for climate (max and min values)
    mean_t_data <- climate_data %>%
      group_by(year) %>%
      summarise(mean_tmax = mean(tmax),
                mean_tmin = mean(tmin)) # there is no need to filter the years again because this code runs on the last changes made in the previous code (where the years have already been filtered).

# plot the average min and max values 
    meant_plot <- ggplot(mean_t_data) +
      ggtitle("Mean temperature change (1930-2018)") +
      theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"),
            panel.background = element_rect(fill = "white"),
            panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
            panel.border = element_rect(colour = "grey", fill = NA),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 15),
            legend.text = element_text(size = 15),
            legend.title = element_blank()) +
      ylab("Average temperature (°C)") + xlab(" ") +
      geom_line(aes(x = year, y = mean_tmin, colour = "mean_tmin")) +
      geom_point(aes(x = year, y = mean_tmin, colour = "mean_tmin")) +
      geom_line(aes(x = year, y = mean_tmax, colour = "mean_tmax")) +
      geom_point(aes(x = year, y = mean_tmax, colour = "mean_tmax")) +
      scale_color_discrete(name = "Temp.", labels = c ("Mean Tmax", "Mean Tmin"))

# called the two plots (in the separate chunk) 
climate_plot
meant_plot

# opened the same figures from external folder 
img_appendix<-list.files("appendix_fig/", pattern = ".png", full.names = TRUE)
include_graphics(img_appendix)

# to insert the code used to make the 'mock_dissertation' within this code chunk 
```{r code=readLines(knitr::purl('./main_text.Rmd', documentation = 0)), eval = FALSE}
```


------ 

## Code used in main_text.Rmd file ----


# Loading necessary packages
library(tidyverse)  # data transformation
library(reshape2) # restructure and aggregate data
library(ggplot2) # create beautiful graphs

# Load Living planet data
LPI <- read_csv("./data/LPIdata_Feb2016.csv")

# Load climate data
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
  filter(length(year)>10)  # studies longer than 10 years, it results they have
                            # been carried out exclusively in Norway.

# Mean T

mean_t_data <- climate_data %>%
  group_by(year) %>%
  summarise(mean_tmax = mean(tmax),
            mean_tmin = mean(tmin))

# Merging EU puffins and mean T

puffin_temp <- merge(eu_puffins, mean_t_data)

write_csv(file.path("puffins_temp.csv"))

# Select values to correlate
corpuffin_temp <- puffin_temp %>%
  select(id, year, mean_tmax, mean_tmin, pop_trend) %>%
  spread(key = "id", value = "pop_trend") %>%
  drop_na()

write_csv(corpuffin_temp, file.path("corr_values.csv"))

# Correlation

cormat <- round(cor(corpuffin_temp[, c(2:9)]),2) %>%
  melt()

  # Compare Puffin populations with temperature

    # Max temps
  ggplot(puffin_temp) +
    ggtitle("Comparison between puffin abundance and max. temperature changes (1930-2018)\n") +
    theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, size = 11, face = "bold"),
          panel.background = element_rect(fill = "white"),
          panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
          panel.border = element_rect(colour = "grey", fill = NA)) +
    scale_colour_discrete(name = "Puffins i.d.") +
    xlab("\nMean max. temperature (°C)") + ylab("Population trend\n") +
    geom_point(aes(x = mean_tmax, y = pop_trend,
                   colour = as.factor(id))) +
    geom_smooth(aes(x = mean_tmax, y = pop_trend,
                    colour = as.factor(id)),
                method = 'lm')
ggsave("pop_tmax.png", last_plot(),
        width = 20, height = 10,
        dpi = 500)

  # Compare Puffin populations with temperature

    # Min temps
  ggplot(puffin_temp) +
    ggtitle("Comparison between puffin abundance and min. temperature changes (1930-2018)\n") +
    theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, size = 11, face = "bold"),
          panel.background = element_rect(fill = "white"),
          panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
          panel.border = element_rect(colour = "grey", fill = NA)) +
    scale_colour_discrete(name = "Puffins i.d.") +
    xlab("\nMean min. temperature (°C)") + ylab("Population trend\n") +
    geom_point(aes(x = mean_tmin, y = pop_trend,
                   colour = as.factor(id))) +
    geom_smooth(aes(x = mean_tmin, y = pop_trend,
                    colour = as.factor(id)),
                method = 'lm')
ggsave("pop_tmin", last_plot(),
       width = 20, height = 10,
       dpi = 500)

ggplot(cormat,
       aes(x = Var1, y = Var2, fill = value)) +
  ggtitle("Correlation mat of population trends") +
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5,
                                  size = 11, face = "bold")) +
  geom_tile()

ggsave("cormat.png", last_plot(),
       width = 20, height = 10,
       dpi = 500)

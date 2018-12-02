# Tutorial challenge

<center><img src="{{ site.baseurl }}/tutheaderbl.png" alt="Img"></center>

To add images, replace `tutheaderbl1.png` with the file name of any image you upload to your GitHub repository.

### Tutorial Aims

1. Understand the advantages of using Rmarkdown for writing documents, Appendices in this case;

2. Learn how to create different types of Appendices;

3. Become familiar with three different markup languages - Markdown, HTML and LaTex - which can be used interchangeably throughout the document;

4. Learn how to add the Appendix file to the main body of text;

5. Become familiar with `knitr` and `kableExtra` packages.

### Steps:

#### <a href="#section1"> 1. Are you familiar with `Rmarkdown`?</a>
#### <a href="#section2"> 2. Appendices.</a>
#### <a href="#section3"> 3. Open the R Markdown file.</a>
#### <a href="#section4"> 4. Appendix I: sample of raw data tables.</a>
#### <a href="#section5"> 5. Appendix II: additional figures.</a>
#### <a href="#section6"> 6. Appendix III: code.</a>
#### <a href="#section7"> 7. Insert the Appendix in the main text.</a>
#### <a href="#section8"> 8. Try it yourself!</a>



<a name="section1"></a>

## 1. Are you familiar with `Rmarkdown`?

This tutorial is intended for people who are familiar with the basics of `Rmarkdown`.
If you have never heard of or used `Rmarkdown`, check this ['Getting Started with R Markdown'](https://ourcodingclub.github.io/2016/11/24/rmarkdown-1.html) Coding Club tutorial.

Once you have completed it, you can come back to this one!

<a name="section2"></a>

## 2. Appendices

*What are Appendices?*

Appendices contain supplementary content, which forms a part of a main document but is not essential to its completeness. This means that, even without the Appendix, the main document should be able to stand on its own. However, Appendices are often used in academic writing, to cover data or details that are useful for contextualising and giving background information to the main material.**Add REFERENCES**

Some general rules on formatting Appendices:
1. They appear at the end of the document, often after references (**ADD REFERENCES IN MAIN TEXT?**);

2. There are different Appendices depending on the topic, and each starts on a new page;

3. If there are multiple Appendices these are labelled with letters, and usually they are accompanied by a title that clarifies the content;

4. Appendices are also included in the table of documents at the beginning of the main document.

In this tutorial we're going to explore how to follow these formatting rules using `Rmarkdown`. We are going to do so by exploring three different types of Appendices: for samples of raw data tables, for additional figures and for listing the code used in the main document. Finally, we are going to explore how to insert the appendix.Rmd created at the end of a mock 'main document'.

To get started, download this [GitHub Repository](https://github.com/EdDataScienceEES/tutorial-assignment-AnnaChirumbolo) as zip file in your local laptop/computer.

<a name="section3"></a>

## 3. Open the R Markdown file.

Open the 'appendix-template.Rmd' file. As you can see, the file is mainly empty. There is the YAML section at the top, with only this information:

<center><img src="https://user-images.githubusercontent.com/43357858/49344885-d087cc80-f674-11e8-9faf-08b7ddca3e59.png" alt="template-blank"></center>

The output is already set to pdf. You might wish to change the title to something else than 'Appendix-template'. Also make sure you have added your name as author, by adding 'Author:' on a separate line.
You can specify as many functions within the [YAML header](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf) as you find necessary, but we're just going to leave it basic for this tutorial.

Now, we can start writing the different headings for each Appendix we're going to create. Following the rules of formatting, each Appendix heading should be labelled with a letter (in order of mention in the main text), centred and in bold font, and have a title accompanying it to clarify the appendix content.

This centring cannot be achieved with `Markdown` syntax, when the output is a pdf, and it is easier to do with `LaTex` syntax although it might appear less straightforward at first.

To write the headings, copy this after the YAML header.

```
\begin{center}
\textbf{\LARGE Appendix A}

\textit{This appendix includes tables of sample data sets.}
\end{center}
```
This is written in `LaTex`.
The first and last lines define the beginning and end the area of text, the `{center}` centres the text in the page.
*Note: the writing is in American English. It won't work if you write in British English (i.e. "centre").*

 Write this twice more, changing the text to 'Appendix B' for the second and 'Appendix C' for the third. You also need to change the title for each by modifying the content in the braces of `\texttit{}`.

 ```
 # Heading 2: Appendix B
 \begin{center}
 \textbf{\LARGE Appendix B}

 \textit{This appendix includes additional figures.}
 \end{center}

# Heading 3: Appendix C
 \begin{center}
 \textbf{\LARGE Appendix C}

 \textit{This appendix includes the code used.}
 \end{center}

 ```

If you knit the document, you're going to notice that the the headings are just listed one after the other. To separate them into distinct pages (as required by formatting), add
```
\newpage
```
between headings. If you knit again, you're going to see that each heading starts on a different page (and each page is already numbered!).

Once this has been set up, you can create different types of Appendices in the following sections.

<a name="section4"></a>

## 4. Appendix I: Sample of raw data tables.

One type of Appendix could contain tables of the raw data collected, so that readers and reviewers have a better insight of the results that are summarised or only visually represented in the main body of text.

In this case we are going to create a table of a sample data set in Appendix A.

Insert a code chunk after the first heading and title, to install `knitr` and `kableExtra` packages.

~~~~
```{r, include = F}
library(knitr)  # for dynamic report generation
library(kableExtra) # to build complex HTML or 'LaTex' tables
library(tidyverse) # for data manipulation
```
~~~~

*Note: 'include=F' makes sure that neither code chunk nor output are shown in the pdf output.*

Also the `tidyverse` package has to be installed/loaded to do some data transformation. If you have never used the `tidyverse` package before don't worry - it is not part of the learning objectives for this tutorial. For now, just copy the code. If you want to learn about the Tidyverse, do this [Coding Club tutorial](https://ourcodingclub.github.io/2017/03/20/seecc.html).

The data set you are going to use is called 'puffins_temp.csv' - it contains information on population trends of Norwegian Atlantic puffins (*Fratercula arctica*) and the average of maximum and minimum temperature (°C) over the years 1979-2008.

```
puffins_t <- read.csv("./data/puffins_temp.csv")
```
If you have a look at the data set, the column names are not very nice to put in a table. We use the function `rename()` to change them (and this is where `Tidyverse` becomes useful!).

```
puffins_t <- puffins_t %>%
  rename("Year" = year, "Country list" = Country.list, "Population trend" = pop_trend, "ID" = id, "Mean max. T (°C)" = mean_tmax, "Mean min. T (°C)" = mean_tmin)
```

Now the data set is ready to be inserted in a table. `kableExtra` is a very nice package to do so since it allows to use pipes (same as `Tidyverse`) to create the table.

```
puffins_t %>%
  slice(1:10) %>%   # the table is going to show only the first 10 lines
  kable(digits = 2) %>%  # each value has 2 decimal digits
  kable_styling(bootstrap_options = "striped", full_width = F,
                position = "center", font_size = 10)  # table settings with the kableExtra package
```   

This is the output:

<center><img src="https://user-images.githubusercontent.com/43357858/49344930-8eab5600-f675-11e8-8663-bf7b25f517c5.png" alt="table-pt1"></center>


With `kableExtra` it is possible to customise the table way further. Just as an example, you can highlight one particular column or a set of columns...

```puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(bootstrap_options = "striped", full_width = F,
                position = "center", font_size = 10) %>%
  column_spec(3, color = "red", bold = T)  %>% # one column
  column_spec(5:6, color = "green", bold = T) # set of columns
```

<center><img src="https://user-images.githubusercontent.com/43357858/49344961-15603300-f676-11e8-87ce-2455d7dc83ad.png" alt="table-pt2"></center>

...or make the column titles bold...

```
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(bootstrap_options = "striped", full_width = F,
                position = "center", font_size = 10) %>%
  row_spec(0, bold = T) # row '0' is the headings
```

<center><img src="https://user-images.githubusercontent.com/43357858/49344967-2610a900-f676-11e8-8394-654478ae6aee.png" alt="table-pt3"></center>

...or even create subgroups within the table.

```
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(bootstrap_options = "striped", full_width = F,
                position = "center", font_size = 10) %>%
  add_header_above(c(" ", "EU puffins" = 2, " ", "Mean Temperatue (°C)" = 2)) %>% # this adds one header for the second and third columns, and one for the fifth and sixth columns
  group_rows("1970s", 1,2) %>% # the first two rows are grouped as 1970s
  group_rows("1980s", 3,10) # the remaining rows are grouped as 1980s
```

<center><img src="https://user-images.githubusercontent.com/43357858/49344977-5d7f5580-f676-11e8-8993-c25d843d3db8.png" alt="table-pt4"></center>

<sub>The figure does not show the whole table.</sub>
</br>
I have shown only a few of the functions offered by `kableExtra`. If you are interested in finding out more about the resources of the package, have a look at the [package manual](https://cran.r-project.org/web/packages/kableExtra/kableExtra.pdf).

<a name="section5"></a>

## 5. Appendix II: additional figures.

A second appendix that is often used contains additional figures. If you open the 'main_text.pdf' file, you can see what figures are used in the main body (the same figures are collected in the 'main_fig' folder in the [repository](https://github.com/EdDataScienceEES/tutorial-assignment-AnnaChirumbolo)). The figures show, respectively, trends in puffin populations with high and low average temperature (°C) values, and a correlation mat.

<center><img src="https://user-images.githubusercontent.com/43357858/49344984-7556d980-f676-11e8-8a57-5414339d94ea.png" alt="main-text-pics"></center>

Let's imagine we want to add more figures in the Appendix, for example to show the overall climate trend and averages of maximum and minimum temperature changes (°C) during that time period.

The graphs can be directly generated in the `R Markdown` file by using code chunks.

This code chunks produces the plot for climate trend.
~~~~
```{r, echo= F}
climate_data <- read.csv("./data/Lerwick_temp_data.csv")
library(ggplot2)

# graph for climate data
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
  ylab("Temperature (°C)") + xlab("Year") +
  geom_line(aes(x = year, y = tmin, colour = "tmin")) +
  geom_point(aes(x = year, y = tmin, colour = "tmin")) +
  geom_line(aes(x = year, y = tmax, colour = "tmax")) +  
  geom_point(aes(x = year, y = tmax, colour = "tmax")) +
  scale_color_discrete(name = "Temp.", labels = c ("Tmax", "Tmin"))
```
~~~~

And this one produces the mean max and min temperatures.

~~~~
```
mean_t_data <- climate_data %>%
  group_by(year) %>%  
  summarise(mean_tmax = mean(tmax),  
            mean_tmin = mean(tmin)) %>%
  write_csv(file.path("mean_t_data.csv")) # new csv with mean t data

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
```
~~~~

*Reminder: the chunk option `echo=F` allows to show the result, but not the code that generates it, in the final pdf output.*

By running these code chunks you won't see any outputs. That is because the graphs have been saved as objects 'climate_plot' and 'meant_plot', but neither has been called yet. You can call them in a separate chunk, to explore the chunk options for image settings.

Paste the following code chunk:

~~~~
```{r echo=F, out.width='.50\\linewidth', fig.width=10, fig.height=8,fig.show='hold'}
climate_plot
meant_plot
```
~~~~

<sub>
'out.width' lets you decide the width of the plot in the final output file (in this case it is written in 'LaTex', as you can see from the `\\` after the value; however there is also 'HTML' syntax in which the value is written as percentage, i.e. '50%');

'fig.width' and 'fig.height' define width and height of the plot, and their value needs to be numeric;

'fig.show' is used to arrange the plot in a certain place.
There are four possible values (all characters), and in this case 'hold' has been chosen because it places the plot at the very end of a code chunk.
</sub>

This is the result in the pdf output. If you knit the document you can check it out:
<div style="text-align:center"><img src ="/screenshots/figures-pt1.png" /></div>

<center><img src="https://user-images.githubusercontent.com/43357858/49345013-dc748e00-f676-11e8-962d-9098725cf1d1.png" alt="figures-pt1"></center>

Code chunks can be used also to insert figures that had already been saved from another script. In this case it is harder to manipulate  their dimensions - the font of the labels cannot be easily changed and there is the risk that the plot text becomes illegible. You can attempt changing the figure size as in the previous chunk, and see what happens.

~~~~
```{r, echo = TRUE, out.width='.50\\linewidth', fig.width=10, fig.height=8, fig.show='asis', fig.align='center', fig.cap="Additional images in Appendix B"}
library(knitr)
img_appendix<-list.files("tutorial_fig/", pattern = ".png", full.names = TRUE)
include_graphics(img_appendix)
```
~~~~

If you knit the document, you can see that the figures become really small and the text is barely legible. Even changing the width and height of the figures doesn't make a difference in this case.  

<center><img src="https://user-images.githubusercontent.com/43357858/49345018-00d06a80-f677-11e8-87f6-d8a348dd1f75.png" alt="figs-pt3"></center>

When images are loaded from an external source it is advised not to align the figures, but to have them bigger and following one another.

~~~~
```{r, echo = TRUE, out.height="40%", fig.show='hold', fig.align="center",  fig.cap="Additional images in Appendix B"}
img_appendix<-list.files("appendix_fig/", pattern = ".png", full.names = TRUE)
include_graphics(img_appendix)
```
~~~~
<sub>
'fig.align' defines the alignment of figures in the output;
</br>
'fig.cap' adds the figure caption at the bottom;
</br>
The 'list.files()' function lists the files present in a specified path. Here I chose the 'appendix_fig' folder, where all the figures to insert in the appendix had been saved;
</br>
The 'include_graphics()' function is part of the 'knitr' package, and it allows to embed external images in document format supported by 'knitr'.
</sub>


This is the result:

<center><img src="https://user-images.githubusercontent.com/43357858/49345029-26f60a80-f677-11e8-9d71-cb6bfb43d252.png" alt="figures-pt2"></center>

In this way the figures do occupy an entire page, but at least their labels are visible.

You can check this [blog post](https://yihui.name/knitr/options/) by **Yihui Xie** to find more about the *chunk options* available.

<a name="section6"></a>

## Appendix III: code.

The third and last example of Appendix in this tutorial includes the code used in the methods of the main document, to transform data and produce results (tables and figures). The main text does not show the code that produces a certain output, but only the output itself. Making the code used available in the Appendix favours the transparency and replicability of the work done.

There is a very simple, single line of code that takes all the code used from a specified document, joins it and presents it in one main code block. This can be done assuming that the main text itself was created from an `R Markdown` document. The code has to be credited to [Alex Hayes](https://twitter.com/alexpghayes/status/1039170310560464897):

~~~~
```{r code=readLines(knitr::purl('./main_text.Rmd', documentation = 0)), eval = FALSE}
```
~~~~
The function `purl` takes the source code from the main document (specified by the file path) and lists it within a macro code block that is not run (`eval=FALSE`).

<center><img src="https://user-images.githubusercontent.com/43357858/49345033-42f9ac00-f677-11e8-94c2-e0bbf94ee381.png" alt="code"></center>

*Great job getting so far!*

I have one last trick to show you.

<a name="section7"></a>

## 7. Insert the Appendix in the main text.

Now that the Appendix document is complete, it is time to add it to the main text!

There is a mock 'main_text.pdf' file in the repository. If you have a look, the only thing it is missing is the Appendix.

To add the content from the 'Appendix-template.Rmd' go to the 'Appendix' section at the end of the main document, and insert the following code chunk:
~~~~
```{r child='appendix.Rmd'}
```
~~~~

The `child` chunk option refers to *'smaller'* documents to be run and input into the main one.

If you knit the 'main_text.Rmd' file now, you can see the content from the Appendix document at the end.

*Hooray -*
**you have completed this tutorial!!**

<a name="section8"></a>

## 8. Try it yourself!

In the [repository](https://github.com/EdDataScienceEES/tutorial-assignment-AnnaChirumbolo), there is a folder called 'you_turn'. In there you can find a series of data sets in .csv with which you can explore more of the functions from the `knitr` and `kableExtra` package to make very professional tables. There is also a figure 'abundance_puffins.png' that you can use to play around by changing [code chunk options](https://yihui.name/knitr/options/).

## Useful links

If you are interested in R Markdown in general, follow this [link](https://bookdown.org/yihui/rmarkdown/) to *R Markdown: The Definitive Guide*.

If you would like to learn more about `LaTex` syntax and how to apply it for building up your thesis, check this series of [blog posts](https://rosannavanhespenresearch.wordpress.com/2016/02/03/writing-your-thesis-with-r-markdown-1-getting-started/) by **Rosanna van Hespen**. The GitHub Repository for these posts can be found [here](https://github.com/rosannav/thesis_in_rmarkdown/tree/master/example_thesis).

<hr>

#### If you have any questions about completing this tutorial, please contact me (*Anna*) on s1650956@sms.ed.ac.uk .

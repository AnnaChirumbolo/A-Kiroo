<center><img src="{{ site.baseurl }}/prep/tutheaderbl.png" alt="Img"></center>

<sub>By _**Anna**_, last edited on _**June 18**_, 2019

### Tutorial Aims

1. Understand the advantages of using `R Markdown` for writing documents, with a focus on appendices;

2. Learn how to create different types of appendices;

3. Have a glance at using LaTex in creating pdf files and supplement Markdown;

4. Learn how to add the Appendix file to the main body of text;

5. Become familiar with `knitr` and `kableExtra` packages.

### Steps:

#### <a href="#section1"> 1. The appendix document.</a>
#### <a href="#section2"> 2. Create the appendix sections using `LaTex` syntax.</a>
  <a href="#subsect1"><sub> (a) Why LaTex and not another markup language? </sub></a>

  <a href="#subsect2"><sub> (b) Write headings and titles </sub></a>

  <a href="#subsect3"><sub> (c) Place the appendices in distinct pages </sub></a>

#### <a href="#section3"> 3. Appendix A: tables of raw data.</a>
#### <a href="#section4"> 4. Appendix B: additional figures.</a>
#### <a href="#section5"> 5. Appendix C: code.</a>
#### <a href="#section6"> 6. Insert the Appendix in the main text.</a>
#### <a href="#section7"> 7. Try it yourself!</a>

<a name="section1"></a>

## 1. The appendix document.

*What are Appendices?*

Appendices contain supplementary content, which forms a part of a main document but is not essential to its completeness. This means that, even without the Appendix, the main document should be able to stand on its own. However, Appendices are often used in academic writing, to cover data and details that are useful for contextualising and giving background information to the main material.[^1]

Some general rules on formatting Appendices:
1. They appear at the end of the document, often after references;

2. There are different Appendices depending on the topic, and each starts on a new page;

3. If there are multiple Appendices these are labelled with letters, and usually they are accompanied by a title that clarifies their content;

4. Appendices are also included in the table of contents at the beginning of the main document.

In this tutorial we're going to explore how to follow these formatting rules using `R Markdown`.[^2]  We are going to do so by exploring three different types of Appendices: for creating tables of raw data, for adding extra figures and for listing the code used in the main document. Finally, we are going to explore how to insert the appendix `.Rmd` document produced to a hypothetical main document.

To get started, download this <a href="https://github.com/AnnaChirumbolo/tutorial_repo" target="____blank">repository</a>

<a name="section2"></a>

## 2. Create the appendix sections using LaTex syntax.

<a name="subsect1"></a>

### a) Why LaTex and not another markup language?

`LaTex` is a "high quality typesetting system" used to produce technical and scientific documentation. It is based on the idea that "it's better to leave document design to document designers, and to let authors get on with writing documents".[^3]

This syntax structure is less appealing than other markup languages (i.e. Markdown, html). Markdown is indeed a better option to focus on contents and format a document easily. That is because markdown has been created with the purpose of being a very *lightweight* markup language, therefore providing a simple code to write in simple format.
LaTex has a longer learning curve and it is not as handy to use, however it is a much more powerful tool that allows high customisation and high control of your documents, for inserting multiple sections, cross-referencing, adding tables, figures and drawing (diagrams, statistical graphs, chemical formulas, etc.).

<a name="subsect2"></a>

### b) Write headings and titles

First thing in the agenda - open `Rstudio`! Once you've done that open the tutorial folder that you have downloaded by clicking on 'Project:(none)' on the upper right and selecting Open Project > Coding-Club-Markdown-pt.II. This will set the working directory to the tutorial folder.

Create a new `R Markdown` file. Give it an informative title, such as 'Appendices document in Markdown', and change the 'Default Output Format' to PDF. You can read in brackets that the pdf requires <a href="https://miktex.org/howto/install-miktex" target="____blank">MikTex</a> for Windows,  <a href="http://www.tug.org/mactex/" target="____blank">MacTex </a> for Mac or <a href="https://www.tug.org/texlive/" target="____blank">Tex Live</a> for Linux.

Have a look at the new file. It presents already some information in the **YAML header** (title and output type) and it also give some basic information on **Markdown syntax** and how to **include plots**.

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/59757148-67bc1680-928b-11e9-94b0-bcc6a1341d99.png"/></div>

If you're interested give it a read, but delete everything afterwards **except the YAML header**, as we're not going to use that information for the tutorial.

If it has not been written already, make sure you add your name as author and date within the YAML header, by adding 'Author:' and 'Date:' on separate lines.
You can specify as many functions within the <a href="https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf" target="____blank">YAML header</a> as you find necessary, but we're just going to leave it basic for this tutorial.

Now that the file is blank, let's start writing the different headings for each appendix we're going to create. Following the rules of formatting, each appendix heading should be labelled with a letter (in order of appearance in the main document), centred and in bold font, and have a title accompanying it to clarify the appendix content.

To write the headings in <a href="https://www.latex-project.org/about/" target="____blank">`LaTex`</a> language, copy this after the YAML header.[^3]

```
\begin{center}
\textbf{\LARGE Appendix A}

\textit{This appendix includes tables of sample data sets.}
\end{center}

--------

\begin{center}
\textbf{\LARGE Appendix B}

\textit{This appendix includes additional figures.}
\end{center}


--------


\begin{center}
\textbf{\LARGE Appendix C}

\textit{This appendix includes the code used.}
\end{center}
```

- The first and last lines define the beginning and end of the text area, the `{center}` centres the text on the page.

- `\textbf{\Large write your text here}` is used to, respectively, make the text bold and in a larger font.

- `\texttit{write your title here}` defines the title to place underneath the heading. A space is intentionally placed between heading and title, otherwise they would be too close to one another.

*Note: the writing is in American English. It won't work if you write in British English (i.e. "centre").*

The knitted pdf document should look like this:
<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/59757281-bb2e6480-928b-11e9-869c-81e786eda12c.png"/></div>


> **_NOTE:
  The choice of syntax depends on the output - practical example_**
>
>Markdown <a href="https://stackoverflow.com/questions/14051715/markdown-native-text-alignment" target="____blank"> **doesn't support text alignment** </a> and would require either <a href="https://www.w3schools.com/html/default.asp" target="____blank">*html*</a> or <a href="https://www.w3schools.com/css/default.asp" target="____blank">*CSS*</a> support. However, in our case and with our formatting aims, none of these languages are applicable when the desired output is a pdf document. **Only LaTex provides the desired format.**
>You can try format the same headings as before, this time using *html*.
**Copy** the following **after** the text you've already written (in LaTex), so we can compare the two in two outputs: pdf and HTML.

```
<div style="text-align:center">
  <span style="color:black; font-family:Calbiri; font-size:2em;">Appendix A.</span>

  <span style="color:black; font-family:Calbiri; font-size:1em;"><i>This appendix includes tables of sample data sets.</i></span>
</div>

<div style="text-align:center">
  <span style="color:black; font-family:Calbiri; font-size:2em;">Appendix B.</span>

  <span style="color:black; font-family:Calbiri; font-size:1em;"><i>This appendix includes additional figures.</i></span>
</div>

<div style="text-align:center">
  <span style="color:black; font-family:Calbiri; font-size:2em;">Appendix C.</span>

  <span style="color:black; font-family:Calbiri; font-size:1em;"><i>This appendix includes the code used.</i></span>
</div>
```

>- The tags `<div>` define the text area, while `<span>` define the text characteristics;
>
>- Here it is necessary to specify the `font family` to achieve the same font as with LaTex (default Calibri);
>
>- The bigger text size for the heading is determined by the option `font-size:2em`;
>
>- Italics is specified with `<i>`.
>
>To notice the difference first knit the file as pdf, then do the same by knitting to HTML.
Leave both outputs side by side: as you can see, the result is practically identical. There is the document title at the top followed by the heading and title, which are correctly centred and presenting the chosen font characteristics.
However, if you look at the pdf, there are duplicates of the headings that are not properly formatted. That is the input written in html syntax that the pdf cannot read.
>
>On the other hand, if you look at the HTML it's the LaTex syntax that disappears. In fact, if you temporarily delete the text written in LaTex and re-knit the HTML file, you'll notice that the output hasn't changed.

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/59757458-1a8c7480-928c-11e9-92a3-d91a81ece875.png"/></div>

>To summarise on this point, the syntax changes *depending on the desired output format*. So bare this in mind when you want to write your document!
>
>You can delete the html text in order to move forward with the tutorial.

<a name="subsect3"></a>

### b) Place the appendices in distinct pages

At this stage the headings are just listed one after the other and only separated by continuous lines (see the pdf output). To actually separate them into distinct pages write (in *LaTex*)

```
\newpage
```
instead of the dashed lines between the headings. If you knit again, you're going to see that each heading successfully starts on a different page (and each page is already numbered!).

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/59757783-ca61e200-928c-11e9-8ff7-0a0d9d16345e.png"/></div>

Once this has been set up, you can start creating the different types of appendices.

<a name="section3"></a>

## 3. Appendix A: Tables of raw data.

One type of appendix could contain tables of the raw data collected, so that readers and reviewers have a better insight on the results that are summarised or only visually represented in the main body of text.

In this case we are going to create a table of a sample data set in Appendix A.

Insert a code chunk after the first heading and title, but before the `\newpage`, to install `knitr` and `kableExtra` packages.

~~~~
```{r include = F}
library(knitr)  # for dynamic report generation
library(kableExtra) # to build complex HTML or 'LaTex' tables
library(tidyverse) # for data manipulation
```
~~~~

*Note: `include=F` in the `{}` makes sure that neither code chunk nor output are shown in the pdf output.*

Also the `tidyverse` package has to be loaded or installed (`install.packages()`) to do some data transformation. If you have never used the `tidyverse` package before don't worry - it is not part of the learning objectives for this tutorial. For now, just copy the code. If you want to learn about the Tidyverse, do this <a href="https://ourcodingclub.github.io/2017/03/20/seecc.html" target="____blank">Coding Club tutorial</a>.

The data set you are going to use is called 'puffins_temp.csv' - it contains information on population trends of Atlantic puffins (*Fratercula arctica*) surveyed in Norway, together with the average of maximum and minimum temperatures (°C) over the years 1979-2008.

Add this piece of code to the previous chunk and run it.

```
puffins_t <- read.csv("./data/puffins_temp.csv") # to open the file puffins_temp.csv
```

If you have a look at the data set, the column names are not very nice to put in a table. We use the function `rename()` to change them. This is where `Tidyverse` becomes extremely useful! Again, add this piece of code at the end of the same chunk and run it.

```
puffins_t <- puffins_t %>%
  rename("Year" = year, "Country list" = Country.list, "Population trend" = pop_trend, "ID" = id, "Mean max. T (°C)" = mean_tmax, "Mean min. T (°C)" = mean_tmin)  # A bit of data transformation! "New name" = Old.name
```

Now the headings have much clearer and neater names. The data set is almost presentable and ready to be inserted in a table. There are still other details, like number of decimals to be fixed, that `knitr::kable()` function helps fixing.

`kableExtra` is an additional package that uses `kable()` and *pipes* from the `Tidyverse` package to build very complex and professional tables. We can explore some of these combined packages to produce a table for a sample of the data set that we have just loaded.

Copy the following code chunk and run it. Make sure the two chunks are spaced between each other.

~~~~
```{r echo=F}
puffins_t %>%
  slice(1:10) %>%   # the table is going to show only the first 10 lines (a sample of the data set)
  kable(digits = 2) %>% # each value has 2 decimal digits
  kable_styling(full_width = F, # the width of the table is not fit to the width of the page
                position = "center", font_size = 10)  # table settings with the kableExtra package
```				
~~~~

You can notice that the table has now appeared after the chunk and in the 'Viewer' tab on the bottom-right panel.

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/59758018-478d5700-928d-11e9-9dbd-e45e1b65b9d5.png"/></div>

This is what it looks like when you knit the `.md` into `pdf` document:

<center><img src="{{ site.baseurl }}/prep/screenshots/table1.png" alt="Img"></center>


The table right now is looking quite basic. With `kableExtra` it is possible to customise the tables way further:

Let's highlight the third column 'Population Trend' and colour it in red, perhaps because we want the reader to focus on those values. Let's also highlight the set of columns with temperature values and colour them in green.

~~~~
```{r echo=F}
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(full_width = F,
                position = "center", font_size = 10) %>%
  column_spec(3, color = "red", bold = T)  %>% # one column
  column_spec(5:6, color = "green", bold = T) # set of columns
```
~~~~

<center><img src="{{ site.baseurl }}/prep/screenshots/table2.png" alt="Img"></center>


It is also possible to specify the features of rows with `row_spec()`. Let's make the headings bold and increase their font size.

~~~~
```{r echo=F}
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(full_width = F,
                position = "center", font_size = 10) %>%
  row_spec(0, bold = T, font_size= 12) # row '0' is the headings
```
~~~~

<center><img src="{{ site.baseurl }}/prep/screenshots/table3.png" alt="Img"></center>


As a last example, let's subgroup the table by applying a common heading to the columns that concern puffins and one for the columns that concern temperature. Let's also subgroup the rows by centuries in which the data have been collected: 1970s and 1980s. The new table will likely appear in a new page.

~~~~
```{r echo=F}
puffins_t %>%
  slice(1:10) %>%
  kable(digits = 2) %>%
  kable_styling(full_width = F,
                position = "center", font_size = 10) %>%
  add_header_above(c(" ", "EU puffins" = 3, "Mean Temperatue (°C)" = 2), bold=T) %>% # this adds one header the columns 2-3-4,  
                                                                                      # and one for the columns 5-6.
  kableExtra::group_rows("1970s", 1,2) %>% # the first two rows are grouped as 1970s
  kableExtra::group_rows("1980s", 3,10) # the remaining rows are grouped as 1980s
      # better specify the package kableExtra before group_rows(), otherwise dyplr might have masked it (there is a function under dyplr with the same name)
```
~~~~

<center><img src="{{ site.baseurl }}/prep/screenshots/table4.png" alt="Img"></center>

**NOTE: The the tables that you can see in R are the in an HTML output. The tables in the pdf have a different appearance. Keep this in mind when you set the table features and knit the `R Markdown` every now and then to check on the actual result.**

`kableExtra` has a really high variety of features for creating tables and it is often combined with another package called `viridisLite` for using smoother <a href="https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html" target="____blank">colour scales</a>. If you are interested in finding out more about the resources of the package, have a look at its <a href="https://cran.r-project.org/web/packages/kableExtra/kableExtra.pdf" target="____blank">manual</a>.[^4]

Let's look at another type of appendix.

<a name="section4"></a>

## 4. Appendix B: additional figures.

A second appendix that is often used contains additional figures to support the main document. I have prepared a mock example of a main document called 'mock_dissertation.Rmd' that you can find in the folder. The document contains all the typical sections of a dissertation/thesis. If you open it you can see what figures there are. The figures show, respectively, trends in puffin populations with high (top-left) and low (top-right) average temperature (°C) values, and a correlation mat (bottom).

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/49405869-c84e9080-f74b-11e8-8129-5edbb3c221e5.png" /></div>

<sub> You can also find these figures saved in the <a href="https://github.com/AnnaChirumbolo/tutorial_repo/tree/master/main_fig" target="____blank">'main_fig' folder</a>.</sub>

Let's imagine we want to add more explanatory figures in the appendix, for example to show the overall climate trend and averages of maximum and minimum temperature changes (°C). We have data from the 1930s until 2018, so we need to do some data transformation that allows us to show the data during the same time period as the graphs in the main document (1979-2008).

Move under the second heading ('Appendix B') and paste the following code chunk to install `ggplot2` package.

~~~~
```{r include=F}
library(ggplot2) # to make beautiful graphs
```
~~~~

The next code transforms the data and creates the graph of climate trends from 1979 until 2008.

<sub> *WAIT to run the graphs to visualise the results. You'll figure out why, just read on. ;)* </sub>

~~~~
```{r echo= F}
climate_data <- read.csv("./data/Lerwick_temp_data.csv") # opens raw data set 'Lerwick_temp_data.csv'

# filter climate data only during years 1979-2008 with filter()
climate_data <- climate_data %>%
  filter(year >= 1979 & year <= 2008)

# plot the climate data
climate_plot <- ggplot(climate_data) +
  ggtitle("Temperature change (1930-2018)") +   # main title  
  theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"), # theme() to make the plot more visually appealing
        panel.background = element_rect(fill = "white"),
        panel.grid.minor = element_line(colour = "grey", size = 0.1 ),
        panel.border = element_rect(colour = "grey", fill = NA),
        axis.text = element_text(size=15),
        axis.title = element_text(size = 20),
        legend.text = element_text(size=15),
        legend.title = element_blank()) +  
  ylab("Temperature (°C)") + xlab(" ") + # y and x-axes titles
  geom_line(aes(x = year, y = tmin, colour = "tmin")) +  # adding line and point for temp 'min' values
  geom_point(aes(x = year, y = tmin, colour = "tmin")) +
  geom_line(aes(x = year, y = tmax, colour = "tmax")) +  # adding line and point for temp 'max' values
  geom_point(aes(x = year, y = tmax, colour = "tmax")) +
  scale_color_discrete(name = "Temp.", labels = c ("Tmax", "Tmin")) # changing colour lines depending on temperature values (min/max)
```
~~~~

This code produces the mean max and min temperatures during that same period.

~~~~
```{r echo=F}
mean_t_data <- climate_data %>%
  group_by(year) %>%  
  summarise(mean_tmax = mean(tmax),  
            mean_tmin = mean(tmin)) # there is no need to filter the years again because this code runs on the last changes made in the previous code (where the years have already been filtered).

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

<sub>*Reminder: the chunk option `echo=F` allows to show the result, but not the code that generates it, in the final pdf output.*</sub>

By running these code chunks you won't see any outputs. That is because the graphs have been saved as objects 'climate_plot' and 'meant_plot', but neither has been called yet. You can call them in a separate chunk, to explore the chunk options for image settings.

Paste the following code chunk:

~~~~
```{r echo=F, out.width='.50\\linewidth', fig.width=10, fig.height=8, fig.show='hold', fig.cap="The figures are created directly in this .Rmd file."}
climate_plot  # calls the object graph for climate trend
meant_plot    # calls the object graph for the mean temperatures
```
~~~~

- <sub>`out.width` lets you decide the width of the plot that shows in the output file. This means you can scale the plot at a different size from the original one (which you set up with `fig.width` and `fig.height`). In this case I have written it in `LaTex`, as you can see from the `\\` after the value. However there is also the option to write in `HTML`, in which the value is written as percentage (i.e. '50%');</sub>

- <sub>`fig.width` and `fig.height` define width and height of the plot, and their value needs to be numeric;</sub>

- <sub>`fig.show` is used to arrange the plot location. There are four possible values (all characters), and in this case 'hold' has been chosen because it places the plot at the very end of a code chunk.</sub>


This is the result in the pdf output. If you knit the document you can check it out:
<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/49430352-b3511c00-f7a2-11e8-8e05-f74b9fbb7607.png" /></div>

*Do you notice anything odd?* The figures in the pdf are **not** in the right order! This happens if the order is not specified in `R Markdown`. You can use the function `hook()` from the `knitr` package that can solve this issue. To make sure it applies to the plots throughout the document, go back to the top of the file and paste the following chunk underneath the YAML header:

~~~~
```{r include = F}
knitr::knit_hooks$set(plot = function(x, options)  {
  hook_plot_tex(x, options)   # the function hook() is used to hold a certain object in place (plots in this case!)
})
```
~~~~
<sub> Credits to <a href="https://stackoverflow.com/questions/16626462/figure-position-in-markdown-when-converting-to-pdf-with-knitr-and-pandoc" target="____blank">Martin Schmelzer</a>.</sub>

This function allows to set a new option in the code chunks with the figures: `fig.pos="H"`. This does the trick in holding the figure in the right order. Let's go back to the chunks in Appendix B and add `fig.pos="H"`in each. Knit again: you'll see the order has been fixed.

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/59758532-68a27780-928e-11e9-8285-ab43ad9bf19e.png" /></div>

Code chunks can be used also to insert external figures, that had been saved from another file.
In this case it is harder to manipulate  their dimensions - the font of the labels cannot be easily changed and there is the risk that the plot text becomes illegible. You can attempt changing the figure size as in the previous chunk, and see what happens.

~~~~
```{r, echo = TRUE, out.width='.50\\linewidth', fig.width=10, fig.height=8, fig.show='hold', fig.align='center', fig.cap="This is an attempt to set the size of externally located figures. The settings don't work as well as in the example above. The labels are very small and illegible."}
img_appendix<-list.files("appendix_fig/", pattern = ".png", full.names = TRUE)  # opens the files within the folder called 'appendix_fig'
include_graphics(img_appendix) # views the graphs within that folder
```
~~~~

If you knit the document, you can see that the figures become really small and the text is barely legible. Even changing the width and height of the figures doesn't make a difference in this case.

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/49431100-987fa700-f7a4-11e8-8a9d-23a6ee9e0e3e.png" /></div>

Change the values of `fig.height` and `fig.width` and knit the `.Rmd` file to test the changes and see if the labels become more or less legible.

When images are loaded from an external source it is advised not to align them, but to have them bigger and following one another.

~~~~
```{r, echo = TRUE, out.height="40%", fig.show='hold', fig.align="center",  fig.cap="Additional images in Appendix B"}
img_appendix<-list.files("appendix_fig/", pattern = ".png", full.names = TRUE)
include_graphics(img_appendix)
```
~~~~

- <sub>`fig.align` defines the alignment of figures in the output;</sub>

- <sub>`fig.cap` adds the figure caption at the bottom;</sub>

- <sub>The `list.files()` function lists the files present in a specified path. Here I chose the 'appendix_fig' folder, where all the figures to insert in the appendix had been saved;</sub>

- <sub>`The 'include_graphics()` function is part of the 'knitr' package, and it allows to embed external images in document format supported by 'knitr'.</sub>


This is the result:

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/49431134-a33a3c00-f7a4-11e8-9bd4-f0b29f090c40.png" /></div>

The figures do occupy an entire page, but at least their labels are visible.

These are a few examples of code chunks options to change settings of figures. You can check this <a href="https://yihui.name/knitr/options/" target="____blank">blog post</a> by **Yihui Xie** to find more about the *chunk options* available.

Let's move on to the third and last appendix type in this tutorial.

<a name="section5"></a>

## 5. Appendix C: code.

As a third example, let's imagine that we want to use *Appendix C* to include all the code used in the main document to present results (summarised data, tables and figures). In the main text it is unlikely to see the code that produces a certain output, unless that document is about coding itself...
Making the code used available in an appendix favours the **transparency and replicability of the work done.**

There is a very simple, single line of code to insert within the chunk `{}`, that reads all the code used from a specified document, joins it and inserts it within the same chunk. This operation can be done assuming that the text itself was created from an `R Markdown` document and therefore contains code.

<sub>This idea is credited to <a href="https://twitter.com/alexpghayes/status/1039170310560464897" target="____blank">Alex Hayes</a>:</sub>

Insert the following code chunk at the bottom of the markdown file, after the last `\end{center}`.
~~~~
```{r code=readLines(knitr::purl('./mock_dissertation.Rmd', documentation = 0)), eval = F}
```
~~~~

The function `purl()` takes the source code from the main document (specified by the file path `'./file.Rmd'`) and lists it within a single chunk that is not run (`eval=F`).

A long list of code lines should appear within the code chunk and it corresponds to the code used in the mock_dissertation.Rmd to carry out any data transformation and visualisation.

<div style="text-align:center"><img src ="https://user-images.githubusercontent.com/43357858/49407266-d8686f00-f74f-11e8-9bdd-b07ab96e19d3.png" /></div>

If you want to check that the code is actually the same as the one that produces the 'mock_dissertation.pdf', open the 'mock_dissertation.Rmd' file and compare the list of code you obtained with the content of the code chunks in the latter.


__*Great job getting so far!*__
If you want to check that you have correctly completed this tutorial, have a look at the completed appendix.pdf file that you can find HERE(LINK).
<a href="https://cran.r-project.org/web/packages/kableExtra/kableExtra.pdf" target="____blank">manual</a>.TO FIX

...There is one last trick to show you.


<a name="section6"></a>

## 6. Insert the Appendix in the main text.

Now that the appendix document is complete, it is time to add it to the main document!

The 'mock_dissertation.pdf' document in the repository is only missing the appendix.

To add the content from the 'appendix.Rmd' into 'mock_dissertation.Rmd', go to the 'Appendix' section at the end of the main one and insert the following code chunk:
~~~~
```{r child='appendix.Rmd'}
```
~~~~

The `child` chunk option refers to *smaller* documents to be run and input into the main one.

If you knit the 'mock_dissertation.Rmd' file now, you can see the content from the appendix document at the end.

<hr>

<p align="center">
  <img src="https://user-images.githubusercontent.com/43357858/49432014-a33b3b80-f7a6-11e8-813b-4219c8f2138c.gif">
</p>

**HOORAY!**

*You have successfully completed this tutorial!*

<a name="section7"></a>

## 7. Try it yourself!

In the repository, there is a folder called ['extra'](https://github.com/AnnaChirumbolo/tutorial_repo/tree/master/extra) for you to practice with! In there you can find a series of data sets in .csv with which you can explore more of the functions from the `knitr` and `kableExtra` package to make very professional tables. There is also a figure 'abundance_puffins.png' that you can use to play around by changing [code chunk options](https://yihui.name/knitr/options/).


<hr>

Useful links:

[^1]: To find more about Appendices and formatting guidelines check <a href="http://libguides.usc.edu/writingguide/appendices" target="____blank">*Organising Your Social Sciences Research Paper: Appendices*</a>.

[^2]: If you are interested in R Markdown in general, follow this <a href="https://bookdown.org/yihui/rmarkdown/" target="____blank">link</a> to *R Markdown: The Definitive Guide*.

[^3]: If you would like to learn more about `LaTex` syntax and how to apply it for building up your thesis, check this series of <a href="https://rosannavanhespenresearch.wordpress.com/2016/02/03/writing-your-thesis-with-r-markdown-1-getting-started/" target="____blank">blog posts</a> by **Rosanna van Hespen**. The GitHub Repository for these posts can be found <a href="https://github.com/rosannav/thesis_in_rmarkdown/tree/master/example_thesis" target="____blank">here</a>. At <a href="https://www.latex-project.org" target="____blank">LaTex project</a> website you can find more about syntax and documentation.

[^4]: This <a href="https://cran.r-project.org/web/packages/viridisLite/viridisLite.pdf" target="____blank">link</a> will send you to the *viridisLite* package handbook and this <a href="https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html" target="____blank">tutorial</a> explores more about its applications with `kableExtra`.

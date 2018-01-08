ReporteRs R package
================


## Overview

`ReporteRs` is an R package for creating Microsoft Word and Powerpoint
documents. It does not require any Microsoft component to be used. It
runs on Windows, Linux, Unix and Mac OS systems. It is designed to
automate reporting generation from R.

### Important note

**ReporteRs will be maintained but will not evolve anymore. It has been
rewritten with no java dependency**:

  - The new package is
    [`officer`](https://cran.r-project.org/package=officer).
  - FlexTable objects are now implemented in package
    [`flextable`](https://CRAN.R-project.org/package=flextable).
  - Vector graphics are now implemented in package
    [`rvg`](https://CRAN.R-project.org/package=rvg)
  - Native Microsoft charts can be produced with package
    [`mschart`](https://github.com/ardata-fr/mschart)

## Introduction

You can use the package as a tool for fast reporting and as a tool for
reporting automation.

There are several features to let you format and present R outputs, for
example:

  - **Editable Vector Graphics**: let your readers modify and annotate
    plots.
  - **Tables**: `FlexTable` objects let you format any complex table.
  - **Text output**: format texts and paragraphs.
  - Reuse of corporate **template document** (*.docx and *.pptx).

### Produce a document in few lines of codes

There are default templates and default values, it enables easy
generation of R outputs in few lines of codes.

Below a short R script:

``` r
require( ggplot2 )
doc = docx( title = 'My document' )

doc = addTitle( doc , 'First 5 lines of iris', level = 1)
doc = addFlexTable( doc , vanilla.table(iris[1:5, ]) )

doc = addTitle( doc , 'ggplot2 example', level = 1)
myggplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width )
doc = addPlot( doc = doc , fun = print, x = myggplot )

doc = addTitle( doc , 'Text example', level = 1)
doc = addParagraph( doc, 'My tailor is rich.', stylename = 'Normal' )

writeDoc( doc, "demo.docx" )
```

### Reporting automation

It lets you also create corporate documents, creation of complex tables,
pretty graphical rendering with a set of R functions.

To automate document generation only R code is necessary.

With Word and PowerPoint document, you can add contents from R but also
replace contents. By default, content is added at the end of the
specified template document. When generating Word document, bookmarks
can be used to define locations of replacements in the document. When
generating PowerPoint document, slide indexes can be used to define
locations of slides to replace in the presentation.

## Installation

ReporteRs needs `rJava` with a java version \>= 1.6 ; make sure you have
an installed JRE.

`system("java -version")` should return *java version ‘1.6.0’* or
greater.

Test your `rJava` installation with the following code, you should get
your java version in a string:

``` r
require(rJava)
.jinit()
#> [1] 0
.jcall('java.lang.System','S','getProperty','java.version')
#> [1] "1.8.0_31"
```

### Get CRAN version

``` r
install.packages('ReporteRs')
```

### From Github

``` r
devtools::install_github('davidgohel/ReporteRsjars')
devtools::install_github('davidgohel/ReporteRs')
```

## Ressources

### Online documentation

The help pages are located at <https://davidgohel.github.io/ReporteRs/>.

### Getting help

This project is developped and maintained on my own time. In order to
help me to maintain the package, do not send me private emails if you
only have questions about how to use the package. Instead, visit
Stackoverflow, `ReporteRs` has its own tag [Stackoverflow
link](https://stackoverflow.com/questions/tagged/reporters)\! I usually
read them and answer when possible.

### Bug reports

When you file a [bug
report](https://github.com/davidgohel/ReporteRs/issues), please spend
some time making it easy for me to follow and reproduce. The more time
you spend on making the bug report coherent, the more time I can
dedicate to investigate the bug as opposed to the bug report.

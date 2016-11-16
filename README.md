ReporteRs R package
================

-   [ReporteRs](#reporters)
    -   [Introduction](#introduction)
    -   [Main functions list](#main-functions-list)
    -   [Installation](#installation)
    -   [Usefull links:](#usefull-links)
    -   [License](#license)

[![Travis-CI Build Status](https://travis-ci.org/davidgohel/ReporteRs.svg?branch=master)](https://travis-ci.org/davidgohel/ReporteRs) [![CRAN version](http://www.r-pkg.org/badges/version/ReporteRs)](http://cran.rstudio.com/web/packages/ReporteRs/index.html) ![cranlogs](http://cranlogs.r-pkg.org./badges/ReporteRs) ![active](http://www.repostatus.org/badges/latest/active.svg)

ReporteRs
=========

`ReporteRs` is an R package for creating Microsoft Word and Powerpoint documents. It does not require any Microsoft component to be used. It runs on Windows, Linux, Unix and Mac OS systems. It is designed to automate reporting generation from R.

Introduction
------------

You can use the package as a tool for fast reporting and as a tool for reporting automation.

There are several features to let you format and present R outputs, for example:

-   **Editable Vector Graphics**: let your readers modify and annotate plots.
-   **Tables**: `FlexTable` objects let you format any complex table.
-   **Text output**: format texts and paragraphs.
-   Reuse of corporate **template document** (*.docx and *.pptx).

### Produce a document in few lines of codes

There are default templates and default values, it enables easy generation of R outputs in few lines of codes.

Below a short R script:

``` r
require( ggplot2 )
#> Warning: package 'ggplot2' was built under R version 3.3.2
doc = docx( title = 'My document' )

doc = addTitle( doc , 'First 5 lines of iris', level = 1)
doc = addFlexTable( doc , vanilla.table(iris[1:5, ]) )

doc = addTitle( doc , 'ggplot2 example', level = 1)
myggplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width )
doc = addPlot( doc = doc , fun = print, x = myggplot )

doc = addTitle( doc , 'Text example', level = 1)
doc = addParagraph( doc, 'My tailor is rich.', stylename = 'Normal' )

filename <- tempfile(fileext = ".docx") # the document to produce
writeDoc( doc, filename )
```

### Reporting automation

It lets you also create corporate documents, creation of complex tables, pretty graphical rendering with a set of R functions.

To automate document generation only R code is necessary.

With Word and PowerPoint document, you can add contents from R but also replace contents. By default, content is added at the end of the specified template document. When generating Word document, bookmarks can be used to define locations of replacements in the document. When generating PowerPoint document, slide indexes can be used to define locations of slides to replace in the presentation.

Main functions list
-------------------

The following functions can be used whatever the output format is (docx, pptx):

-   addTitle: Add a title
-   addFlexTable: Add a FlexTable
-   addPlot: Add plots
-   addImage: Add external images
-   addRScript: Add syntax highlighted R code
-   addParagraph: Add paragraphs of text
-   writeDoc: Write the document into a file
-   dim: Get shape/page dimensions

The following functions can only be used when the output format is `docx`.

-   styles: Get available styles
-   addTOC: Add a table of contents
-   addPageBreak: Add a page break
-   addSection: Add a new section (landscape or portrait orientation and split content within columns)

The following functions can only be used when the output format is `pptx`.

-   slide.layouts: Get available layout names
-   addSlide: Add a slide
-   addDate: Add a date
-   addPageNumber: Add a page number
-   addFooter: Add a comment in the footer
-   addSubtitle: Add a sub title

Installation
------------

ReporteRs needs `rJava` with a java version &gt;= 1.6 ; make sure you have an installed JRE.

`system("java -version")` should return *java version '1.6.0'* or greater.

Test your `rJava` installation with the following code, you should get your java version in a string:

``` r
require(rJava)
.jcall('java.lang.System','S','getProperty','java.version')
#> [1] "1.6.0_65"
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

Usefull links:
--------------

-   Help pages: [**Documentation**](http://davidgohel.github.io/ReporteRs/index.html)
-   if you have questions, use the mailing list: [**Mailing list**](http://groups.google.com/forum/#!forum/reporters-package "if you have questions, use the mailing list")
-   Report a bug: [**Bug report**](http://github.com/davidgohel/ReporteRs/issues "please provide a reproducible example"). If you report a bug, try to send a reproducible example and don't forget to send the result of `sessionInfo()`.

License
-------

``` r
library(ReporteRs)
example(docx) #run a complete and detailed docx example
example(pptx) #run a complete and detailed pptx example
```

The ReporteRs package is licensed under the GPLv3.

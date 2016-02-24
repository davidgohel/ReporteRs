[![Travis-CI Build Status](https://travis-ci.org/davidgohel/ReporteRs.svg?branch=master)](https://travis-ci.org/davidgohel/ReporteRs)
[![CRAN version](http://www.r-pkg.org/badges/version/ReporteRs)](http://cran.rstudio.com/web/packages/ReporteRs/index.html)

ReporteRs
======
ReporteRs is an R package for creating Microsoft Word, Microsoft Powerpoint and HTML documents from R.

Usefull links: 

* Help pages: [**Documentation**](http://davidgohel.github.io/ReporteRs/index.html) 
* if you have questions, use the mailing list: [**Mailing list**](http://groups.google.com/forum/#!forum/reporters-package "if you have questions, use the mailing list")  
* Report a bug: [**Bug report**](http://github.com/davidgohel/ReporteRs/issues "please provide a reproducible example"). If you report a bug, try to send a reproducible example 
    and don't forget to send the result of `sessionInfo()`.
        
Features
--------
* Create docx, pptx or html files with only a few lines of R code.
* Add tables, plots, text or tables of contents into Word, PowerPoint and html documents.
* Customize formatting of R outputs.
* Design and format any complex table.

Installation
------------

### Dependencies

Java (it has been tested with java version >= 1.6).

### CRAN

    install.packages("ReporteRs")

### Github

**Get the latest release:**  

    if( !require( devtools ) ) install.packages("devtools")
    devtools::install_github('davidgohel/ReporteRsjars')
    devtools::install_github('davidgohel/ReporteRs')


Getting Started
---------------

    library(ReporteRs)
    
    example(docx) #run a complete and detailed docx example
    example(pptx) #run a complete and detailed pptx example
    example(bsdoc) #run a complete and detailed html example
    
License
-------
The ReporteRs package is licensed under the GPLv3. See ``COPYRIGHTS`` file in the ``inst`` directory for additional details.

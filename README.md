ReporteRs
======
ReporteRs is an R package for creating Microsoft Word, Microsoft Powerpoint and HTML documents from R.

Usefull links: 

* Help pages: [**Documentation**](http://davidgohel.github.io/ReporteRs/index.html) 
* if you have questions, use the mailing list: [**Mailing list**](http://groups.google.com/forum/#!forum/reporters-package "if you have questions, use the mailing list")  
* Report a bug: [**Bug report**](http://github.com/davidgohel/ReporteRs/issues "please provide a reproducible example"). If you report a bug, try to send a reproducible example 
    and don't forget to send the result of 
    
        sessionInfo()
        
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

ReporteRs needs some R packages ; run the following script to install them if needed.

    if( !require( rJava ) ) install.packages("rJava")
    if( !require( ggplot2 ) ) install.packages("ggplot2")

### CRAN

    install.packages("ReporteRs")

### Github

**Get the latest release:**  

    if( !require( devtools ) ) install.packages("devtools")
    devtools::install_github('davidgohel/ReporteRsjars')
    devtools::install_github('davidgohel/ReporteRs')

**Get the latest Windows binary packages:**  
[ReporteRsjars 0.2](https://github.com/davidgohel/ReporteRsjars/releases/tag/v0.2 "ReporteRsjars") &diams; 
[ReporteRs 0.7.4](https://github.com/davidgohel/ReporteRs/releases/tag/v0.7.5 "ReporteRs")

  
Getting Started
---------------

    library(ReporteRs)
    
    example(docx) #run a complete and detailed docx example
    example(pptx) #run a complete and detailed pptx example
    example(bsdoc) #run a complete and detailed html example
    
    ?ReporteRs
    ?addFlexTable
    ?addPlot
    ?addMarkdown
    ?addParagraph
    ?docx
    ?pptx
    ?bsdoc
  
License
-------
The ReporteRs package is licensed under the GPLv3. See ``COPYRIGHTS`` file in the ``inst`` directory for additional details.

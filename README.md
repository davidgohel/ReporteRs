ReporteRs
======
ReporteRs is a R package for creating Microsoft Word, Microsoft Powerpoint and HTML documents from R.

Documentation can be found here:
http://davidgohel.github.io/ReporteRs/index.html

Features
--------
* Create docx, pptx or html files with only a few lines of R code.
* Add tables, plots, text or tables of contents into Word, PowerPoint and html documents.
* Customize formatting of R outputs.
* Take advantage of the benefits of reproducible research.

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

Get the latest release:

    if( !require( devtools ) ) install.packages("devtools")
    devtools::install_github('ReporteRsjars', 'davidgohel')
    devtools::install_github('ReporteRs', 'davidgohel')

Get the latest binary packages: 
[ReporteRsjars 0.2](https://github.com/davidgohel/ReporteRsjars/releases/tag/v0.2 "ReporteRsjars") and 
[ReporteRs 0.6.0](https://github.com/davidgohel/ReporteRs/releases/tag/v0.6.0 "ReporteRs")

	
Getting Started
---------------

    library(ReporteRs)
    
    example(docx) #run a complete and detailed docx example
    example(pptx) #run a complete and detailed pptx example
    example(html) #run a complete and detailed html example
    
    ?ReporteRs
    ?addFlexTable
    ?addPlot
    ?addParagraph
    ?docx
    ?pptx
    ?html
	
License
-------
The ReporteRs package is licensed under the GPLv3. See COPYRIGHTS file in the inst directory for additional details.

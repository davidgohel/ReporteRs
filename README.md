ReporteRs
======
ReporteRs is a R package for creating Microsoft Word, Microsoft Powerpoint and HTML documents from R.

Documentation can be found [here](http://davidgohel.github.io/ReporteRs/index.html "help files").

Features
--------
* Create docx, pptx or html files with only a few lines of R code.
* Add tables, plots, text or tables of contents into Word, PowerPoint and html documents.
* Customize formatting of R output.
* Take advantage of the benefits of reproducible research.

Installation
------------

### Dependencies

Java (it has been tested with java version >= 1.6).

ReporteRs needs some R packages ; run the following script to install them if needed.


    if( !require( rJava ) ) install.packages("rJava")
    if( !require( ggplot2 ) ) install.packages("ggplot2")
    if( !require( base64 ) ) install.packages("base64")

### CRAN

    install.packages("ReporteRs")

### Github

Get the latest release:

    if( !require( devtools ) ) install.packages("devtools")
    devtools::install_github('ReporteRsjars', 'davidgohel')
    devtools::install_github('ReporteRs', 'davidgohel')

Get the latest binary packages: 
[ReporteRsjars](https://github.com/davidgohel/ReporteRsjars/releases/tag/v0.1 "ReporteRsjars") - [ReporteRs](https://github.com/davidgohel/ReporteRs/releases/tag/v0.5.5 "ReporteRs")

	
Getting Started
---------------

    library(ReporteRs)
    
    example(docx) #run a complete and detailed docx example
    example(pptx) #run a complete and detailed pptx example
    example(html) #run a complete and detailed html example
    
    ?ReporteRs
    ?addTable
    ?FlexTable
    ?addPlot
    ?addParagraph
    ?docx
    ?pptx
    ?html
	
License
-------
The ReporteRs package is licensed under the GPLv3. See COPYRIGHTS file in the inst directory for additional details.

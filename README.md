ReporteRs
======
ReporteRs is a R package for creating MS Word documents, MS PowerPoint documents and HTML documents from R.


Features
--------
* Create docx and pptx files with only a few lines of R code.
* Add tables, plots, text or tables of contents into Word PowerPoint and html documents.
* Customize formatting of R output.
* Take advantage of the benefits of reproducible research.

Installation
------------

**Dependencies**

Java (it has been tested with java version >= 1.6).

ReporteRs needs some R packages ; run the following script to install them if needed.


    if( !require( rJava ) ) install.packages("rJava")
    if( !require( ggplot2 ) ) install.packages("ggplot2")
    if( !require( base64 ) ) install.packages("base64")
    if( !require( highlight ) ) install.packages("highlight")

**From sources**

From an R console (R >= 3.0):

    install.packages("devtools")
    devtools::install_github('ReporteRs', 'davidgohel')

**Binary package**

A binary package is available here:
https://github.com/davidgohel/ReporteRs/releases/tag/v0.2
    
	
Getting Started
---------------

    library(ReporteRs)
    example(docx) #run a complete and detailed docx example
    example(pptx) #run a complete and detailed docx example
	example(html) #run a complete and detailed docx example

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
The ReporteRs package is licensed under the GPLv3.

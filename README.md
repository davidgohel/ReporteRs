ReporteRs
======
ReporteRs is a R package for creating MS Word documents, MS PowerPoint documents and HTML documents from R.


Features
--------
* Create docx, pptx or html files with only a few lines of R code. 
* Add tables, plots, texts, etc.
* Simple R functions are available for customizing formatting properties of R output.

Installation
------------
From an R console (R >= 3.0):

    install.packages("devtools")
    devtools::install_github('ReporteRs', 'davidgohel')

**Dependencies**

    R packages : rJava, ggplot2, base64, highlight
	Java (it has been tested with java version >= 1.6)
	
Getting Started
---------------

    library(ReporteRs)
    example(docx) #run a complete and detailed docx example
    example(pptx) #run a complete and detailed docx example
	example(html) #run a complete and detailed docx example

	?ReporteRs
	?addTable
	?addPlot
	?addParagraph
	?docx
	?pptx
	?html
	
License
-------
The ReporteRs package is licensed under the GPLv3.

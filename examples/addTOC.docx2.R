doc = docx( title = "title" )

#leave the first page blank and add a page break
doc = addPageBreak(doc)

doc = addTitle( doc, "Plots", level = 1 )
doc = addPlot( doc, 
	fun = plot,
	x = rnorm( 100 ),
	y = rnorm (100 ),
	main = "base plot main title"
)
doc = addParagraph( doc, value="graph example 1", stylename = "rPlotLegend" )
if( requireNamespace("ggplot2", quietly = TRUE) ){
	myplot = ggplot2::qplot(Sepal.Length, Petal.Length, data = iris, color = Species
		, size = Petal.Width, alpha = I(0.7))
	doc = addPlot( doc = doc
	, fun = print
	, x = myplot #this argument MUST be named, print is expecting argument 'x'
	)
	doc = addParagraph( doc, value="graph example 2", stylename = "rPlotLegend" )
}

# Because we used "rPlotLegend" as legend in plot
# , addTOC will use this stylename to define
# entries in the generated TOC
doc = addTOC(doc, stylename = "rPlotLegend")

# Write the object in file "addTOC_example2.docx"
writeDoc( doc, "addTOC_example2.docx" )

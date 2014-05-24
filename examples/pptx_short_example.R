library( ReporteRs )

# Here we define powerpoint document filename to write
pptx.file = "presentation.pptx"

# Creation of doc, a pptx object (default template)
doc = pptx( )

# check my layout names:
slide.layouts(doc)

doc = addSlide( doc, "Two Content" )
# add into doc first 10 lines of iris
doc = addTitle( doc, "First 10 lines of iris" )
doc = addTable( doc, iris[1:10,] )

# add text with stylename "Normal" into doc (and an empty line just before)
doc = addParagraph( doc, value = c("", "Hello World!"), stylename = "Normal" )

doc = addSlide( doc, "Title and Content" )
# add a plot into doc 
doc = addPlot( doc
  , function() plot( rnorm(10), rnorm(10) )
)

# write the doc 
writeDoc( doc, pptx.file )

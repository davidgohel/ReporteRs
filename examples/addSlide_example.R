
# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )
#set the main title
doc = addTitle( doc, "Presentation title" ) 
#set the sub-title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")

# add a slide with layout "Title and Content" then add content
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addTitle( doc, "Iris sample dataset", level = 1 )
doc = addFlexTable( doc, vanilla.table( iris[ 1:10,] ) )

# add a slide with layout "Two Content" then add content
doc = addSlide( doc, slide.layout = "Two Content" )
doc = addTitle( doc, "Two Content demo", level = 1 )
doc = addFlexTable( doc, vanilla.table( iris[ 46:55,] ) )
doc = addParagraph(doc, "Hello Word!" )

# to see available layouts :
slide.layouts( doc )

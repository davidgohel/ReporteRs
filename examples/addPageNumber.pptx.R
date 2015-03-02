# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )
doc = addTitle( doc, "Presentation title" ) #set the main title
#set the sub-title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")

## add a page number on the current slide
doc = addPageNumber( doc )

doc = addSlide( doc, slide.layout = "Title and Content" )
## add a page number on the current slide but 
## not the default text (slide number)
doc = addPageNumber( doc, value = "Page number text")

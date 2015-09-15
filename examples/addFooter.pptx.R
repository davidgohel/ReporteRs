# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )
#set the main title
doc = addTitle( doc, "Presentation title" ) 
#set the sub-title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")

## add a page number on the current slide
doc = addFooter( doc, "Hi!" )

doc = addSlide( doc, slide.layout = "Title Slide" )
#set the main title
doc = addTitle( doc, "Presentation title" ) 
#set the sub-title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")

## add a date on the current slide
doc = addDate( doc )


doc = addSlide( doc, slide.layout = "Title and Content" )
## add a page number on the current slide but not 
## the default text (slide number)
doc = addDate( doc, "Dummy date" )

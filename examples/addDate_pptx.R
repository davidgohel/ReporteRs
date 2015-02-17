doc = addSlide( doc, slide.layout = "Title Slide" )
doc = addTitle( doc, "Presentation title" ) #set the main title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title

## add a date on the current slide
doc = addDate( doc )


doc = addSlide( doc, slide.layout = "Title and Content" )
## add a page number on the current slide but not the default text (slide number)
doc = addDate( doc, "Dummy date" )

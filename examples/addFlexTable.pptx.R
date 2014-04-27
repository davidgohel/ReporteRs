doc = pptx( title = "title" )
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addFlexTable( doc, MyFTable )
writeDoc( doc, "addFlexTable_example.pptx")

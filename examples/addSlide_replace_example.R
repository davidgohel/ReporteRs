
# demo slide replacement --------

# define 2 FlexTables
ft1 = vanilla.table( head( mtcars ), add.rownames = TRUE )
ft2 = vanilla.table( head( iris ), add.rownames = TRUE )

# create an doc to be used as template later
mydoc = pptx( )
mydoc = addSlide( mydoc, slide.layout = "Title and Content")
mydoc = addTitle( mydoc, "a table")
mydoc = addFlexTable( mydoc, ft1 )
mydoc = addSlide( mydoc, slide.layout = "Title and Content")
mydoc = addTitle( mydoc, "some text")
mydoc = addParagraph( mydoc, "text example" )
writeDoc( mydoc, "template_example.pptx" )

# use file pp_template_example.pptx as template
# and replace slide 1 
mydoc = pptx(template = "template_example.pptx" )
mydoc = addSlide( mydoc, slide.layout = "Title and Content", bookmark = 1)
mydoc = addTitle( mydoc, "a new table")
mydoc = addFlexTable( mydoc, ft2 )
writeDoc( mydoc, "slide_replacement.pptx" )

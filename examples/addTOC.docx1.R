# Create a new document
doc = docx( title = "title" )
#leave the first page blank and add a page break
doc = addPageBreak(doc)
# add a TOC (to be refresh when document is opened)
# and add a page break
doc = addTOC(doc)
doc = addPageBreak(doc)

# add titles that will be entries in the TOC
doc = addTitle( doc, "My first title", level = 1 )
doc = addTitle( doc, "My second title", level = 1 )

# Write the object in file "addTOC_example1.docx"
writeDoc( doc, "addTOC_example1.docx" )

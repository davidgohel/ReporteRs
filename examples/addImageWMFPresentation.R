if( exists("win.metafile") ){
	win.metafile(filename = "image.wmf", width = 5, height = 5 )
	barplot( 1:6, col = 2:7)
	dev.off()
	
	doc = addSlide( doc, "Title and Content")
	doc =addImage(doc, "image.wmf", width = 5, height = 5 )
	doc = addSlide( doc, "Title and Content")
	doc =addImage(doc, "image.wmf", width = 8, height = 3 )
}

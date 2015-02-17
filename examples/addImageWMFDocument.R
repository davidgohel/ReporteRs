if( exists("win.metafile") ){
	win.metafile(filename = "image.wmf", width = 5, height = 5 )
	barplot( 1:6, col = 2:7)
	dev.off()
	
	doc =addImage(doc, "image.wmf", width = 5, height = 5 )
}

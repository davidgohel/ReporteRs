# files 'logo.jpg' and 'logosm.jpg' only exist in R for Windows
img.file1 = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
img.file2 = file.path( Sys.getenv("R_HOME"), "doc", "html", "logosm.jpg" )

if( file.exists( img.file1 ) && file.exists( img.file2 ) ){
	doc = addTitle( doc, "Add images with defaut PPI (72)", level = 1)
	doc = addTitle( doc, "Image 1", level = 2)
	doc = addImage(doc, img.file1 )
	doc = addTitle( doc, "Image 2", level = 2)
	doc = addImage(doc, img.file2 )
	doc = addTitle( doc, "Add images with their respective PPI", level = 1)
	doc = addTitle( doc, "Image 1", level = 2)
	doc = addImage(doc, img.file1, ppi = 300 )
	doc = addTitle( doc, "Image 2", level = 2)
	doc = addImage(doc, img.file2, ppi = 96)
	doc = addTitle( doc, "Add images with width and height", level = 1)
	doc = addImage(doc, img.file1, width = 4, height = 2 )
}

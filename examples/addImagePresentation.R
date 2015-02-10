# files 'logo.jpg' and 'logosm.jpg' only exist in R for Windows
img.file1 = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
img.file2 = file.path( Sys.getenv("R_HOME"), "doc", "html", "logosm.jpg" )

if( file.exists( img.file1 ) && file.exists( img.file2 ) ){
	
	doc = addSlide( doc, "Two Content")
	doc = addTitle( doc, "Add images with defaut PPI (72)")
	doc = addImage(doc, img.file1 )
	doc = addImage(doc, img.file2 )
	
	doc = addSlide( doc, "Two Content")
	doc = addTitle( doc, "Add images with their respective PPI" )
	doc = addImage(doc, img.file1, ppi = 300 )
	doc = addImage(doc, img.file2, ppi = 96)
	
	doc = addSlide( doc, "Title and Content" )
	doc = addTitle( doc, "Add images with width and height" )
	doc = addImage(doc, img.file1, width = 4, height = 2 )
	
	doc = addSlide( doc, "Title and Content" )
	doc = addTitle( doc, "Add images with width and height and postion" )
	doc = addImage(doc, img.file1, width = 4, height = 2, offx = 2, offy = 2 )
	
	doc = addSlide( doc, "Title and Content" )
	doc = addTitle( doc, "Add images with postion" )
	doc = addImage(doc, img.file1, offx = 2, offy = 2 )
}

if( .Platform$OS.type == "windows" ){
	# set default font size to 10
	options( "ReporteRs-fontsize" = 10 )
	
	doc2embed = docx( )
	img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
	doc2embed = addImage(doc2embed, img.file )
	writeDoc( doc2embed, file = "external_file.docx" )
	
	doc = docx( )
	doc = addDocument( doc, filename = "external_file.docx" )
	writeDoc( doc, file = doc.filename )
}

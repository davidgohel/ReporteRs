#' @method writeDoc bsdoc
#' @S3method writeDoc bsdoc
writeDoc.bsdoc = function(doc, directory, file, ...) {
	www.directory = normalizePath( path.expand(directory) , mustWork=F, winslash="/")
	try( unlink( www.directory, recursive = T ) , silent = TRUE )	
	dir.create( www.directory, recursive = T )
	bootstrap.copy( www.directory, "ReporteRs")	
	out = .jcall( doc$jobj , "I", "writeHtml", file.path( www.directory, file ) )
	if( out != 1 ){
		stop( "Problem while trying to write html content onto the disk." )
	}
	invisible()
}




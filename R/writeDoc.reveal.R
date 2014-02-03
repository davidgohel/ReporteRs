#' @title Write a reveal object in a reveal file
#'
#' @description Write the \code{"reveal"} object in '.reveal' files located in a specified directory.
#' 
#' @param doc Object of class \code{"reveal"} that has to be written.
#' @param directory single character value, name of the directory that will contain generated reveal pages.
#' @param ... further arguments, not used. 
#' @examples
#' # Create a new document 
#' doc = reveal( title = "title" )
#' 
#' # add a page where to add R outputs
#' doc = addSlide( doc  )

#' # add iris dataset as a table in the page
#' doc <- addTable(doc, iris )
#' 
#' # write the reveal object in a directory
#' reveal.directory <- "reveal_doc"
#' reveal.files = writeDoc( doc, directory = reveal.directory )
#' @seealso \code{\link{reveal}}, \code{\link{writeDoc}}
#' @method writeDoc reveal
#' @S3method writeDoc reveal

writeDoc.reveal = function(doc, directory, ...) {
	
	if( !is.character( directory ) ) stop("argument directory must be a valid filename (a string value).")
	if( length( directory ) != 1 ) stop("length of argument directory is not 1.")
	if( !is.character( directory ) ) stop("argument directory must be a string value (a filename).")
	
	
	www.directory = normalizePath( path.expand(directory) , mustWork=F, winslash="/")
	try( unlink( www.directory, recursive = T ) , silent = TRUE )	
	dir.create( www.directory, recursive = T )
	reveal.copy( www.directory, "ReporteRs")	
	file = file.path( www.directory, "index.html")


	out = rJava::.jcall( doc$obj , "I", "writeDocument", file )
	if( out != 1 ){
		stop( "Problem while trying to write reveal content onto the disk." )
	}
	invisible()
}




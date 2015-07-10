#' @title Write a \code{bsdoc} object in a html file
#'
#' @description Write the \code{\link{bsdoc}} object in '.html' files located in a specified directory.
#' 
#' bootstrap files will be copied in the directory if directory does not exist.
#' 
#' @param doc \code{\link{bsdoc}} object that has to be written.
#' @param file single character value, name of the html file to write.
#'  
#' @param ... further arguments, not used. 
#' @return the function a character vector containing generated html documents filenames.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "writeDoc_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{writeDoc}}
#' @export
writeDoc.bsdoc = function(doc, file, ...) {
	if( !is.character( file ) ) stop("argument file must be a valid filename (a string value).")
	if( length( file ) != 1 ) stop("length of argument file is not 1.")
	.reg = regexpr( paste( "(\\.(?i)(html))$", sep = "" ), file )
	if( .reg < 1 )
		stop(file , " is not a valid file.")
	
	file = normalizePath( path.expand(file) , mustWork=F, winslash="/")
	
	www.directory = dirname( file )
	
	if( !file.exists( www.directory ) ){
		dir.create( www.directory, recursive = T )
	}
	
	bootstrap.copy( www.directory, "ReporteRs")	
	
	out = .jcall( doc$jobj , "I", "writeHtml", file )
	if( out != 1 ){
		stop( "Problem while trying to write html content onto the disk." )
	}
	invisible()
}

#' @title get HTML code from a bsdoc object
#'
#' @description get HTML code from a bsdoc document
#' 
#' @param object the \code{bsdoc} object
#' @param ... further arguments passed to other methods 
#' @return a character value
#' @seealso \code{\link{bsdoc}}
#' @export
as.html.bsdoc = function( object, ... ) {
	.jcall( object$jobj, "S", "getHTML" )
	
}


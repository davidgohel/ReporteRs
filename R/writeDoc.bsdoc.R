#' @title Write a \code{bsdoc} object in a html file
#'
#' @description Write the \code{\link{bsdoc}} object in '.html' files located in a specified directory.
#' 
#' bootstrap files will be copied in the directory if directory does not exist.
#' 
#' @param doc \code{\link{bsdoc}} object that has to be written.
#' @param file single character value, name of the html file to write.
#' @param reset.dir logical defaut to FALSE. Used to specify if the directory containing 
#' the file to produced should be deleted first (if existing for example). Set to FALSE 
#' enable to produce several html files in the same directory.
#' @param ... further arguments, not used. 
#' @return the function a character vector containing generated html documents filenames.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "writeDoc_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{writeDoc}}
#' @method writeDoc bsdoc
#' @S3method writeDoc bsdoc
writeDoc.bsdoc = function(doc, file, reset.dir = FALSE, ...) {
	if( !is.character( file ) ) stop("argument file must be a valid filename (a string value).")
	if( length( file ) != 1 ) stop("length of argument file is not 1.")
	.reg = regexpr( paste( "(\\.(?i)(html))$", sep = "" ), file )
	if( .reg < 1 )
		stop(file , " is not a valid file.")
	
	file = normalizePath( path.expand(file) , mustWork=F, winslash="/")
	
	www.directory = dirname( file )
	
	if( !file.exists( www.directory ) || reset.dir ){
		dir.create( www.directory, recursive = T )
		bootstrap.copy( www.directory, "ReporteRs")	
	}
	out = .jcall( doc$jobj , "I", "writeHtml", file )
	if( out != 1 ){
		stop( "Problem while trying to write html content onto the disk." )
	}
	invisible()
}


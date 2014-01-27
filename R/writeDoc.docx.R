#' @title Write a docx object in a docx file
#'
#' @description Write the \code{"docx"} object in a '.docx' file.
#' 
#' @param doc Object of class \code{"docx"} that has to be written.
#' @param file single character value, name of the file to write.
#' @param ... further arguments, not used. 
#' 
#' @examples
#' # Create a new document 
#' doc = docx( title = "title" )
#' doc <- addParagraph(doc, "Hello Word!", "Normal");
#' # Write the object in file "~/document.docx"
#' writeDoc( doc, "~/document.docx" )
#' @seealso \code{\link{docx}}, \code{\link{writeDoc}}
#' @method writeDoc docx
#' @S3method writeDoc docx

writeDoc.docx = function(doc, file, ...) {

	if( !is.character( file ) ) stop("argument file must be a valid filename (a string value).")
	if( length( file ) != 1 ) stop("length of argument file is not 1.")
	if( !is.character( file ) ) stop("argument file must be a string value (a filename).")
	.reg = regexpr( paste( "(\\.(?i)(docx))$", sep = "" ), file )
	if( .reg < 1 )
		stop(file , " is not a valid file.")
	
	file = normalizePath( path.expand(file) , mustWork=F, winslash="/")
	
	if( !tryCatch( {
			cat("", file = file)
			T
			}, error = function( e ) F, warning = function ( e ) F , finally = T) )
		stop("writeDoc: Cannot write to ", file)
	
	rJava::.jcall( doc$obj , "V", "writeDocxToStream", file )
	}




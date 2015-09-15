#' @title Write a pptx object in a pptx file
#'
#' @description Write the \code{\link{pptx}} object in a '.pptx' file.
#' 
#' @param doc \code{\link{pptx}} object that has to be written.
#' @param file single character value, name of the file to write.
#' @param ... further arguments, not used. 
#' 
#' @examples
#' #START_TAG_TEST
#' doc.filename = "writeDoc_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{writeDoc}}
#' @export
writeDoc.pptx = function(doc, file, ...) {

	if( !is.character( file ) ) stop("argument file must be a valid filename (a string value).")
	if( length( file ) != 1 ) stop("length of argument file is not 1.")
	if( !is.character( file ) ) stop("argument file must be a string value (a filename).")
	.reg = regexpr( paste( "(\\.(?i)(pptx))$", sep = "" ), file )
	if( .reg < 1 )
		stop(file , " is not a valid file.")
	
	file = normalizePath( path.expand(file) , mustWork=F, winslash="/")
	if( !tryCatch( {
			cat("", file = file)
			T
			}, error = function( e ) F, warning = function ( e ) F , finally = T) )
		stop("writeDoc: Cannot write to ", file)
	out = .jcall( doc$obj , "I", "writePptxToStream", file )

	if( out != error_codes["NO_ERROR"] )
		stop( "Error - code[", names(error_codes)[which( error_codes == out )], "].")
	
	}




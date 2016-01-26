#' @title Write a document object
#'
#' @description Write a document object into a file
#'
#' @param doc document object
#' @param file single character value, name of the html file to write.
#' @param ... unused
#' @details
#'
#' When the document object is a \code{\link{bsdoc}} object, \code{writeDoc} is
#' considering the directory where 'html' file is written. Bootstrap files (css, js, etc.)
#' will be copied in the directory if directory does not exist.
#'
#' @export
#' @examples
#' doc <- docx()
#' writeDoc( doc, "ex_write_doc.docx")
#'
#' doc <- pptx()
#' doc <- addSlide(doc, "Title and Content")
#' writeDoc( doc, "ex_write_doc.pptx")
#'
#' doc <- bsdoc()
#' writeDoc( doc, "ex_write_doc/index.html")
#' @seealso \code{\link{docx}}, \code{\link{pptx}}, \code{\link{bsdoc}}
writeDoc = function(doc, ...){
  UseMethod("writeDoc")
}


#' @rdname writeDoc
#' @export
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

  .jcall( doc$obj , "V", "writeDocxToStream", file )
}



#' @rdname writeDoc
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




#' @rdname writeDoc
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


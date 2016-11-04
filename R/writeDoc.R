#' @title Write a document object
#'
#' @description Write a document object into a file
#'
#' @param doc document object
#' @param file single character value, name of the html file to write.
#' @param ... unused
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
#' @seealso \code{\link{docx}}, \code{\link{pptx}}
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

  file = normalizePath( path.expand(file) , mustWork=FALSE, winslash="/")

  if( !tryCatch( {
    cat("", file = file)
    TRUE
  }, error = function( e ) FALSE, warning = function ( e ) FALSE , finally = TRUE) )
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

  file = normalizePath( path.expand(file) , mustWork=FALSE, winslash="/")
  if( !tryCatch( {
    cat("", file = file)
    TRUE
  }, error = function( e ) FALSE, warning = function ( e ) FALSE , finally = TRUE) )
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

	file = normalizePath( path.expand(file) , mustWork=FALSE, winslash="/")

	www.directory = dirname( file )

	if( !file.exists( www.directory ) ){
		dir.create( www.directory, recursive = TRUE )
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


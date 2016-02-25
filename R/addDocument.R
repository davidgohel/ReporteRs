#' @title Add an external document into a document object
#'
#' @description Add an external document into a document object
#'
#' @param doc document object
#' @param filename \code{"character"} value, complete filename
#' of the external file
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}
addDocument = function(doc, filename, ...){
  checkHasSlide(doc)
  if( missing( filename ) )
    stop("filename cannot be missing")
  if( !inherits( filename, "character" ) )
    stop("filename must be a single character value")
  if( length( filename ) != 1 )
    stop("filename must be a single character value")
  if( !file.exists( filename ) )
    stop( filename, " does not exist")

  UseMethod("addDocument")
}


#' @details
#' ReporteRs does only copy the document as an external file. Headers and footers are also
#' imported and displayed. This function is not to be used to merge documents.
#'
#' @examples
#' \dontrun{
#' doc.filename <- "addDocument_example.docx"
#' # set default font size to 10
#' options( "ReporteRs-fontsize" = 10 )
#'
#' doc2embed <- docx( )
#' img.file <- file.path( Sys.getenv("R_HOME"),
#'                       "doc", "html", "logo.jpg" )
#' if( file.exists(img.file) && requireNamespace("jpeg", quietly = TRUE) ){
#'   dims <- attr( jpeg::readJPEG(img.file), "dim" )
#'
#'   doc2embed <- addImage(doc2embed, img.file,
#'                        width = dims[2]/72, height = dims[1]/72)
#'   writeDoc( doc2embed, file = "external_file.docx" )
#'
#'   doc <- docx( )
#'   doc <- addDocument( doc, filename = "external_file.docx" )
#'   writeDoc( doc, file = doc.filename )
#' }
#' }
#' @rdname addDocument
#' @export
addDocument.docx = function(doc, filename, ... ) {

	pos <- regexpr("\\.([[:alnum:]]+)$", filename)
	ext = ifelse(pos > -1L, substring(filename, pos + 1L), "")

	if( ext == "docx" ){
		.jcall( doc$obj, "V", "insertExternalDocx", filename )
	} else stop("filename must be a docx document.")

	doc
}

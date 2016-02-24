#' @title Add external document into a docx object
#'
#' @description Add external document into a \code{\link{docx}} object.
#'
#' @param doc Object of class \code{\link{docx}} where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external
#' file (a Word document with \code{docx} extension).
#' @param ... further arguments, not used.
#' @details
#' The rendering of embedded documents is made by Word. ReporteRs does only copy
#' the content of the external file in the document.
#'
#' When adding an external docx file into a docx object, styles of the external
#' file are imported into the docx object. If a style exists in the docx object,
#' Word will use the style of the docx object.
#'
#' @return an object of class \code{\link{docx}}.
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
#' @seealso \code{\link{docx}}, \code{\link{addDocument}}
#' @export
addDocument.docx = function(doc, filename, ... ) {

	pos <- regexpr("\\.([[:alnum:]]+)$", filename)
	ext = ifelse(pos > -1L, substring(filename, pos + 1L), "")

	if( ext == "docx" ){
		.jcall( doc$obj, "V", "insertExternalDocx", filename )
	} else stop("filename must be a docx document.")

	doc
}

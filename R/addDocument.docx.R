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
#' #START_TAG_TEST
#' doc.filename = "addDocument_example.docx"
#' @example examples/addDocument.docx.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
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

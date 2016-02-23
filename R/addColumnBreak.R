#' @title Add a column break into a section
#'
#' @description Add a column break into a section
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' \code{addColumnBreak} only works with docx documents.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addSection}}
addColumnBreak = function(doc, ...){
  checkHasSlide(doc)
  UseMethod("addColumnBreak")
}



#' @examples
#' doc.filename = "add_col_break.docx"
#' doc = docx( )
#' doc = addSection(doc, ncol = 2, columns.only = TRUE )
#' doc = addParagraph( doc = doc, "Text 1.", "Normal" )
#' doc = addColumnBreak(doc )
#' doc = addParagraph( doc = doc, "Text 2.", "Normal" )
#' @example examples/writeDoc_file.R
#' @rdname addColumnBreak
#' @export
addColumnBreak.docx = function(doc, ...) {
  .jcall( doc$obj, "V", "addColumnBreak" )
  doc
}

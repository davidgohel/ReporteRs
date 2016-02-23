#' @title Add a page break into a document object
#'
#' @description Add a page break into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' \code{addPageBreak} only works with docx documents.
#'
#' See \code{\link{addPageBreak.docx}} for examples.
#' @export
#' @seealso \code{\link{docx}}
addPageBreak = function(doc, ...){
  checkHasSlide(doc)
  UseMethod("addPageBreak")
}


#' @examples
#' doc = docx( title = "title" )
#' doc = addPageBreak( doc )
#' @export
#' @rdname addPageBreak
addPageBreak.docx =  function( doc, ... ) {
	.jcall( doc$obj, "V", "addPageBreak" )
	doc
}


#' @title Insert a page break into a docx object
#'
#' @description Insert a page break into a \code{\link{docx}} object.
#' 
#' @param doc Object of class \code{\link{docx}} where page break has to be added
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{docx}}.
#' @examples
#' #START_TAG_TEST
#' doc = docx( title = "title" )
#' doc = addPageBreak( doc )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{addPageBreak}}
#' @method addPageBreak docx
#' @S3method addPageBreak docx
addPageBreak.docx =  function( doc, ... ) {
	.jcall( doc$obj, "V", "addPageBreak" )
	doc
}


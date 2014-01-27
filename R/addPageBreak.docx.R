#' @title Insert a page break into a docx object
#'
#' @description Insert a page break into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"} where page break has to be added
#' @param ... further arguments, not used. 
#' @return an object of class \code{"docx"}.
#' @examples
#' doc = docx( title = "title" )
#' doc <- addPageBreak(doc)
#' @seealso \code{\link{docx}}, \code{\link{addPageBreak}}
#' @method addPageBreak docx
#' @S3method addPageBreak docx
addPageBreak.docx =  function( doc, ... ) {
	rJava::.jcall( doc$obj, "V", "addPageBreak" )
	doc
}


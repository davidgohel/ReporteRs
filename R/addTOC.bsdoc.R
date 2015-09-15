#' @title Insert a table of contents into a bsdoc object
#'
#' @description Insert a table of contents into a \code{\link{bsdoc}} object.
#' 
#' @param doc Object of class \code{\link{bsdoc}} where table of content has to be added
#' @param ... further arguments, not used. 
#' @details 
#' The function do specify to add a table of contents on the right side 
#' of the content.  
#' 
#' @return an object of class \code{\link{bsdoc}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addTOC_example/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTOC.bsdoc.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addTOC.bsdoc}}
#' , \code{\link{docx}}, \code{\link{addTOC.docx}}
#' @export
addTOC.bsdoc = function(doc, ... ) {

	.jcall( doc$jobj, "V", "addTOC" )

	doc
}

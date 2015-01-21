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
#' doc = bsdoc( )
#' 
#' doc = addTitle( doc, 'Title 1', level = 1 )
#' 
#' doc = addTitle( doc, 'Title 2', level = 1 )
#' 
#' doc = addTitle( doc, 'Title 3', level = 1 )
#' 
#' doc = addTitle( doc, 'Title A', level = 2 )
#' 
#' doc = addTitle( doc, 'Title B', level = 2 )
#' 
#' doc = addTOC( doc )
#' 
#' writeDoc( doc, file = 'addTOC_example/example.html')
#' #STOP_TAG_TEST
#' @seealso \code{\link{bsdoc}}, \code{\link{addTOC.bsdoc}}
#' , \code{\link{docx}}, \code{\link{addTOC.docx}}
#' @export
addTOC.bsdoc = function(doc, ... ) {

	.jcall( doc$jobj, "V", "addTOC" )

	doc
}

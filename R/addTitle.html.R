#' @title Insert a title into a html object
#'
#' @description Add a title into a \code{"html"} object.
#' 
#' @param doc Object of class \code{"html"}
#' @param value \code{"character"} value to use as title text
#' @param level \code{"integer"} positive value to use as heading level. 1 for title1, 2 for title2, etc.
#' @param ... further arguments, not used. 
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to write
#' doc = addPage( doc, title = "page example" )
#' 
#' doc = addTitle( doc, "My first title", level = 1 )
#' doc = addTitle( doc, "My first sub-title", level = 2 )
#' 
#' doc = addParagraph(doc, "Hello Word!" )
#' 
#' # writes document in directory "addTitle_example"
#' writeDoc( doc, "addTitle_example" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{addTitle}}
#' @method addTitle html
#' @S3method addTitle html
addTitle.html = function( doc, value, level, ... ) {
	jtitle = .jnew(class.html4r.Title, as.character(value), as.integer(level)  )
	out = .jcall( doc$current_slide , "I", "add", jtitle )
	if( out != 1 ){
		stop( "Problem while trying to add title." )
	}
	doc
}



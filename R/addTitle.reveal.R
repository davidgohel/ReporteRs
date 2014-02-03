#' @title Insert a title into a reveal object
#'
#' @description Add a title into a \code{"reveal"} object.
#' 
#' @param doc Object of class \code{"reveal"}
#' @param value \code{"character"} value to use as title text
#' @param level \code{"integer"} positive value to use as heading level. 1 for title1, 2 for title2, etc.
#' @param ... further arguments, not used. 
#' @return an object of class \code{"reveal"}.
#' @examples
#' # Create a new document 
#' doc = reveal( title = "title" )
#' # add a page where to write
#' doc = addSlide( doc )
#' doc = addTitle( doc, "My first title", level = 1 )
#' doc = addTitle( doc, "My first sub-title", level = 2 )
#' doc <- addParagraph(doc, "Hello Word!", "Normal");
#' # write the reveal object in a directory
#' reveal.directory <- "reveal_doc"
#' reveal.files = writeDoc( doc, directory = reveal.directory )
#' @seealso \code{\link{reveal}}, \code{\link{addTitle}}
#' @method addTitle reveal
#' @S3method addTitle reveal
addTitle.reveal = function( doc, value, level, ... ) {
	jtitle = .jnew(class.html4r.Title, as.character(value), as.integer(level)  )
	out = rJava::.jcall( doc$current_slide , "I", "add", jtitle )
	if( out != 1 ){
		stop( "Problem while trying to add title." )
	}
	doc
}



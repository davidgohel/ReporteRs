#' @title Add R script into a html object
#'
#' @description Add R script into a \code{"html"} object.
#' 
#' @param doc Object of class \code{"html"} where expressions have to be added
#' @param rscript an object of class \code{RScript}
#' @param ... further arguments, not used. 
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' doc.dirname = "addRScript_example"
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add R outputs with title 'page example'
#' doc = addPage( doc, title = "page example" )
#' 
#' an_rscript = RScript( text = "ls()" )
#' doc = addRScript( doc, an_rscript )
#' 
#' @example examples/writeDoc_directory.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{html}}, \code{\link{addRScript}}
#' @method addRScript html
#' @S3method addRScript html
addRScript.html = function(doc, rscript, ...) {
	out = .jcall( doc$current_slide, "I", "add" , rscript$jobj)
	if( out != 1 ){
		stop( "Problem while trying to add rscript." )
	}
	doc
}


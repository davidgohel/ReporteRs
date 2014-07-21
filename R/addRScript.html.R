#' @title Add R script into a html object
#'
#' @description Add R script into a \code{"html"} object.
#' 
#' @param doc Object of class \code{"html"} where expressions have to be added
#' @param file R script file. Not used if text or 
#' rscript is provided.
#' @param text character vector. The text to parse. 
#' Not used if file or rscript is provided.
#' @param rscript an object of class \code{RScript}. 
#' Not used if file or text is provided.
#' @param ... further arguments, not used. 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
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
addRScript.html = function(doc, rscript, file, text, ...) {
	
	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	} 
	
	out = .jcall( doc$current_slide, "I", "add" , rscript$jobj)
	if( out != 1 ){
		stop( "Problem while trying to add rscript." )
	}
	doc
}


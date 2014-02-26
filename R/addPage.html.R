#' @title Insert a page into an html object
#'
#' @description Add a page into a \code{"html"} object.
#' 
#' @param doc Object of class \code{"html"} where page has to be added
#' @param title \code{"character"} value: title of the HTML page.
#' @param ... further arguments, not used. 
#' @details 
#' A page is where content is added.
#' This function is a key function ; if no page has been added into the document object
#' no content (tables, plots, images, texts) can be added. 
#' 
#' @return an object of class \code{"pptx"}.
#' @examples
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add R outputs with title 'page example'
#' doc = addPage( doc, title = "page example" )
#' 
#' # add iris dataset as a table in the page
#' doc <- addTable(doc, iris )
#' 
#' # write the html object in a directory
#' pages = writeDoc( doc, "html_output_dir")
#' print( pages ) # print filenames of generated html pages
#' @seealso \code{\link{html}}, \code{\link{addPage}}
#' @method addPage html
#' @S3method addPage html
addPage.html = function( doc, title, ... ) {
	
	if( !is.character( title ) )
		stop("title must be a character vector of length 1.")
	if( length( title ) != 1 )
		stop("title must be a character vector of length 1.")
	
	slide = rJava::.jnew(class.html4r.HTMLPageContent, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1") )
	
	rJava::.jcall( slide , "V", "addJavascript", "js/jquery.min.js" )
	rJava::.jcall( slide , "V", "addJavascript", "js/bootstrap.min.js" )
	rJava::.jcall( slide , "V", "addJavascript", "js/raphael-min.js" )
	
	rJava::.jcall( slide , "V", "addStylesheet", "css/bootstrap.min.css" )
	rJava::.jcall( slide , "V", "addStylesheet", "css/html4r.css" )
	rJava::.jcall( slide , "V", "addStylesheet", "css/highlight.css" )
	
	
	rJava::.jcall( doc$obj , "V", "addNewPage", title, slide )
	doc$current_slide = slide
	
	doc
}

#' @title Insert a page into an html object
#'
#' @description Add a page into a \code{\link{html}} object.
#' 
#' @param doc \code{\link{html}} object where page has to be added
#' @param title \code{"character"} value: title of the HTML page.
#' @param ... further arguments, not used. 
#' @details 
#' A page is where content is added.
#' This function is a key function ; if no page has been added into the document object
#' no content (tables, plots, images, text) can be added. 
#' 
#' @return an object of class \code{\link{html}}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add R outputs with title 'page example'
#' doc = addPage( doc, title = "page example" )
#' 
#' # add iris dataset as a table in the page
#' doc = addTable(doc, iris )
#' 
#' # write the html object in a directory
#' pages = writeDoc( doc, "addPage_example")
#' print( pages ) # print filenames of generated html pages
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{addPage}}
#' @method addPage html
#' @S3method addPage html
addPage.html = function( doc, title, ... ) {
	
	if( missing( title ) )
		stop("title is missing.")
	if( !is.character( title ) )
		stop("title must be a character vector of length 1.")
	if( length( title ) != 1 )
		stop("title must be a character vector of length 1.")
	
	lidef = do.call( list.format, getOption("ReporteRs-list-definition") )
	
	slide = .jnew(class.html4r.HTMLPageContent, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1"), lidef )
	
	.jcall( slide , "V", "addJavascript", "js/jquery.min.js" )
	.jcall( slide , "V", "addJavascript", "js/bootstrap.min.js" )
	.jcall( slide , "V", "addJavascript", "js/docs.min.js" )
	
	.jcall( slide , "V", "addJavascript", "js/raphael-min.js" )
	.jcall( slide , "V", "addJavascript", "js/g.raphael-min.js" )
	
	.jcall( slide , "V", "addStylesheet", "css/bootstrap.min.css" )
	.jcall( slide , "V", "addStylesheet", "css/docs.min.css" )
	.jcall( slide , "V", "addStylesheet", "css/bootstrap-theme.css" )
	
	.jcall( doc$obj , "V", "addNewPage", title, slide )
	doc$current_slide = slide
	
	doc
}

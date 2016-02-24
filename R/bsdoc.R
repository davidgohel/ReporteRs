#' @title Create an object representation of a bootstrap html
#' document
#'
#' @description
#' Create a \code{\link{bsdoc}} object
#'
#' @param title \code{"character"} value: title of the document.
#' @param list.definition a list definition to specify how ordered and unordered
#' lists have to be formated. See \code{\link{list.settings}}. Default to
#' \code{getOption("ReporteRs-list-definition")}.
#' @param keywords \code{"character"} value: keywords metadata value to set in the html page
#' @param description \code{"character"} value: description metadata value to set in the html page
#' @param mathjax \code{logical} value: if \code{TRUE} activate mathjax
#' @return an object of class \code{\link{bsdoc}}.
#' @details
#' Several methods can used to send R output into an object of class \code{\link{bsdoc}}.
#'
#' \itemize{
#'   \item \code{\link{addTitle.bsdoc}} add titles
#'   \item \code{\link{addParagraph.bsdoc}} add text
#'   \item \code{\link{addPlot.bsdoc}} add plots
#'   \item \code{\link{addFlexTable.bsdoc}} add tables. See \code{\link{FlexTable}}
#'   \item \code{\link{addImage.bsdoc}} add external images
#'   \item \code{\link{addMarkdown.bsdoc}} add markdown text
#'   \item \code{\link{addRScript.bsdoc}} add highlighted r script
#'   \item \code{\link{addBootstrapMenu}} add a bootstrap menu to the html page
#'   \item \code{\link{addFooter.bsdoc}} add text into the footer of the html page
#' }
#'
#' Once object has content, user can write the docx into a ".html" file, see \code{\link{writeDoc.bsdoc}}.
#' @export
#' @examples
#'
#' @example examples/bsdoc_example.R
#' @seealso \code{\link{docx}}, \code{\link{pptx}}
bsdoc = function( title = "untitled", list.definition = getOption("ReporteRs-list-definition"), keywords = "", description = "", mathjax = FALSE ){

	if( !is.character( title ) )
		stop("title must be a character vector of length 1.")
	if( length( title ) != 1 )
		stop("title must be a character vector of length 1.")

	lidef = do.call( list.settings, list.definition )

	HTMLPage = .jnew(class.BootstrapPage.document, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1"),
			lidef ,
			description, keywords)
	.jcall( HTMLPage , "V", "addJavascript", "js/jquery.min.js" )
	.jcall( HTMLPage , "V", "addJavascript", "js/bootstrap.min.js" )
	.jcall( HTMLPage , "V", "addJavascript", "js/docs.min.js" )

	if (mathjax){
	    .jcall( HTMLPage , "V", "addJavascript", "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" )
	}

	.jcall( HTMLPage , "V", "addStylesheet", "css/bootstrap.min.css" )
	.jcall( HTMLPage , "V", "addStylesheet", "css/docs.min.css" )

	.Object = list( title = title, jobj = HTMLPage, canvas_id = 1 )
	class( .Object ) = "bsdoc"

	.Object
}


#' @title Print method for \code{\link{bsdoc}} objects.
#'
#' @description print a \code{\link{bsdoc}} object.
#' If R session is interactive, the document is
#' rendered in an HTML page and loaded into a WWW browser.
#'
#' @param x a \code{\link{bsdoc}} object
#' @param ... further arguments, not used.
#'
#' @examples
#' # Create a new document
#' doc = bsdoc( )
#' print( doc )
#' @export
print.bsdoc = function(x, ...){

	if (!interactive() ){
		cat("[bsdoc object]\n")
		cat("title:", x$title, "\n")
	} else {
		viewer <- getOption("viewer")
		path = file.path(tempfile(), "temp_bsdoc.html" )
		writeDoc( x, path )
		if( !is.null( viewer ) && is.function( viewer ) ){
			viewer( path )
		} else {
			utils::browseURL(path)
		}
	}

	invisible()

}




#' @title add javascript into a bsdoc object
#'
#' @description
#' add javascript into a \code{bsdoc} object.
#'
#' @param doc a \code{bsdoc} object.
#' @param file a javascript file. Not used if text is provided.
#' @param text character vector. The javascript text to parse.
#' Not used if file is provided.
#' @return an object of class \code{\link{bsdoc}}.
#' @export
addJavascript = function( doc, file, text ){
	if( !inherits( doc , "bsdoc") )
		stop("doc is not a bsdoc object.")

	if( !missing( file ) ){
		if( length( file ) != 1 ) stop("file must be a single filename.")
		if( !file.exists( file ) ) stop("file does not exist.")
	}

	if( missing( file ) ){
		js = paste( text, collapse = "\n" )
	} else {
		js = paste( scan( file = file, what = "character", sep = "\n", quiet = TRUE ), collapse = "\n" )
	}

	.jcall( doc$jobj , "V", "addJavascriptCode", js )

	doc
	}


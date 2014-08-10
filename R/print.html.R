#' @title print informations about an object of class \code{\link{html}}.
#'
#' @description
#' print informations about an object of class \code{\link{html}}.
#' 
#' @param x an object of class \code{\link{html}}
#' @param ... further arguments, not used. 
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = html( title = "title" )
#' print( doc )
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{print}}
#' @method print html
#' @S3method print html

print.html = function (x, ...){

	cat("[html object]\n")
	
	cat("title:", x$title, "\n")
	
	invisible()
	
}



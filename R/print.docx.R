#' @title print informations about an object of class \code{\link{docx}}.
#'
#' @description
#' print informations about an object of class \code{\link{docx}}.
#' 
#' @param x an object of class \code{\link{docx}}
#' @param ... further arguments, not used. 
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = docx( title = "title" )
#' print( doc )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{print}}
#' @method print docx
#' @S3method print docx

print.docx = function (x, ...){
	cat("[docx object]\n")
	
	cat("title:", x$title, "\n")
	
	cat(paste( "Original document: '", x$basefile, "'\n", sep = "" ) )
	
	cat( "Styles:\n" )
	print( styles( x ) )
	
	invisible()
}



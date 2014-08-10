#' @title print informations about an object of class \code{\link{pptx}}.
#'
#' @description
#' print informations about an object of class \code{\link{pptx}}.
#' 
#' @param x an object of class \code{\link{pptx}}
#' @param ... further arguments, not used. 
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = pptx( title = "title" )
#' print( doc )
#' #STOP_TAG_TEST
#' @seealso \code{\link{pptx}}, \code{\link{print}}
#' @method print pptx
#' @S3method print pptx

print.pptx = function (x, ...){

	cat("[pptx object]\n")
	
	cat("title:", x$title, "\n")
	
	cat(paste( "Original document: '", x$basefile, "'\n", sep = "" ) )
	
	cat( "Slide layouts:\n" )
	print( slide.layouts( x ) )
	
	
	invisible()
	
}



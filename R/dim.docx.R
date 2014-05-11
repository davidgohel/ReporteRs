#' @title Get page layout dimensions of a Word document   
#'
#' @description Returns page width and height and page margins
#' of a \code{docx} object.
#' 
#' @param x Object of class \code{docx}
#' @examples
#' #START_TAG_TEST
#' doc = docx( title = "title" )
#' dim( doc )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{dim.pptx}}
#' @method dim docx
#' @S3method dim docx
dim.docx = function( x ){
	temp = .jcall(x$obj, "[I", "getSectionDimensions")
	out = list( page = c( width = temp[1], height = temp[2] ) / 1440
			, margins = c(top = temp[3], right = temp[4], bottom = temp[5], left = temp[5]) / 1440
	)
	out
}

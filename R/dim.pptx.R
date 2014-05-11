#' @title Get coordinates of next available shape of a PowerPoint document
#'
#' @description Returns position and dimension of the next available shape
#' in the current slide. 
#' 
#' @param x Object of class \code{pptx}
#' @examples
#' #START_TAG_TEST
#' doc = pptx( title = "title" )
#' doc = addSlide( doc, "Title and Content" )
#' dim(doc)
#' #STOP_TAG_TEST
#' @seealso \code{\link{pptx}}, \code{\link{dim.docx}}
#' @method dim pptx
#' @S3method dim pptx
dim.pptx = function( x ){
	temp = .jcall(x$current_slide, "[I", "getShapeDimensions")
	out = list( position = c( left = temp[1], top = temp[2] ) / 914400
			, size = c(width = temp[3], height = temp[4]) / 914400
	)
	out
}

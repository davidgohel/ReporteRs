#' @title Insert an external image into a bsdoc object
#'
#' @description Add an external image into a \code{\link{bsdoc}} object.
#'
#' @param doc \code{\link{bsdoc}} object where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param width image width in inches
#' @param height image height in inches
#' @param par.properties paragraph formatting properties of the paragraph that contains images.
#' An object of class \code{\link{parProperties}}
#' @param ... further arguments, not used.
#' @details
#' Arguments \code{width} and \code{height} can be defined with functions
#' \code{png::readPNG}, \code{jpeg::readJPEG} or \code{bmp::read.bmp}.
#' @return an object of class \code{\link{bsdoc}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addImage_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addImageDocument.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addPlot.bsdoc}}
#' , \code{\link{addImage}}
#' @export
addImage.bsdoc = function(doc, filename, width, height,
		par.properties = parProperties(text.align = "center", padding = 5 ),
		... ) {

  if( missing(width) )
    stop("width can not be missing")
  if( missing(height) )
    stop("height can not be missing")

  if( !is.numeric( width ) )
    stop("arguments width must be a numeric vector")
  if( !is.numeric( height ) )
    stop("arguments height must be a numeric vector")

  jimg = .jnew(class.Image , filename, .jfloat( width ), .jfloat( height ) )

	.jcall( jimg, "V", "setParProperties", .jParProperties(par.properties) )

	out = .jcall( doc$jobj, "I", "add", jimg )
	if( out != 1 )
		stop( "Problem while trying to add image(s)." )

	doc
}

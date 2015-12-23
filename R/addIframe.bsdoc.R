#' @title Insert an iframe into a bsdoc object
#'
#' @description Add an iframe into a \code{\link{bsdoc}} object
#'
#' @param doc \code{\link{bsdoc}} object where iframe has to be added
#' @param src url of the document to embed in the iframe
#' @param width Specifies the width of an iframe
#' @param height Specifies the height of an iframe
#' @param seamless Specifies that the iframe should look like it is a part of the containing document
#' @param par.properties paragraph formatting properties of the paragraph that contains iframe.
#' An object of class \code{\link{parProperties}}
#' @param ... further arguments, not used.
#' @return an object of class \code{\link{bsdoc}}.
#' @export
addIframe.bsdoc = function(doc, src, width, height, seamless = FALSE,
		par.properties = parProperties(text.align = "center", padding = 5 ), ... ) {

	if( missing( width ) && missing(height) ){
		stop("width and height cannot be missing")
	}
	jiframe = .jnew(class.Iframe, as.integer(width), as.integer(height),
			as.logical( seamless ), src,
			.jParProperties(par.properties)
			)
	out = .jcall( doc$jobj, "I", "add", jiframe )
	if( out != 1 )
		stop( "Problem while trying to add iframe." )


	doc
}

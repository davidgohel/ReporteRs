#' @title border properties object
#'
#' @description create a border properties object.
#' 
#' @param color border color - single character value (e.g. "#000000" or "black")
#' @param style border style - single character value : "none" or "solid" or "dotted" or "dashed"
#' @param width border width - an integer value : 0>= value
#' @examples 
#' borderProperties()
#' borderProperties(color="orange", style="solid", width=1)
#' borderProperties(color="gray", style="dotted", width=1)
#' @seealso \code{\link{FlexTable}}, \code{\link{setFlexTableBorders}}
#' @export 
borderProperties = function( color = "black", style = "solid", width = 1 ){
	
	if( length( color ) != 1 ) stop("color must be a single character value")
	if( length( style ) != 1 ) stop("style must be a single character value")
	if( length( width ) != 1 ) stop("width must be a single integer value")
	
	if( is.numeric( width ) ) {
		if( as.integer( width ) < 0 || !is.finite( as.integer( width ) ) ) 
			stop("invalid width : ", width )
	} else {
		stop("width must be a single integer value >= 0")
	}
	
	if( !is.character( style ) ) {
		stop("style must be a character value.")
	}
	if( !is.element( style, ReporteRs.border.styles ) )
		stop("style must be a character value (", paste( ReporteRs.border.styles, collapse = "|") ,").")
	
	if( !is.character( color ) ) {
		stop("color must be a character value.")
	} else if( !is.color(color) ){
		stop("color must be a valid color.")
	}
	
	
	out = list( 
			color = color
			, style = style
			, width = width
	)
	class( out ) = "borderProperties"
	out
}
as.jborderProperties = function( object ){
	jborderProperties(borderColor = object$color, borderStyle = object$style, borderWidth = object$width)
}

jborderProperties = function( borderColor, borderStyle, borderWidth ){
	.jnew(class.tables.BorderProperties
			, as.character(borderColor), as.character(borderStyle)
			, as.integer( borderWidth )
	)
}


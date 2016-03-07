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
#' @seealso \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}},
#' \code{\link{shortcut_properties}}
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
	  color = colorProperties(color), style = style, width = width
	  )
	class( out ) = "borderProperties"
	out
}


#' @param ... further arguments - not used
#' @param object \code{borderProperties} object to update
#' @details
#' Get a modified version of a \code{borderProperties} with
#' \code{chprop}.
#' @examples
#'
#' # update borderProperties --------
#' x = borderProperties()
#' chprop(x, color="orange", style="dashed", width=1)
#' chprop(x, width=5)
#' @rdname borderProperties
#' @export
chprop.borderProperties <- function(object, color, style, width, ... ) {

	if( !missing( color ) ){
		if( length( color ) != 1 ) stop("color must be a single character value")
		if( !is.character( color ) ) {
			stop("color must be a character value.")
		} else if( !is.color(color) ){
			stop("color must be a valid color.")
		}
		object$color = colorProperties(color)
	}
	if( !missing( style ) ){
		if( length( style ) != 1 ) stop("style must be a single character value")
		if( !is.character( style ) ) {
			stop("style must be a character value.")
		}
		if( !is.element( style, ReporteRs.border.styles ) )
			stop("style must be a character value (", paste( ReporteRs.border.styles, collapse = "|") ,").")

		object$style = style
	}
	if( !missing( width ) ){
		if( length( width ) != 1 ) stop("width must be a single integer value")

		if( is.numeric( width ) ) {
			if( as.integer( width ) < 0 || !is.finite( as.integer( width ) ) )
				stop("invalid width : ", width )
		} else {
			stop("width must be a single integer value >= 0")
		}
		object$width = width
	}

	object
}


#' @param x \code{borderProperties} object to print
#' @rdname borderProperties
#' @export
print.borderProperties = function (x, ...){
	cat( "borderProperties{color:", as.character(x$color), ";" )
	cat( "style:", x$style, ";" )
	cat( "width:", x$width, ";" )
	cat( "}" )
}

#' @rdname borderProperties
#' @export
as.character.borderProperties = function (x, ...){
	paste( "borderProperties{color:", as.character(x$color), ";",
			"style:", x$style, ";", "width:", x$width, ";}", sep = "" )

}

.jborderProperties = function( object ){
	.jnew(class.tables.BorderProperties,
			.jcolorProperties(object$color),
			as.character(object$style), as.integer( object$width ) )
}


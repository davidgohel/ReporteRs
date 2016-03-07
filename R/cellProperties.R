#' @title Cell formatting properties
#'
#' @description Create a \code{cellProperties} object that describes cell formatting properties.
#' This objects are used by \code{\link{FlexTable}}.
#'
#' @param padding cell padding - 0 or positive integer value. Argument \code{padding} overwrites
#' arguments \code{padding.bottom}, \code{padding.top}, \code{padding.left}, \code{padding.right}.
#' @param border.width border width - 0 or positive integer value. Argument \code{border.width}
#' overwrites arguments \code{border.bottom.width}, \code{border.top.width}
#' , \code{border.left.width}, \code{border.right.width}.
#' @param border.style border style - a single character value, expected value is one of "none"
#' , "solid", "dotted", "dashed". Argument \code{border.style} overwrites arguments
#' \code{border.bottom.style}, \code{border.top.style}, \code{border.left.style}
#' , \code{border.right.style}.
#' @param border.color border color - a single character value specifying a valid color
#' (e.g. "#000000" or "black").
#'  Argument \code{border.color} overwrites arguments \code{border.bottom.color}
#' , \code{border.top.color}, \code{border.left.color}, \code{border.right.color}.
#' @param border.bottom \code{\link{borderProperties}} for bottom border. overwrite all border.bottom.* if specified.
#' @param border.left \code{\link{borderProperties}} for left border. overwrite all border.left.* if specified.
#' @param border.top \code{\link{borderProperties}} for top border. overwrite all border.top.* if specified.
#' @param border.right \code{\link{borderProperties}} for right border. overwrite all border.right.* if specified.
#' @param border.bottom.color border bottom color - a single character value specifying
#' a valid color (e.g. "#000000" or "black").
#' @param border.bottom.style border bottom style - a single character value, expected
#' value is one of "none", "solid", "dotted", "dashed".
#' @param border.bottom.width border bottom width - 0 or positive integer value
#' @param border.left.color border left color - a single character value specifying a
#' valid color (e.g. "#000000" or "black").
#' @param border.left.style border left style - a single character value, expected
#' value is one of "none", "solid", "dotted", "dashed".
#' @param border.left.width border left width - 0 or positive integer value
#' @param border.top.color border top color - a single character value specifying a
#' valid color (e.g. "#000000" or "black").
#' @param border.top.style border top style - a single character value, expected
#' value is one of "none", "solid", "dotted", "dashed".
#' @param border.top.width border top width - 0 or positive integer value
#' @param border.right.color border right color - a single character value specifying a
#' valid color (e.g. "#000000" or "black").
#' @param border.right.style border right style - a single character value, expected
#' value is one of "none", "solid", "dotted", "dashed".
#' @param border.right.width border right width - 0 or positive integer value
#' @param vertical.align cell content vertical alignment - a single character value
#' , expected value is one of "center" or "top" or "bottom"
#' @param padding.bottom cell bottom padding - 0 or positive integer value.
#' @param padding.top cell top padding - 0 or positive integer value.
#' @param padding.left cell left padding - 0 or positive integer value.
#' @param padding.right cell right padding - 0 or positive integer value.
#' @param background.color cell background color - a single character value specifying a
#' valid color (e.g. "#000000" or "black").
#' @param text.direction cell text rotation - a single character value, expected
#' value is one of "lrtb", "tbrl", "btlr".
#' @export
#' @details
#' Default values are:
#' \itemize{
#'   \item \code{border.bottom.color} "black"
#'   \item \code{border.bottom.style} "solid"
#'   \item \code{border.bottom.width} 1
#'   \item \code{border.left.color} "black"
#'   \item \code{border.left.style} "solid"
#'   \item \code{border.left.width} 1
#'   \item \code{border.top.color} "black"
#'   \item \code{border.top.style} "solid"
#'   \item \code{border.top.width} 1
#'   \item \code{border.right.color} "black"
#'   \item \code{border.right.style} "solid"
#'   \item \code{border.right.width} 1
#'   \item \code{vertical.align} "middle"
#'   \item \code{padding.bottom} 1
#'   \item \code{padding.top} 1
#'   \item \code{padding.left} 1
#'   \item \code{padding.right} 1
#'   \item \code{background.color} "white"
#'   \item \code{text.direction} "lrtb"
#' }
#' @examples
#' # cellProperties examples -------
#' @example examples/cellProperties.R
#' @seealso \code{\link{borderProperties}}, \code{\link{FlexTable}},
#' \code{\link{shortcut_properties}}
cellProperties = function(
	padding,
	border.width, border.style, border.color,
	border.bottom, border.left, border.top, border.right,
	border.bottom.color = "black", border.bottom.style = "solid", border.bottom.width = 1,
	border.left.color = "black", border.left.style = "solid", border.left.width = 1,
	border.top.color = "black", border.top.style = "solid", border.top.width = 1,
	border.right.color = "black", border.right.style = "solid", border.right.width = 1,
	vertical.align = "middle",
	padding.bottom = 0, padding.top = 0, padding.left = 0, padding.right = 0,
	background.color = "transparent", text.direction = "lrtb"
){
vertical.align.styles = c( "top", "middle", "bottom" )

out = list(
	  border.bottom.color = "black"
	, border.bottom.style = "solid"
	, border.bottom.width = 1
	, border.left.color = "black"
	, border.left.style = "solid"
	, border.left.width = 1
	, border.top.color = "black"
	, border.top.style = "solid"
	, border.top.width = 1
	, border.right.color = "black"
	, border.right.style = "solid"
	, border.right.width = 1
	, vertical.align = "middle"
	, padding.bottom = 1
	, padding.top = 1
	, padding.left = 1
	, padding.right = 1
	, background.color = "#FFFFFF00"
	, text.direction = "lrTb"

)

if( !missing( border.width ) ){
	if( is.numeric( border.width ) ) {
		if( as.integer( border.width ) < 0 || !is.finite( as.integer( border.width ) ) ) stop("invalid border.width : ", border.width )
		border.bottom.width = border.top.width = border.right.width = border.left.width = as.integer( border.width )
	} else {
		stop("border.width must be a integer value >= 0")
	}
}

if( !missing( border.style ) ){
	if( is.character( border.style ) ) {
		border.bottom.style = border.top.style = border.right.style = border.left.style = border.style
	} else {
		stop("border.style must be a character value.")
	}
}

if( !missing( border.color ) ){
	if( is.character( border.color ) ) {
		border.bottom.color = border.top.color = border.right.color = border.left.color = border.color
	} else {
		stop("border.color must be a character value.")
	}
}


if( !missing( padding ) ){
	if( is.numeric( padding ) ) {
		if( as.integer( padding ) < 0 || !is.finite( as.integer( padding ) ) ) stop("invalid padding : ", padding )
		padding.bottom = padding.top = padding.right = padding.left = as.integer( padding )
	} else {
		stop("padding must be a integer value ( >=0 ).")
	}
}

if( is.character( border.bottom.style ) ){
	match.arg( border.bottom.style, choices = ReporteRs.border.styles, several.ok = F )
} else stop("border.bottom.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")

if( is.character( border.left.style ) ){
	match.arg( border.left.style, choices = ReporteRs.border.styles, several.ok = F )
} else stop("border.left.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")

if( is.character( border.top.style ) ){
	match.arg( border.top.style, choices = ReporteRs.border.styles, several.ok = F )
} else stop("border.top.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")

if( is.character( border.right.style ) ){
	match.arg( border.right.style, choices = ReporteRs.border.styles, several.ok = F )
} else stop("border.right.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")



if( is.numeric( border.bottom.width ) ){
	border.bottom.width = as.integer(border.bottom.width)
} else stop("border.bottom.width must be an integer scalar.")

if( is.numeric( border.left.width ) ){
	border.left.width = as.integer(border.left.width)
} else stop("border.left.width must be an integer scalar.")

if( is.numeric( border.top.width ) ){
	border.top.width = as.integer(border.top.width)
} else stop("border.top.width must be an integer scalar.")

if( is.numeric( border.right.width ) ){
	border.right.width = as.integer(border.right.width)
} else stop("border.right.width must be an integer scalar.")



# color checking
if( is.color( border.bottom.color ) ){
	border.bottom.color = getHexColorCode( border.bottom.color )
} else stop("border.bottom.color must be a valid color.")

if( is.color( border.left.color ) ){
	border.left.color = getHexColorCode( border.left.color )
} else stop("border.left.color must be a valid color.")

if( is.color( border.top.color ) ){
	border.top.color = getHexColorCode( border.top.color )
} else stop("border.top.color must be a valid color.")

if( is.color( border.right.color ) ){
	border.right.color = getHexColorCode( border.right.color )
} else stop("border.right.color must be a valid color.")

out$border.top = borderProperties( color = border.top.color, style = border.top.style, width = border.top.width )
out$border.bottom = borderProperties( color = border.bottom.color, style = border.bottom.style, width = border.bottom.width )
out$border.left = borderProperties( color = border.left.color, style = border.left.style, width = border.left.width )
out$border.right = borderProperties( color = border.right.color, style = border.right.style, width = border.right.width )

# background-color checking
if( !is.color( background.color ) )
	stop("background.color must be a valid color." )
else out$background.color = colorProperties(background.color)


match.arg( vertical.align, choices = vertical.align.styles, several.ok = F )
out$vertical.align = vertical.align

if( is.character( text.direction ) ){
	match.arg( text.direction, choices = ReporteRs.text.directions, several.ok = F )
	out$text.direction = text.direction
} else stop("text.direction must be a character scalar (", paste( ReporteRs.text.directions, collapse = "|") ,").")


# padding checking
if( is.numeric( padding.bottom ) ){
	out$padding.bottom = as.integer(padding.bottom)
} else stop("padding.bottom must be an integer scalar.")

if( is.numeric( padding.left ) ){
	out$padding.left = as.integer(padding.left)
} else stop("padding.left must be an integer scalar.")

if( is.numeric( padding.top ) ){
	out$padding.top = as.integer(padding.top)
} else stop("padding.top must be an integer scalar.")

if( is.numeric( padding.right ) ){
	out$padding.right = as.integer(padding.right)
} else stop("padding.right must be an integer scalar.")

if( !missing( border.bottom ) ){
	if( inherits( border.bottom, "borderProperties" ) ) {
		out$border.bottom = border.bottom
	} else {
		stop("border.bottom must be a borderProperties object.")
	}
}

if( !missing( border.top ) ){
	if( inherits( border.top, "borderProperties" ) ) {
		out$border.top = border.top
	} else {
		stop("border.top must be a borderProperties object.")
	}
}

if( !missing( border.left ) ){
	if( inherits( border.left, "borderProperties" ) ) {
		out$border.left = border.left
	} else {
		stop("border.left must be a borderProperties object.")
	}
}

if( !missing( border.right ) ){
	if( inherits( border.right, "borderProperties" ) ) {
		out$border.right = border.right
	} else {
		stop("border.right must be a borderProperties object.")
	}
}


class( out ) = "cellProperties"
out
}

#' @param ... further arguments - not used
#' @param object \code{cellProperties} object to update
#' @details
#' Get a modified version of a \code{cellProperties} with
#' \code{chprop}.
#' @examples
#'
#' # chprop usage example ------
#' @example examples/chprop.cellProperties.R
#' @export
#' @rdname cellProperties
chprop.cellProperties <- function(object
	, border.bottom
	, border.left
	, border.top
	, border.right
	, padding
	, border.bottom.color, border.bottom.style, border.bottom.width
	, border.left.color, border.left.style, border.left.width
	, border.top.color, border.top.style, border.top.width
	, border.right.color, border.right.style, border.right.width
	, vertical.align
	, padding.bottom
	, padding.top
	, padding.left
	, padding.right
	, background.color
	, text.direction
	, ...) {

vertical.align.styles = c( "top", "middle", "bottom" )



	if( !missing( border.bottom.style ) ){
		if( is.character( border.bottom.style ) ){
			match.arg( border.bottom.style, choices = ReporteRs.border.styles, several.ok = F )
			object$border.bottom$style = border.bottom.style
		} else stop("border.bottom.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")
	}

	if( !missing( border.bottom.width ) ){
		if( is.numeric( border.bottom.width ) ){
			object$border.bottom$width = as.integer(border.bottom.width)
		} else stop("border.bottom.width must be an integer scalar.")
	}

	if( !missing( border.bottom.color ) ){
		if( is.color( border.bottom.color ) ){
			object$border.bottom$color = colorProperties( border.bottom.color )
		} else stop("border.bottom.color must be a valid color.")
	}


	if( !missing( border.top.style ) ){
		if( is.character( border.top.style ) ){
			match.arg( border.top.style, choices = ReporteRs.border.styles, several.ok = F )
			object$border.top$style = border.top.style
		} else stop("border.top.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")
	}

	if( !missing( border.top.width ) ){
		if( is.numeric( border.top.width ) ){
			object$border.top$width = as.integer(border.top.width)
		} else stop("border.top.width must be an integer scalar.")
	}

	if( !missing( border.top.color ) ){
		if( is.color( border.top.color ) ){
			object$border.top$color = colorProperties( border.top.color )
		} else stop("border.top.color must be a valid color.")
	}


	if( !missing( border.left.style ) ){
		if( is.character( border.left.style ) ){
			match.arg( border.left.style, choices = ReporteRs.border.styles, several.ok = F )
			object$border.left$style = border.left.style
		} else stop("border.left.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")
	}

	if( !missing( border.left.width ) ){
		if( is.numeric( border.left.width ) ){
			object$border.left$width = as.integer(border.left.width)
		} else stop("border.left.width must be an integer scalar.")
	}

	if( !missing( border.left.color ) ){
		if( is.color( border.left.color ) ){
			object$border.left$color = colorProperties( border.left.color )
		} else stop("border.left.color must be a valid color.")
	}


	if( !missing( border.right.style ) ){
		if( is.character( border.right.style ) ){
			match.arg( border.right.style, choices = ReporteRs.border.styles, several.ok = F )
			object$border.right$style = border.right.style
		} else stop("border.right.style must be a character scalar (", paste( ReporteRs.border.styles, collapse = "|") ,").")
	}

	if( !missing( border.right.width ) ){
		if( is.numeric( border.right.width ) ){
			object$border.right$width = as.integer(border.right.width)
		} else stop("border.right.width must be an integer scalar.")
	}

	if( !missing( border.right.color ) ){
		if( is.color( border.right.color ) ){
			object$border.right$color = colorProperties( border.right.color )
		} else stop("border.right.color must be a valid color.")
	}


	if( !missing( border.bottom ) ){
		if( inherits( border.bottom, "borderProperties" ) ) {
			object$border.bottom = border.bottom
		} else {
			stop("border.bottom must be a borderProperties object.")
		}
	}

	if( !missing( border.top ) ){
		if( inherits( border.top, "borderProperties" ) ) {
			object$border.top = border.top
		} else {
			stop("border.top must be a borderProperties object.")
		}
	}

	if( !missing( border.left ) ){
		if( inherits( border.left, "borderProperties" ) ) {
			object$border.left = border.left
		} else {
			stop("border.left must be a borderProperties object.")
		}
	}

	if( !missing( border.right ) ){
		if( inherits( border.right, "borderProperties" ) ) {
			object$border.right = border.right
		} else {
			stop("border.right must be a borderProperties object.")
		}
	}

	if( !missing( padding ) ){
		if( is.numeric( padding ) ) {
			if( as.integer( padding ) < 0 || !is.finite( as.integer( padding ) ) ) stop("invalid padding : ", padding )
			padding.bottom = padding.top = padding.right = padding.left = as.integer( padding )
		} else {
			stop("padding must be a integer value ( >=0 ).")
		}
	}


	if( !missing( background.color ) )
		# background-color checking
		if( !is.color( background.color ) )
			stop("background.color must be a valid color." )
		else object$background.color = colorProperties(background.color)

	if( !missing( vertical.align ) ){
		match.arg( vertical.align, choices = vertical.align.styles, several.ok = F )
		object$vertical.align = vertical.align
	}

	if( !missing( text.direction ) ){
		if( is.character( text.direction ) ){
			match.arg( text.direction, choices = ReporteRs.text.directions, several.ok = F )
			object$text.direction = text.direction
		} else stop("text.direction must be a character scalar (",
				paste( ReporteRs.text.directions, collapse = "|") ,").")
	}

		# padding checking
	if( !missing( padding.bottom ) )
		if( is.numeric( padding.bottom ) ){
			object$padding.bottom = as.integer(padding.bottom)
		} else stop("padding.bottom must be an integer scalar.")

	if( !missing( padding.left ) )
		if( is.numeric( padding.left ) ){
			object$padding.left = as.integer(padding.left)
		} else stop("padding.left must be an integer scalar.")

	if( !missing( padding.top ) )
		if( is.numeric( padding.top ) ){
			object$padding.top = as.integer(padding.top)
		} else stop("padding.top must be an integer scalar.")

	if( !missing( padding.right ) )
		if( is.numeric( padding.right ) ){
			object$padding.right = as.integer(padding.right)
		} else stop("padding.right must be an integer scalar.")


	object
}

#' @param x \code{cellProperties} object to print
#' @export
#' @rdname cellProperties
print.cellProperties = function (x, ...){
	cat( "cellProperties{border.bottom:", as.character(x$border.bottom), ";" )
	cat( "border.top:", as.character(x$border.top), ";" )
	cat( "border.left:", as.character(x$border.left), ";" )
	cat( "border.right:", as.character(x$border.right), ";\n" )
	cat( "vertical.align: {", x$vertical.align, "}\n" )
	cat( "padding.bottom: {", x$padding.bottom, "}\n" )
	cat( "padding.top: {", x$padding.top, "}\n" )
	cat( "padding.left: {", x$padding.left, "}\n" )
	cat( "padding.right: {", x$padding.right, "}\n" )
	cat( "background.color: {", as.character(x$background.color), "}\n" )
	cat( "text.direction: {", x$text.direction, "}\n" )
}


.jCellProperties = function( robject ){
	jcellProp = .jnew(class.tables.CellProperties
			, .jborderProperties(robject$border.bottom )
			, .jborderProperties(robject$border.left )
			, .jborderProperties(robject$border.top )
			, .jborderProperties(robject$border.right )
			, as.character(robject$vertical.align )
			, as.integer( robject$padding.bottom )
			, as.integer( robject$padding.top )
			, as.integer( robject$padding.left )
			, as.integer( robject$padding.right )
			, .jcolorProperties(robject$background.color)
			, as.character(robject$text.direction )
	)
	jcellProp
}

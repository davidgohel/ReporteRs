#' @title Cell formating properties 
#'
#' @description Create an object that describes cell formating properties. 
#' This objects are used by \code{\link{tableProperties}}.
#' 
#' @param padding cell padding - integer value : 0>= value - overwrite all padding.* values
#' @param border.width border width - an integer value : 0>= value - overwrite all border.*.style values
#' @param border.style border style - a string value : "single" or "none" or "hidden" or "double" or "dotted" or "dashed" or "inset" or "outset" - overwrite all border.*.style values
#' @param border.color border color - a string value (e.g. "#000000" or "black") - overwrite all border.*.color values
#' @param border.bottom.color border bottom color - a string value (e.g. "#000000" or "black")
#' @param border.bottom.style border bottom style - a string value : "single" or "none" or "hidden" or "double" or "dotted" or "dashed" or "inset" or "outset"
#' @param border.bottom.width border bottom width - an integer value : 0>= value
#' @param border.left.color border left color - a string value (e.g. "#000000" or "black")
#' @param border.left.style border left style - a string value : "single" or "none" or "hidden" or "double" or "dotted" or "dashed" or "inset" or "outset"
#' @param border.left.width border left width - an integer value : 0>= value
#' @param border.top.color border top color - a string value (e.g. "#000000" or "black")
#' @param border.top.style border top style - a string value : "single" or "none" or "hidden" or "double" or "dotted" or "dashed" or "inset" or "outset"
#' @param border.top.width border top width - an integer value : 0>= value
#' @param border.right.color border right color - a string value (e.g. "#000000" or "black")
#' @param border.right.style border right style - a string value : "single" or "none" or "hidden" or "double" or "dotted" or "dashed" or "inset" or "outset"
#' @param border.right.width border right width - integer value : 0>= value
#' @param vertical.align cell content vertical alignment - a string value : "center" or "top" or "bottom"
#' @param padding.bottom cell bottom padding - integer value : 0>= value
#' @param padding.top cell top padding - integer value : 0>= value
#' @param padding.left cell left padding - integer value : 0>= value
#' @param padding.right cell right padding - integer value : 0>= value
#' @param background.color cell background color - a string value (e.g. "#000000" or "black")
#' @export
#' @seealso \code{\link{tableProperties}}, \code{\link{textProperties}}
#' , \code{\link{parProperties}}
#' @examples
#' cellProperties( border.color = "gray", border.width = 2 )
#' cellProperties(border.left.width = 0, border.right.width = 0
#'          , border.bottom.width = 2, border.top.width = 0
#'          , padding.bottom = 2, padding.top = 2
#'          , padding.left = 2, padding.right = 2 )
cellProperties = function(border.bottom.color = "black"
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
		, background.color = "white"
		, padding
		, border.width
		, border.style
		, border.color
	){
	border.styles = c( "none", "hidden", "dotted", "dashed", "solid", "double", "groove", "ridge", "inset", "outset" )
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
		, background.color = "#FFFFFF"
		
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
		match.arg( border.bottom.style, choices = border.styles, several.ok = F )
		out$border.bottom.style = border.bottom.style
	} else stop("border.bottom.style must be a character scalar (", paste( border.styles, collapse = "|") ,").")
	
	if( is.character( border.left.style ) ){
		match.arg( border.left.style, choices = border.styles, several.ok = F )
		out$border.left.style = border.left.style
	} else stop("border.left.style must be a character scalar (", paste( border.styles, collapse = "|") ,").")
	
	if( is.character( border.top.style ) ){
		match.arg( border.top.style, choices = border.styles, several.ok = F )
		out$border.top.style = border.top.style
	} else stop("border.top.style must be a character scalar (", paste( border.styles, collapse = "|") ,").")
	
	if( is.character( border.right.style ) ){
		match.arg( border.right.style, choices = border.styles, several.ok = F )
		out$border.right.style = border.right.style
	} else stop("border.right.style must be a character scalar (", paste( border.styles, collapse = "|") ,").")
	
	

	if( is.numeric( border.bottom.width ) ){
		out$border.bottom.width = as.integer(border.bottom.width)
	} else stop("border.bottom.width must be an integer scalar.")
	
	if( is.numeric( border.left.width ) ){
		out$border.left.width = as.integer(border.left.width)
	} else stop("border.left.width must be an integer scalar.")
	
	if( is.numeric( border.top.width ) ){
		out$border.top.width = as.integer(border.top.width)
	} else stop("border.top.width must be an integer scalar.")
	
	if( is.numeric( border.right.width ) ){
		out$border.right.width = as.integer(border.right.width)
	} else stop("border.right.width must be an integer scalar.")
	
	
	
	# color checking
	if( is.color( border.bottom.color ) ){
		out$border.bottom.color = getHexColorCode( border.bottom.color )
	} else stop("border.bottom.color must be a valid color.")
	
	if( is.color( border.left.color ) ){
		out$border.left.color = getHexColorCode( border.left.color )
	} else stop("border.left.color must be a valid color.")
	
	if( is.color( border.top.color ) ){
		out$border.top.color = getHexColorCode( border.top.color )
	} else stop("border.top.color must be a valid color.")
	
	if( is.color( border.right.color ) ){
		out$border.right.color = getHexColorCode( border.right.color )
	} else stop("border.right.color must be a valid color.")

	# background-color checking
	if( !is.color( background.color ) )
		stop("background.color must be a valid color." )
	else out$background.color = getHexColorCode(background.color)
	

	match.arg( vertical.align, choices = vertical.align.styles, several.ok = F )
	out$vertical.align = vertical.align
	
	
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
	
	
	class( out ) = "cellProperties"
	out
}


#' @method print cellProperties
#' @S3method print cellProperties
print.cellProperties = function (x, ...){
	cat( "\tborder-bottom-color: {", x$border.bottom.color, "}\n" )
	cat( "\tborder-bottom-style: {", x$border.bottom.style, "}\n" )
	cat( "\tborder-bottom-width: {", x$border.bottom.width, "}\n" )
	cat( "\tborder-left-color: {", x$border.left.color, "}\n" )
	cat( "\tborder-left-style: {", x$border.left.style, "}\n" )
	cat( "\tborder-left-width: {", x$border.left.width, "}\n" )
	cat( "\tborder-top-color: {", x$border.top.color, "}\n" )
	cat( "\tborder-top-style: {", x$border.top.style, "}\n" )
	cat( "\tborder-top-width: {", x$border.top.width, "}\n" )
	cat( "\tborder-right-color: {", x$border.right.color, "}\n" )
	cat( "\tborder-right-style: {", x$border.right.style, "}\n" )
	cat( "\tborder-right-width: {", x$border.right.width, "}\n" )
	cat( "\tvertical-align: {", x$vertical.align, "}\n" )
	cat( "\tpadding-bottom: {", x$padding.bottom, "}\n" )
	cat( "\tpadding-top: {", x$padding.top, "}\n" )
	cat( "\tpadding-left: {", x$padding.left, "}\n" )
	cat( "\tpadding-right: {", x$padding.right, "}\n" )
	cat( "\tbackground-color: {", x$background.color, "}\n" )
}
borderProperties = function( borderColor, borderStyle, borderWidth ){
	rJava::.jnew(class.tables.BorderProperties
		, as.character(borderColor), as.character(borderStyle)
		, as.integer( borderWidth )
	)
}


.jCellProperties = function( robject ){
	
	
	jcellProp = rJava::.jnew(class.tables.CellProperties
			, borderProperties(robject$border.bottom.color, robject$border.bottom.style, robject$border.bottom.width )
			, borderProperties(robject$border.left.color, robject$border.left.style, robject$border.left.width )
			, borderProperties(robject$border.top.color, robject$border.top.style, robject$border.top.width )
			, borderProperties(robject$border.right.color, robject$border.right.style, robject$border.right.width )
			, as.character(robject$vertical.align )
			, as.integer( robject$padding.bottom )
			, as.integer( robject$padding.top )
			, as.integer( robject$padding.left )
			, as.integer( robject$padding.right )
			, as.character(robject$background.color )
	)
	jcellProp
}

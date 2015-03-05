#' @title Create a bootstrap DropDownMenu
#'
#' @description
#' Create a \code{DropDownMenu} object. This object is to be used with 
#' \code{\link{BootstrapMenu}} to define menu links.
#' 
#' @param title \code{"character"} value: label of the title.
#' @param link url to use as link associated with the title.
#' @param bg.active.color active background color - a single character value specifying 
#' a valid color (e.g. "#000000" or "black").
#' @param bg.color background color - a single character value specifying 
#' a valid color (e.g. "#000000" or "black").
#' @param text.emphasis.color text emphasis color - a single character value specifying 
#' a valid color (e.g. "#000000" or "black").
#' @param text.color text color - a single character value specifying 
#' a valid color (e.g. "#000000" or "black").
#' @return an object of class \code{BootstrapMenu}.
#' @export
#' @examples
#' #
#' @example examples/BootstrapMenu.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addBootstrapMenu}}
BootstrapMenu = function( title, link = "#", bg.active.color = "#34495E", 
		bg.color = "#2C3E50", text.emphasis.color = "white", text.color = "#ecf0f1" 
	) {
	
	if( !is.character( title ) ) stop("title must be a string value.")
	if( length( title ) != 1 ) stop("length of title is not 1.")
	
	if( !is.color( bg.active.color ) )
		stop("bg.active.color must be a valid color." )
	else bg.active.color = getHexColorCode( bg.active.color )
	
	if( !is.color( bg.color ) )
		stop("bg.color must be a valid color." )
	else bg.color = getHexColorCode( bg.color )
	
	if( !is.color( text.emphasis.color ) )
		stop("text.emphasis.color must be a valid color." )
	else text.emphasis.color = getHexColorCode( text.emphasis.color )
	
	if( !is.color( text.color ) )
		stop("text.color must be a valid color." )
	else text.color = getHexColorCode( text.color )
	
	out = list( jobj = .jnew( class.BootstrapMenu, title, link, bg.active.color,
			bg.color, text.emphasis.color, text.color), title = title )
	class( out ) = "BootstrapMenu"
	
	out
}


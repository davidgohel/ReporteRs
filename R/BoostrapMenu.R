#' @title Create a bootstrap DropDownMenu
#'
#' @description
#' Create a \code{DropDownMenu} object. This object is to be used with 
#' \code{\link{BoostrapMenu}} to define menu links.
#' 
#' @param title \code{"character"} value: label of the title.
#' @return an object of class \code{BoostrapMenu}.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/BoostrapMenu.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addBootstrapMenu}}
BoostrapMenu = function( title ) {
	
	if( !is.character( title ) ) stop("title must be a string value.")
	if( length( title ) != 1 ) stop("length of title is not 1.")
	
	out = list( jobj = .jnew( class.BoostrapMenu, title ), title = title )
	class( out ) = "BoostrapMenu"
	
	out
}


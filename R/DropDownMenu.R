#' @title Create a bootstrap DropDownMenu
#'
#' @description
#' Create a \code{DropDownMenu} object. This object is to be used with 
#' \code{\link{BootstrapMenu}} to define menu links.
#' 
#' @param label \code{"character"} value: label of the DropDownMenu.
#' @return an object of class \code{DropDownMenu}.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/DropDownMenu.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}
DropDownMenu = function( label ) {
	out = list()
	out$jobj = .jnew( class.DropDown, label )
	class( out ) = "DropDownMenu"
	out
}

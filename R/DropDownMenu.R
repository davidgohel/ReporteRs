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
#' #
#' @example examples/DropDownMenu.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addLinkItem}}, \code{\link{addBootstrapMenu}}
DropDownMenu = function( label ) {
	out = list()
	out$jobj = .jnew( class.DropDown, label )
	class( out ) = "DropDownMenu"
	out
}
#' @export
print.DropDownMenu = function(x, ...){
	cat("DropDownMenu object")
	invisible()
}

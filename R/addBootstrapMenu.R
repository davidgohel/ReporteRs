#' @title add a \code{BootstrapMenu} into a \code{bsdoc} object.
#'
#' @description
#' add a \code{BootstrapMenu} into a \code{bsdoc} object.
#'
#' @param doc a \code{bsdoc} object.
#' @param bsmenu the \code{BootstrapMenu} to add into the \code{bsdoc}.
#' @return an object of class \code{BootstrapMenu}.
#' @export
#' @examples
#'
#' @example examples/addBootstrapMenu.R
#' @seealso \code{\link{bsdoc}}, \code{\link{BootstrapMenu}}
addBootstrapMenu = function( doc, bsmenu ){

	if( !inherits( doc , "bsdoc") ){
		stop("doc is not a bsdoc object.")
	}

	if( !inherits( bsmenu , "BootstrapMenu") ){
		stop("bsmenu is not a BootstrapMenu object.")
	}

	.jcall( doc$jobj, "V", "addBootstrapMenu" , bsmenu$jobj )
	doc
}


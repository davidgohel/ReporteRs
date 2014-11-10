#' @title add a \code{BootstrapMenu} into a \code{bsdoc} object.
#'
#' @description
#' add a \code{BootstrapMenu} into a \code{bsdoc} object.
#' 
#' @param doc a \code{bsdoc} object.
#' @param bsmenu the \code{BootstrapMenu} to add into the \code{bsdoc}.
#' @return an object of class \code{BoostrapMenu}.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/addBootstrapMenu.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addBootstrapMenu}}
addBootstrapMenu = function( doc, bsmenu ){
	
	if( !inherits( doc , "bsdoc") ){
		stop("doc is not a bsdoc object.")
	}
	
	if( !inherits( bsmenu , "BoostrapMenu") ){
		stop("bsmenu is not a BoostrapMenu object.")
	}
	
	.jcall( doc$jobj, "V", "addBootstrapMenu" , bsmenu$jobj )
	doc
}


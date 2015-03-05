#' @title get HTML code from a FlexTable
#'
#' @description get HTML code from a FlexTable
#' 
#' @param object the \code{FlexTable} object
#' @param ... further arguments passed to other methods 
#' @return a character value
#' @seealso \code{\link{FlexTable}}
#' @examples
#' #
#' @example examples/FlexTableExample.R
#' @example examples/as.html.MyFTable.R
#' @export
as.html.FlexTable = function( object, ... ) {
		
	.jcall( object$jobj, "S", "getHTML" )

}


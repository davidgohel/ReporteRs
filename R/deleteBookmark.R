#' @title delete a bookmark into a docx object
#'
#' @description delete a bookmark into a docx object
#' 
#' @param doc Object of class \code{\link{docx}}
#' @param bookmark a character vector specifying bookmark id to delete
#' @export
#' @seealso \code{\link{docx}}
deleteBookmark = function( doc, bookmark ){
	
	if( !inherits( doc, c("docx" ) ) )
		stop("doc is not a docx object.")

	if( missing( bookmark ) ) stop("bookmark is missing")

	if( !is.character( bookmark ) )
		stop( "bookmark must be a single character value")
	
	if( length(bookmark) != 1 ){
		stop( "bookmark must be a single character value")
	}
	
	.jcall( doc$obj, "V", "deleteBookmark", bookmark )
	doc
}



#' @title delete first content after a bookmark into a docx object
#'
#' @description delete first content after a bookmark into a docx object
#' 
#' @param doc Object of class \code{\link{docx}}
#' @param bookmark a character vector specifying bookmark id to delete
#' @export
#' @seealso \code{\link{docx}}
deleteBookmarkNextContent = function( doc, bookmark ){
	
	if( !inherits( doc, c("docx" ) ) )
		stop("doc is not a docx object.")
	
	if( missing( bookmark ) ) stop("bookmark is missing")
	
	if( !is.character( bookmark ) )
		stop( "bookmark must be a single character value")
	
	if( length(bookmark) != 1 ){
		stop( "bookmark must be a single character value")
	}
	
	.jcall( doc$obj, "V", "deleteBookmarkNextContent", bookmark )
	doc
}

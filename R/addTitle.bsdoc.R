#' @title Insert a title into a bsdoc object
#'
#' @description Add a title into a \code{\link{bsdoc}} object.
#' 
#' @param doc \code{\link{bsdoc}} object
#' @param value \code{"character"} value to use as title text
#' @param level \code{"integer"} positive value to use as 
#' heading level. 1 for title1, 2 for title2, etc. Default to 1.
#' @param ... further arguments, not used. 
#' @return an object of class \code{bsdoc}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addTitle_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTitle1Level1.R
#' @example examples/addTitle2Level1.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addTitle}}
#' @method addTitle bsdoc
#' @S3method addTitle bsdoc
addTitle.bsdoc = function( doc, value, level = 1, ... ) {

	if( !is.numeric( level ) )
		stop("level must be an integer vector of length 1.")
	if( length( level ) != 1 )
		stop("level must be an integer vector of length 1.")
	if( is.character( value ) )
		jtitle = .jnew(class.html4r.Title, as.character(value), as.integer(level)  )
	else jtitle = .jnew(class.html4r.Title, .jpot(value), as.integer(level)  )
	out = .jcall( doc$jobj , "I", "add", jtitle )
	if( out != 1 ){
		stop( "Problem while trying to add title." )
	}
	doc
}



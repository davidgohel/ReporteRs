#' @title Insert a table of contents into a docx object
#'
#' @description Insert a table of contents into a \code{\link{docx}} object.
#'
#' @param doc Object of class \code{\link{docx}} where table of content has to be added
#' @param stylename optional. Stylename in the document that will be used to build entries of the TOC.
#' @param level_max max title level to show in the TOC (defaut to 3, from title1 to title3).
#' @param ... further arguments, not used.
#' @details
#' If stylename is not used, a classical table of content will be produced.\cr
#' If stylename is used, a custom table of contents will be produced,
#' pointing to entries that have been formated with \code{stylename}.
#' For example, this can be used to produce a toc with only plots.
#'
#'
#' @return an object of class \code{\link{docx}}.
#' @examples
#' #START_TAG_TEST
#' @example examples/addTOC.docx1.R
#' @example examples/addTOC.docx2.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addTitle.docx}}
#' , \code{\link{styles.docx}}, \code{\link{addParagraph.docx}}
#' @export
addTOC.docx = function(doc, stylename, level_max = 3, ... ) {

	if( missing( stylename ) ){
	  if( level_max > 9 )
	    stop("level_max can not be greater than 9")
	  if( level_max < 1 )
	    stop("level_max can not be less than 1")
	  jobject = .jnew(class.TOC, as.integer(level_max) )
		.jcall( doc$obj, "V", "add", jobject )
	} else {
		if( !is.element( stylename , styles( doc ) ) )
			stop(paste("Style {", stylename, "} does not exists.", sep = "") )
		else {
			sep = .jcall( doc$obj, "S", "getListSeparator" )
			jobject = .jnew(class.TOC , stylename, sep )
			.jcall( doc$obj, "V", "add", jobject )
		}
	}
	doc
	}


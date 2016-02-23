#' @title Add a table of contents into a document object
#'
#' @description Add a table of contents into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{bsdoc}}, \code{\link{styles}},
#' \code{\link{addTitle}}, \code{\link{addParagraph}}
addTOC = function(doc, ...){
  UseMethod("addTOC")
}

#' @param stylename optional. Stylename in the document that will be used to build entries of the TOC.
#' @param level_max max title level to show in the TOC (defaut to 3, from title1 to title3).
#' @details
#'
#' When working with \code{docx} object:
#'
#' If stylename is not used, a classical table of content will be produced.\cr
#' If stylename is used, a custom table of contents will be produced,
#' pointing to entries that have been formated with \code{stylename}.
#' For example, this can be used to produce a toc with only plots.
#' @examples
#'
#' @example examples/addTOC.docx1.R
#' @example examples/addTOC.docx2.R
#' @rdname addTOC
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



#' @details
#'
#' When working with \code{bsdoc} object:
#'
#' Table of contents will be added on the right side
#' of the content.
#' @examples
#' doc.filename = "addTOC_example/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTOC.bsdoc.R
#' @example examples/writeDoc_file.R
#' @rdname addTOC
#' @export
addTOC.bsdoc = function(doc, ... ) {

  .jcall( doc$jobj, "V", "addTOC" )

  doc
}

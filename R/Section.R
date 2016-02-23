#' @title Add a section into a document object
#'
#' @description Add a section into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}
addSection = function(doc, ...){
  UseMethod("addSection")
}


#' @details
#' \code{addSection} only works with docx documents.
#'
#' It lets you change document orientation and split new
#' content along 2 or more columns.
#' The function requires you to add a section before and after
#' the item(s) that  you want to be on a landscape and/or
#' multicolumns mode page.
#' @param landscape logical value. Specify TRUE to get a section with horizontal page.
#' @param ncol \code{integer} number to specify how many columns the section should contains.
#' @param space_between width in inches of the space between columns of the section.
#' @param columns.only logical value, if set to TRUE, no break page will (continuous section).
#' @examples
#' doc.filename = "addSection.docx"
#' @example examples/docx.R
#' @example examples/addSection_example1.R
#' @example examples/writeDoc_file.R
#' @rdname addSection
#' @export
addSection.docx = function(doc, landscape = FALSE, ncol = 1, space_between = 0.3, columns.only = FALSE , ...) {
	.jcall( doc$obj, "V", "startSection", as.logical( landscape ),
			as.integer( ncol ), as.integer( space_between*1440 ),
			as.logical( !columns.only ))
	doc
}



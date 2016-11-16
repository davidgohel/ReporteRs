#' @title Insert a footer into a document object
#'
#' @description Insert a footer into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' addFooter only works for pptx documents.
#' @export
#' @seealso \code{\link{pptx}}
addFooter <- function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addFooter")
}



#' @title Insert a page number into a document object
#'
#' @description Insert a page number into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' \code{addPageNumber} only works with pptx documents.
#'
#' See \code{\link{addPageNumber.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addPageNumber.pptx}}
addPageNumber <- function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addPageNumber")
}



#' @title Add a subtitle shape into a document object
#'
#' @description Add a subtitle shape into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' \code{addSubtitle} only works with pptx documents. See \code{\link{addSubtitle.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addSubtitle.pptx}}
addSubtitle <- function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addSubtitle")
}



#' @title Set TOC options for a document object
#'
#' @description Set custom table of contents options for a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' \code{toc.options} only works with docx documents.
#'
#' See \code{\link{toc.options.docx}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTOC.docx}}
toc.options <- function(doc, ...){
	UseMethod("toc.options")
}

#' @title Change a formatting properties object
#'
#' @description Change a formatting properties object
#'
#' @param object formatting properties object
#' @param ... further arguments passed to other methods
#' @return a formatting properties object
#' @details
#' See \code{\link{chprop.textProperties}} or \code{\link{chprop.parProperties}}
#' or \code{\link{chprop.cellProperties}} for examples.
#' @export
#' @seealso \code{\link{cellProperties}}, \code{\link{textProperties}}
#' , \code{\link{parProperties}}
chprop <- function( object, ... ){
	UseMethod("chprop")
}

#' @title get HTML code
#'
#' @description Get HTML code in a character vector.
#'
#' @param object object to get HTML from
#' @param ... further arguments passed to other methods
#' @return a character value
#' @details
#' See \code{\link{FlexTable}} for examples.
#' @export
#' @seealso \code{\link{FlexTable}}
as.html <- function( object, ... ){
	UseMethod("as.html")
}

#' @title R tables as FlexTables
#'
#' @description Get a \code{\link{FlexTable}} object from
#' an R object.
#'
#' @param x object to get \code{FlexTable} from
#' @param ... further arguments passed to other methods
#' @return a \code{\link{FlexTable}} object
#' @export
#' @seealso \code{\link{FlexTable}}
as.FlexTable <- function( x, ... ){
	UseMethod("as.FlexTable")
}


#' @title Get layout names of a document object
#'
#' @description Get layout names that exist into a document
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @details
#' \code{slide.layouts} only works with pptx documents. See \code{\link{slide.layouts.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{slide.layouts.pptx}}, \code{\link{addSlide.pptx}}
slide.layouts <- function(doc, ...){
	UseMethod("slide.layouts")
}


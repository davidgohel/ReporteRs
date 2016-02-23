#' @title Get styles names of a document object
#'
#' @description Get styles names that exist into a document
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @export
#' @seealso \code{\link{docx}}, \code{\link{styles}}
styles = function(doc, ...){
  UseMethod("styles")
}



#' @details With \code{docx} document, styles will be paragraph styles
#' of the base document (e.g. Normal, Title1, etc.).
#' Names of the returned character vector are labels associated with styles names.
#' @examples
#' doc = docx( title = "title" )
#' styles(doc)
#' @rdname styles
#' @export
styles.docx = function( doc, ... ) {
  .names = .jcall( doc$obj, "[S", "getStyleNames" )
  .l = length(.names) / 2

  if( .l < 1 ) return(character(0))

  out = .names[1:.l]
  names( out ) = .names[(.l+1):length(.names)]
  out
  }



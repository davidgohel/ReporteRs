#' @title Get styles names of a docx document 
#'
#' @description Get styles names that exist into the template (base document).
#' 
#' @param doc Object of class \code{docx} to extract style names from.
#' @param ... further arguments, not used. 
#' @details Available styles will be paragraph styles of the base document (e.g. Normal, Title1, etc.).
#' Names of the returned character vector are labels associated with styles names.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = docx( title = "title" )
#' styles(doc) #returns available paragraph styles in a character vector
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{styles}}
#' @method styles docx
#' @S3method styles docx

styles.docx = function( doc, ... ) {
  .names = .jcall( doc$obj, "[S", "getStyleNames" )
  .l = length(.names) / 2
  
  if( .l < 1 ) return(character(0))
  
  out = .names[1:.l]
  names( out ) = .names[(.l+1):length(.names)]
  out
  }



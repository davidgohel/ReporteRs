#' @title Add a title
#'
#' @description Add a title into a document object
#'
#' @param doc document object
#' @param value \code{"character"} value to use as title text
#' @param ... further arguments passed to or from other methods..
#' @return a document object
#' @export
addTitle = function(doc, value, ...){
  checkHasSlide(doc)

  if( missing( value ) ) stop("value is missing.")
  if( !is.character( value ) && !inherits( value, "pot" ) )
    stop("value must be a character vector of length 1 or a pot object.")
  if( is.character( value ) && length( value ) != 1 )
    stop("value must be a character vector of length 1 or a pot object.")

  UseMethod("addTitle")
}

#' @param level \code{"integer"} positive value to use as
#' heading level. 1 for title1, 2 for title2, etc. Default to 1.
#' @details
#'
#' Function addTitle when used with docx object needs to know which
#' style correspond to which title level (1 ; 1.1 ; 1.1.1 ; etc.).
#' When a template is read, ReporteRs tries to guess what are the available
#' styles (english, french, chinese, etc.). If styles for titles has not
#' been detected you will see the following error when addTitle is being called:
#'
#' \code{You must defined title styles via map_title first.}
#'
#' As the error message points out, you have to call the function `map_title` to
#' indicate which available styles are meant to be used as title styles.
#'
#' @examples
#'
#' # Title example for MS Word -------
#' \donttest{
#' doc.filename = "ex_add_title.docx"
#' doc <- docx()
#' doc <- addTitle( doc, "Title example 1", level = 1 )
#' doc <- addTitle( doc, "Title example 2", level = 1 )
#' writeDoc( doc, file = doc.filename )
#' }
#' @rdname addTitle
#' @seealso \code{\link{map_title}}
#' @export
addTitle.docx = function( doc, value, level = 1, ... ) {
  if( length( doc$header.styles ) == 0 ){
    stop("You must defined title styles via map_title first.")
  }
  if( length( doc$header.styles ) < level ){
    stop("level = ", level, ". You defined only ", length( doc$header.styles ), " styles.")
  }
  if( !is.numeric( level ) )
    stop("level must be an integer vector of length 1.")
  if( length( level ) != 1 )
    stop("level must be an integer vector of length 1.")

  doc = addParagraph(doc = doc, value, stylename = doc$header.styles[level] );
  doc
}


#' @details
#'
#' To add a title into a pptx object you
#' only have to specify the text to use as title. There is no level concept.
#'
#' @examples
#' \donttest{
#' # Title example for PowerPoint -------
#' doc.filename = "ex_add_title.pptx"
#' doc <- pptx()
#' doc <- addSlide(doc, "Title and Content")
#' doc <- addTitle(doc, "Title example")
#' writeDoc( doc, file = doc.filename )
#' }
#' @rdname addTitle
#' @export
addTitle.pptx = function( doc, value, ... ) {

  slide = doc$current_slide
  out = .jcall( slide, "I", "addTitle", value )
  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "title(or crttitle)") )
  }
  doc
}


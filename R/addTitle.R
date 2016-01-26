#' @title Add a title into a document object
#'
#' @description Add a title into a document object
#'
#' @param doc document object
#' @param value \code{"character"} value to use as title text
#' @param ... further arguments passed to or from other methods..
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{pptx}}, \code{\link{bsdoc}}
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
#' In MS Word, you can use whatever style you want as title formatting style.
#' But to be considered as entries for a Table of Content, used styles must be 'title' styles.
#' Theses are always available in MS Word list styles.
#' When template is read, ReporteRs try to guess what are theses styles.
#'
#' @examples
#'
#' # Title example for MS Word -------
#' doc.filename = "ex_add_title.docx"
#' @example examples/docx.R
#' @example examples/addTitle1Level1.R
#' @example examples/addTitle2Level1.R
#' @example examples/writeDoc_file.R
#' @rdname addTitle
#' @export
addTitle.docx = function( doc, value, level = 1, ... ) {
  if( length( doc$header.styles ) == 0 ){
    stop("You must defined title styles via declareTitlesStyles first.")
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
#' In MS PowerPoint, level can not be used as there is no associated
#' level with a title in a slide.
#'
#' @examples
#'
#' # Title example for PowerPoint -------
#' doc.filename = "ex_add_title.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/writeDoc_file.R
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



#' @param id \code{character} single and unique value to use as
#' title id when doc is \code{bsdoc}.
#' @examples
#'
#' # Title example for bsdoc -------
#' doc.filename = "ex_add_title/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTitle1Level1.R
#' @example examples/addTitle2Level1.R
#' @example examples/writeDoc_file.R
#' @rdname addTitle
#' @export
addTitle.bsdoc = function( doc, value, level = 1, id, ... ) {

	if( !is.numeric( level ) )
		stop("level must be an integer vector of length 1.")
	if( length( level ) != 1 )
		stop("level must be an integer vector of length 1.")

	if( !missing( id ) ){
		if( !inherits( id, "character" ) )
			stop("id must be a single character value")
		if( length( id ) != 1 )
			stop("id must be a single character value")
	}
	if( !missing( id ) ){
		if( is.character( value ) )
			jtitle = .jnew(class.html4r.Title, as.character(value), as.integer(level), id )
		else jtitle = .jnew(class.html4r.Title, .jpot(value), as.integer(level), id )
	} else {
		if( is.character( value ) )
			jtitle = .jnew(class.html4r.Title, as.character(value), as.integer(level)  )
		else jtitle = .jnew(class.html4r.Title, .jpot(value), as.integer(level)  )
	}
	out = .jcall( doc$jobj , "I", "add", jtitle )
	if( out != 1 ){
		stop( "Problem while trying to add title." )
	}
	doc
}



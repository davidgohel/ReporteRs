#' @title Add a paragraph into a document object
#'
#' @description Add a paragraph into a document object
#'
#' @details a paragraph is a set of text that ends with an end of line.
#' Read \code{\link{pot}} to see how to get different font formats.
#' If an end of line is required, a new paragraph is required.
#' @param doc document object
#' @param value text to add to the document as paragraphs:
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}}
#' or a character vector.
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @examples
#' # define some text
#' sometext <- c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
#'   "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor.",
#'   "Quisque dictum tristique ligula.")
#'
#' # "My tailor is rich" with formatting on some words
#' pot1 <- pot("My tailor", textProperties(color = "red" ) ) +
#'   " is " + pot("rich", textProperties(shading.color = "red",
#'      font.weight = "bold" ) )
#'
#' # "Cats and dogs" with formatting on some words
#' pot2 = pot("Cats", textProperties(color = "red" ) ) +
#'   " and " +
#'   pot("dogs", textProperties( color = "blue" ),
#'       hyperlink = "http://www.wikipedia.org/" )
#'
#' # create a set of paragraphs made of pot1 and pot2
#' my.pars <- set_of_paragraphs( pot1, pot2 )
#'
#' @seealso \code{\link{docx}}, \code{\link{pptx}},
#' \code{\link{pot}}, \code{\link{textProperties}},
#' \code{\link{parProperties}}, \code{\link{list.settings}}
addParagraph <- function(doc, value, ...){
  checkHasSlide(doc)
  if( !inherits( value, c("set_of_paragraphs", "character", "pot") ) )
    stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
  if( length(value) < 1 ){
    warning("value is empty.")
    return( doc )
  }

  UseMethod("addParagraph")
}


#' @param stylename value of the named style to apply to paragraphs in the docx document.
#' Expected value is an existing stylename of the template document used to create the
#' \code{docx} object. This argument can only be used when value is a
#' character vector. see \code{\link{styles.docx}}.
#' @param bookmark a character value ; id of the Word bookmark to
#' replace by the table. optional.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs. When used in Word
#' documents, it will only be used if \code{stylename} if missing. When used in PowerPoint
#' documents, it will be used if \code{offx} or \code{offy} is used.
#' @param restart.numbering boolean value. If \code{TRUE}, next numbered
#' list counter will be set to 1.
#' @examples
#' # docx example ---------
#' \donttest{
#' doc.filename = "ex_paragraph.docx"
#' doc <- docx()
#' styles(doc)
#'
#' doc <- addTitle( doc, "Title example 1", level = 1 )
#' # Add "Hello World" into the document doc
#' doc <- addParagraph(doc, "Hello Word", stylename = "Normal" )
#'
#' doc <- addTitle( doc, "Title example 2", level = 1 )
#'
#' # add sometext with stylename BulletList
#' doc <- addParagraph( doc, value = sometext, stylename="BulletList" )
#'
#' doc <- addTitle( doc, "Title example 3", level = 1 )
#'
#' doc <- addParagraph( doc, value = my.pars, par.properties = parCenter() )
#'
#' writeDoc( doc, file = doc.filename )
#' }
#' @rdname addParagraph
#' @export
addParagraph.docx <- function(doc, value, stylename, bookmark,
		par.properties = parProperties(),
		restart.numbering = FALSE, ... ) {

  if( missing( value ) ){
    stop("argument value is missing." )
  }

	if( !missing(stylename) && inherits(value, "character") ){
	  if(!is.element( stylename , styles( doc ) ))
		  stop(paste("Style {", stylename, "} does not exists.", sep = ""), call. = FALSE )

	  if( missing( bookmark ) ){
	    .jcall( doc$obj, "V", "addWithStyle" , .jarray(value), stylename)
	  } else{
	    .jcall( doc$obj, "V", "addWithStyle", .jarray(value), stylename, bookmark )
	  }
    return(doc)
	}

	if( inherits( value, "character" ) ){
		value = gsub("\\r", "", value )
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}

	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}

	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")

	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}

	parset = .jset_of_paragraphs(value, par.properties)
	if( restart.numbering ){
		.jcall( doc$obj, "V", "restartNumbering" )
	}
	.jcall( parset, "V", "setDOCXReference", doc$obj )

	if( missing( bookmark ) ){
		.jcall( doc$obj, "V", "add" , parset )
	} else {
		.jcall( doc$obj, "V", "add" , parset, bookmark )
	}

	doc
}



#' @param offx optional, x position of the shape (top left position of the bounding box)
#' in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box)
#' in inches. See details.
#' @param width optional, width of the shape in inches. See details.
#' @param height optional, height of the shape in inches. See details.
#' @param append boolean default to FALSE. If TRUE, paragraphs will be
#' appened in the current shape instead of beeing sent into a new shape.
#' Paragraphs can only be appended on shape containing paragraphs (i.e. you
#' can not add paragraphs after a FlexTable). Applies to only \code{pptx} objects.
#' @details
#'
#' When document is a \code{pptx} object, two positioning methods are available.
#'
#' If arguments offx, offy, width, height are missing, position and dimensions
#' will be defined by the width and height of the next available shape of the slide. This
#' dimensions can be defined in the layout of the PowerPoint template used to create
#' the \code{pptx} object.
#'
#' If arguments offx, offy, width, height are provided, they become position and
#' dimensions of the new shape.
#'
#' Also, when document is a \code{pptx} object,
#' shading and border settings of argument \code{par.properties}
#' will have no effect.
#'
#' Argument par.properties is only used when value is a \code{pot} or a \code{set_of_paragraphs}.
#'
#' If character values are used to fill slides, parameter \code{append}
#' will be ignored.
#' @examples
#' \donttest{
#' # pptx example -------
#' doc.filename = "ex_paragraph.pptx"
#' doc <- pptx()
#' doc <- addSlide(doc, "Title and Content")
#' # Add "Hello World" into the document doc
#' doc <- addParagraph(doc, "Hello Word" )
#'
#' doc <- addSlide(doc, "Title and Content")
#' doc <- addParagraph( doc, value = my.pars )
#' # Add my.pars into the document doc
#' doc <- addParagraph(doc, my.pars, offx = 3, offy = 3,
#'   width = 2, height = 0.5,
#'   par.properties=parProperties(text.align="center", padding=0) )

#' doc <- addSlide(doc, "Title and Content")
#' # Add my.pars into the document doc
#' doc <- addParagraph(doc, my.pars,
#'   par.properties=parProperties(text.align="center", padding=24) )
#'
#' writeDoc( doc, file = doc.filename )
#' }
#' @rdname addParagraph
#' @export
addParagraph.pptx <- function(doc, value, offx, offy, width, height,
                             par.properties,
                             append = FALSE,
                             restart.numbering = FALSE, ... ) {

  check.dims <- sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
  if( check.dims > 0 && check.dims < 4 ) {
    if( missing( offx ) ) warning("arguments offx, offy, width and height must all be specified: offx is missing")
    if( missing( offy ) ) warning("arguments offx, offy, width and height must all be specified: offy is missing")
    if( missing( width ) ) warning("arguments offx, offy, width and height must all be specified: width is missing")
    if( missing( height ) ) warning("arguments offx, offy, width and height must all be specified: height is missing")
  }
  if( check.dims > 3 ) {
    if( !is.numeric( offx ) ) stop("arguments offx must be a numeric value")
    if( !is.numeric( offy ) ) stop("arguments offy must be a numeric value")
    if( !is.numeric( width ) ) stop("arguments width must be a numeric value")
    if( !is.numeric( height ) ) stop("arguments height must be a numeric value")

    if( length( offx ) != length( offy )
        || length( offx ) != length( width )
        || length( offx ) != length( height ) || length( offx )!= 1 ){
      stop("arguments offx, offy, width and height must be numeric of length 1")
    }
  }


  if( inherits( value, "pot" ) ){
    value = set_of_paragraphs( value )
  }
  valid_class <- any( c("set_of_paragraphs", "character") %in% class(value) )
  if( !valid_class )
    stop("value must be an object of class pot, set_of_paragraphs or a character vector.")

  slide = doc$current_slide

  if( is.character( value ) && !append ){
    out = .jcall( slide, "I", "add" , .jarray(value) )
  } else if(is.character( value ) && append) {
    out = .jcall( slide, "I", "append" , .jarray(value) )
  } else {
    if( !missing(par.properties) && !inherits( par.properties, "parProperties" ) ){
      stop("argument 'par.properties' must be an object of class 'parProperties'")
    }

    if( !missing(par.properties) )
      parset = .jset_of_paragraphs(value, par.properties)
    else parset = .jset_of_paragraphs(value)

    if( check.dims > 3 ){
      if( missing(par.properties) )
        stop("You have to specify par.properties when using arguments offx and offy")
      out = .jcall( slide, "I", "add", parset
                    , as.double( offx ), as.double( offy ), as.double( width ), as.double( height ),
                    as.logical(restart.numbering) )
    } else {
      if( append ){
        out = .jcall( slide, "I", "append" , parset, as.logical(restart.numbering))
        if( out == 1) stop("append is possible if current shape is a shape containing paragraphs.")
      } else {
        out = .jcall( slide, "I", "add" , parset, as.logical(restart.numbering))
      }
    }

  }


  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "pot") )
  }

  doc
}





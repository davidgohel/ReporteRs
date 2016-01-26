#' @title Add an external image into a document object
#'
#' @description Add an external image into a document object
#'
#' @param doc document object
#' @param filename \code{"character"} value, complete filename
#' of the external image
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{pptx}}, \code{\link{bsdoc}}
addImage = function(doc, filename, ...){
  checkHasSlide(doc)
  if( missing( filename ) )
    stop("filename cannot be missing")
  if( !inherits( filename, "character" ) )
    stop("filename must be a single character value")
  if( length( filename ) != 1 )
    stop("filename must be a single character value")
  if( !file.exists( filename ) )
    stop( filename, " does not exist")

  if( !grepl("\\.(png|jpg|jpeg|gif|bmp|wmf|emf)$", filename ) )
    stop( filename, " is not a valid file. Valid files are png, jpg, jpeg, gif, bmp, wmf, emf.")
  UseMethod("addImage")
}


#' @param bookmark a character value ; id of the Word bookmark to replace by the image.
#' optional. if missing, image is added at the end of the document. See \code{\link{bookmark}}.
#' @param par.properties paragraph formatting properties of the paragraph that contains images.
#' An object of class \code{\link{parProperties}}. It has no effect if doc is
#' a \code{pptx} object.
#' @param width image width in inches
#' @param height image height in inches
#' @details
#' Arguments \code{width} and \code{height} can be defined with functions
#' \code{png::readPNG}, \code{jpeg::readJPEG} or \code{bmp::read.bmp}.
#' @examples
#' # Image example for MS Word -------
#' doc.filename = "ex_add_image.docx"
#' @example examples/docx.R
#' @example examples/addImageDocument.R
#' @example examples/addImageWMFDocument.R
#' @example examples/writeDoc_file.R
#' @rdname addImage
#' @export
addImage.docx = function(doc, filename, bookmark,
	par.properties = parProperties(text.align = "center", padding = 5 ),
	width, height, ... ) {

  if( missing(width) )
    stop("width can not be missing")
  if( missing(height) )
    stop("height can not be missing")


  if( !is.numeric( width ) )
    stop("arguments width must be a numeric vector")
  if( !is.numeric( height ) )
    stop("arguments height must be a numeric vector")

  filename <- getAbsolutePath(filename, expandTilde = TRUE)
  jimg = .jnew(class.Image , filename, .jfloat( width ), .jfloat( height ) )

	if( missing( bookmark ) )
		.jcall( doc$obj, "V", "add", jimg
				, .jParProperties( par.properties ) )
	else .jcall( doc$obj, "V", "add", jimg,
				.jParProperties( par.properties ), bookmark )

	doc
}


#' @examples
#'
#' # Image example for bsdoc -------
#' doc.filename = "ex_add_image/example.html"
#' @example examples/bsdoc.R
#' @example examples/addImageDocument.R
#' @example examples/writeDoc_file.R
#' @rdname addImage
#' @export
addImage.bsdoc = function(doc, filename, width, height,
                          par.properties = parProperties(text.align = "center", padding = 5 ),
                          ... ) {

  if( missing(width) )
    stop("width can not be missing")
  if( missing(height) )
    stop("height can not be missing")

  if( !is.numeric( width ) )
    stop("arguments width must be a numeric vector")
  if( !is.numeric( height ) )
    stop("arguments height must be a numeric vector")

  filename <- getAbsolutePath(filename, expandTilde = TRUE)
  jimg = .jnew(class.Image , filename, .jfloat( width ), .jfloat( height ) )

  .jcall( jimg, "V", "setParProperties", .jParProperties(par.properties) )

  out = .jcall( doc$jobj, "I", "add", jimg )
  if( out != 1 )
    stop( "Problem while trying to add image(s)." )

  doc
}


#' @param offx optional, x position of the shape (top left position of the bounding box) in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inches See details.
#' @details
#'
#' When document object is a \code{pptx}, width and height are not mandatory.
#' By default, image is added to the next free 'content' shape of the current slide.
#' See \code{\link{slide.layouts.pptx}} to view the slide layout.
#'
#' If arguments offx and offy are missing, position is defined as
#' the position of the next available shape of the slide. This
#' dimensions can be defined in the layout of the PowerPoint template used to create
#' the \code{pptx} object.
#' @examples
#'
#' # Image example for MS PowerPoint -------
#' doc.filename = "ex_add_image.pptx"
#' @example examples/pptx.R
#' @example examples/addImagePresentation.R
#' @example examples/addImageWMFPresentation.R
#' @example examples/writeDoc_file.R
#' @rdname addImage
#' @export
addImage.pptx = function(doc, filename, offx, offy, width, height, ... ) {

  slide = doc$current_slide

  off_missing <- ( missing( offx ) || missing( offy ) )
  ext_missing <- ( missing( width ) || missing( height ) )

  if( !off_missing && ext_missing ){
    stop("width and height must be provided if offx and offy are provided")
  }

  free_layout <- FALSE
  if( off_missing && ext_missing ){
    position <- next_shape_pos( doc )
    offx_ <- position$offx
    offy_ <- position$offy
    width_ <- position$width
    height_ <- position$height
  } else if( off_missing && !ext_missing ){
    position <- next_shape_pos( doc )
    offx_ <- position$offx
    offy_ <- position$offy
    width_ <- width
    height_ <- height
  } else {
    offx_ <- offx
    offy_ <- offy
    width_ <- width
    height_ <- height
    free_layout <- TRUE
  }

  filename <- getAbsolutePath(filename, expandTilde = TRUE)
  jimg = .jnew(class.Image , filename, .jfloat( width_ ), .jfloat( height_ ) )
  out = .jcall( slide, "I", "add", jimg, .jfloat( offx_ ), .jfloat( offy_ ), free_layout )

  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "image") )
  }

  doc
}


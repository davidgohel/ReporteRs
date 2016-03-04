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
#' @examples
#' # get rlogo
#' img.file <- file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
#'
#' # tests to use later
#' has_img <- file.exists( img.file )
#' has_jpeg <- requireNamespace("jpeg", quietly = TRUE)
#' has_wmf <- exists("win.metafile")
#' is_sunos <- tolower(Sys.info()[["sysname"]]) == "sunos"
#'
#' # create a wmf file if possible
#' if( has_wmf ){
#'   win.metafile(filename = "image.wmf", width = 5, height = 5 )
#'   barplot( 1:6, col = 2:7)
#'   dev.off()
#' }
#'
#'
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
#'
#' doc <- docx()
#'
#' if( has_img && has_jpeg ){
#'   dims <- attr( jpeg::readJPEG(img.file), "dim" )
#'   doc <- addImage(doc, img.file, width = dims[2]/72,
#'     height = dims[1]/72)
#' }
#'
#' if( has_wmf ){
#'   doc <- addImage(doc, "image.wmf", width = 5, height = 5 )
#' }
#'
#' writeDoc( doc, file = "ex_add_image.docx" )
#'
#'
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
#' # Image example for an HTML document -------
#'
#' doc <- bsdoc()
#'
#' if( has_img && has_jpeg ){
#'   dims <- attr( jpeg::readJPEG(img.file), "dim" )
#'   doc <- addImage(doc, img.file, width = dims[2]/72,
#'     height = dims[1]/72)
#' }
#'
#' writeDoc( doc, file = "ex_add_image/example.html" )
#'
#'
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
#' # Image example for MS PowerPoint -------
#' if( !is_sunos ){
#'
#' doc <- pptx()
#'
#' if( has_img && has_jpeg ){
#'   doc <- addSlide( doc, "Title and Content" )
#'   dims <- attr( jpeg::readJPEG(img.file), "dim" )
#'   doc <- addImage(doc, img.file, width = dims[2]/72,
#'     height = dims[1]/72)
#' }
#' if( has_wmf ){
#'   doc <- addSlide( doc, "Title and Content" )
#'   doc <- addImage(doc, "image.wmf", width = 5, height = 5 )
#' }
#'
#' writeDoc( doc, file = "ex_add_image.pptx" )
#'
#' }
#'
#'
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


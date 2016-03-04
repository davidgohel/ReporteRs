#' @title Insert a FlexTable into a document object
#'
#' @description Insert a FlexTable into a document object
#'
#' FlexTable can be manipulated so that almost any formatting can be specified. See
#' \code{\link{FlexTable}} for more details.
#' @param doc document object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @examples
#'
#' options( "ReporteRs-fontsize" = 11 )
#'
#' ft_obj <- vanilla.table(mtcars)
#'
#' @seealso \code{\link{FlexTable}}, \code{\link{docx}}
#' , \code{\link{pptx}}, \code{\link{bsdoc}}
addFlexTable = function(doc, flextable, ...){

  checkHasSlide(doc)
  if( !inherits(flextable, "FlexTable") )
    stop("argument flextable must be a FlexTable object.")

  UseMethod("addFlexTable")
}



#' @param par.properties paragraph formatting properties of the paragraph that contains the table.
#' An object of class \code{\link{parProperties}}
#' @param bookmark a character vector specifying bookmark id (where to put the table).
#'   	If provided, table will be add after paragraph that contains the bookmark. See \code{\link{bookmark}}.
#'   	If not provided, table will be added at the end of the document.
#' @examples
#' # docx example -----
#' doc = docx( )
#' doc = addFlexTable( doc, flextable = ft_obj )
#' writeDoc( doc, file = "add_ft_ex.docx" )
#'
#'
#' @rdname addFlexTable
#' @export
addFlexTable.docx = function(doc, flextable
	, par.properties = parProperties(text.align = "left" )
	, bookmark, ... ) {

	if( missing( bookmark ) )
		.jcall( doc$obj, "V", "add", flextable$jobj, .jParProperties(par.properties) )
	else .jcall( doc$obj, "V", "add", flextable$jobj, .jParProperties(par.properties), bookmark )

	doc
}


#' @examples
#' # bsdoc example -----
#' doc = bsdoc( )
#' doc = addFlexTable( doc, flextable = ft_obj )
#' writeDoc( doc, file = "add_ft_ex/index.html" )
#'
#'
#' @rdname addFlexTable
#' @export
addFlexTable.bsdoc = function(doc, flextable,
                              par.properties = parProperties(text.align = "left" ), ... ) {

  .jcall( flextable$jobj, "V", "setParProperties", .jParProperties(par.properties) )

  out = .jcall( doc$jobj, "I", "add", flextable$jobj )
  if( out != 1 ){
    stop( "Problem while trying to add FlexTable." )
  }

  doc
}



#' @param offx optional, x position of the shape (top left position of the bounding box) in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inches. See details.
#' @param width optional, width of the shape in inches. See details.
#' @param height optional, height of the shape in inches. See details.
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
#' @examples
#' # bsdoc example -----
#' doc = pptx( )
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addFlexTable( doc, flextable = ft_obj )
#' writeDoc( doc, file = "add_ft_ex.pptx" )
#'
#'
#' @rdname addFlexTable
#' @export
addFlexTable.pptx = function(doc, flextable, offx, offy, width, height, ... ) {

  check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
  if( check.dims > 0 && check.dims < 4 ) {
    if( missing( offx ) ) warning("arguments offx, offy, width and height must be all specified: offx is missing")
    if( missing( offy ) ) warning("arguments offx, offy, width and height must be all specified: offy is missing")
    if( missing( width ) ) warning("arguments offx, offy, width and height must be all specified: width is missing")
    if( missing( height ) ) warning("arguments offx, offy, width and height must be all specified: height is missing")
  }
  if( check.dims > 3 ) {
    if( !is.numeric( offx ) ) stop("arguments offx must be a numeric vector")
    if( !is.numeric( offy ) ) stop("arguments offy must be a numeric vector")
    if( !is.numeric( width ) ) stop("arguments width must be a numeric vector")
    if( !is.numeric( height ) ) stop("arguments height must be a numeric vector")

    if( length( offx ) != length( offy )
        || length( offx ) != length( width )
        || length( offx ) != length( height ) || length( offx )!= 1 ){
      stop("arguments offx, offy, width and height must have the same length")
    }
  }

  if( check.dims > 3 ){
    out = .jcall( doc$current_slide, "I", "add", flextable$jobj
                  , as.double( offx ), as.double( offy ), as.double( width ), as.double( height ) )
  } else {
    out = .jcall( doc$current_slide, "I", "add", flextable$jobj )
  }

  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "table") )
  }
  doc
}



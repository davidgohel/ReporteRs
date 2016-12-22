#' @importFrom R.utils getAbsolutePath
#' @title Create Microsoft PowerPoint document object representation
#'
#' @description
#' Create a \code{\link{pptx}} object
#'
#' @param title \code{"character"} value: title of the document (in the doc properties).
#' @param template \code{"character"} value, it represents the filename of the pptx file used as a template.
#' @param list.definition a list definition to specify how ordered and unordered
#' lists have to be formated. See \code{\link{list.settings}}. Default to
#' \code{getOption("ReporteRs-list-definition")}.
#' @return an object of class \code{\link{pptx}}.
#' @details
#' To send R output in a pptx document, a slide (see \code{\link{addSlide.pptx}}
#' have to be added to the object first (because output is beeing written in slides).
#'
#' Several methods can used to send R output into an object of class \code{\link{pptx}}.
#'
#' \itemize{
#'   \item \code{\link{addTitle.pptx}} add titles
#'   \item \code{\link{addParagraph.pptx}} add text
#'   \item \code{\link{addPlot.pptx}} add plots
#'   \item \code{\link{addFlexTable.pptx}} add \code{\link{FlexTable}}
#'   \item \code{\link{addDate.pptx}} add a date (most often in the bottom left area of the slide)
#'   \item \code{\link{addFooter.pptx}} add a comment in the footer (most often in the bottom center area of the slide)
#'   \item \code{\link{addPageNumber.pptx}} add a page number (most often in the bottom right area of the slide)
#'   \item \code{\link{addImage.pptx}} add external images
#' }
#' Once object has content, user can write the pptx into a ".pptx" file, see \code{\link{writeDoc}}.
#' @references Wikipedia: Office Open XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
#' @note
#'
#' Power Point 2007-2013 (*.pptx) file formats are the only supported files.
#'
#' Document are manipulated in-memory ; a \code{pptx}'s document is not written to the disk
#' unless the \code{\link{writeDoc}} method has been called on the object.
#' @examples
#' \donttest{
#' # set default font size to 10
#' options( "ReporteRs-fontsize" = 11 )
#'
#' # Word document to write
#' pptx.file = "presentation_example.pptx"
#'
#' # Create a new document
#' doc = pptx( title = "title" )
#'
#' # display layouts names
#' slide.layouts( doc )
#'
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#'
#' #set the main title
#' doc = addTitle( doc, "Presentation title" )
#' #set the sub-title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")
#'
#'
#' ################ TEXT DEMO ################
#'
#' # add a slide with layout "Title and Content" then add content
#' doc = addSlide( doc, slide.layout = "Two Content" )
#'
#' # add a title
#' doc = addTitle( doc, "Text demo" )
#' sometext = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
#' 	, "In sit amet ipsum tellus. Vivamus dignissim sit amet auctor."
#' 	, "Quisque dictum tristique ligula."
#' )
#'
#' # add simple text
#' doc = addParagraph( doc, value = sometext )
#'
#' # Add "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor"
#' 	, textProperties(color="red" ) ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' pot2 = pot("Cats"
#' 	, textProperties(color="red" )
#' 	) + " and " + pot("Dogs"
#' 	, textProperties(color="blue" ) )
#' doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )
#'
#' ################ PLOT DEMO ################
#' if( requireNamespace("ggplot2", quietly = TRUE) ){
#'   doc = addSlide( doc, slide.layout = "Title and Content" )
#'   doc = addTitle( doc, "Plot examples" )
#'
#'   myplot = ggplot2::qplot(Sepal.Length, Petal.Length
#'     , data = iris, color = Species
#'     , size = Petal.Width, alpha = I(0.7)
#' )
#'   # Add titles and then 'myplot'
#'   doc = addPlot( doc, function( ) print( myplot ) )
#' }
#'
#' ################ FLEXTABLE DEMO ################
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addTitle( doc, "FlexTable example" )
#'
#' # Create a FlexTable with data.frame mtcars, display rownames
#' # use different formatting properties for header and body
#' MyFTable = FlexTable( data = mtcars, add.rownames = TRUE,
#' 	header.cell.props = cellProperties( background.color = "#00557F" ),
#' 	header.text.props = textProperties( color = "white",
#' 		font.size = 11, font.weight = "bold" ),
#' 	body.text.props = textProperties( font.size = 10 )
#' )
#' # zebra stripes - alternate colored backgrounds on table rows
#' MyFTable = setZebraStyle( MyFTable, odd = "#E1EEf4", even = "white" )
#'
#' # applies a border grid on table
#' MyFTable = setFlexTableBorders(MyFTable,
#' 	inner.vertical = borderProperties( color="#0070A8", style="solid" ),
#' 	inner.horizontal = borderNone(),
#' 	outer.vertical = borderProperties( color = "#006699",
#' 	  style = "solid", width = 2 ),
#' 	outer.horizontal = borderProperties( color = "#006699",
#' 	  style = "solid", width = 2 )
#' )
#'
#' # add MyFTable into document
#' doc = addFlexTable( doc, MyFTable )
#'
#' # write the doc
#' writeDoc( doc, file = pptx.file )
#' }
#' @export
#' @seealso \code{\link{docx}}
pptx = function( title, template, list.definition = getOption("ReporteRs-list-definition")){

	# title mngt
	if( missing( title ) ) title = ""


	# pptx base file mngt
	if( missing( template ) )
		template = file.path( system.file(package = "ReporteRs"), "templates/EMPTY_DOC.pptx" )
	.reg = regexpr( paste( "(\\.(?i)(pptx))$", sep = "" ), template )

	template <- getAbsolutePath(template, expandTilde = TRUE)

	if( .reg < 1 )
	  stop("invalid template name, it must have extension .pptx")

	if( !file.exists( template ) )
	  stop(template , " can not be found.")

#	public static int NO_ERROR = 0;
#	public static int READDOC_ERROR = 1;
#	public static int LOADDOC_ERROR = 2;
#	public static int LAYOUT_ERROR = 3;
#	public static int SAVE_ERROR = 4;
#	public static int PARTNAME_ERROR = 5;
#	public static int SLIDECREATION_ERROR = 6;
#	// public static int slidedimensions_error = 7;
#	public static int UNDEFINED_ERROR = -1;
	# java calls
	obj = .jnew( class.pptx4r.document )

	basedoc.return = .jcall( obj, "I", "setBaseDocument", template )
	if( basedoc.return != error_codes["NO_ERROR"] ){
		stop( "an error occured - code[", names(error_codes)[which( error_codes == basedoc.return )], "].")
	}
	lidef = do.call( list.settings, list.definition )
	.jcall( obj, "V", "setNumberingDefinition", lidef )
	layout.labels = .jcall( obj, "[S", "getStyleNames" )

	.Object = list( obj = obj
			, title = title
			, basefile = template
			, styles = layout.labels
			, plot_first_id = 0L
			, current_slide = NULL
	)

	class( .Object ) = "pptx"

	.Object
}


#' @details
#' \code{dim} returns slide width and height, position and
#' dimension of the next available shape in the current slide.
#'
#' @param x Object of class \code{pptx}
#' @examples
#'
#' # get pptx page dimensions ------
#' doc = pptx( title = "title" )
#' doc = addSlide( doc, "Title and Content" )
#' dim(doc)
#' @rdname pptx
#' @export
dim.pptx = function( x ){
  if( !is.null(x$current_slide) )
    temp = .jcall(x$current_slide, "[I", "getShapeDimensions")
  else temp = rep(0.0, 4 )

  out = list( position = round( c( left = temp[1], top = temp[2] ) / 914400, 5 )
              , size = round( c(width = temp[3], height = temp[4]) / 914400, 5 )
              , slide.dim = round( c(width = .jcall(x$obj, "I", "getDocWidth")
                                     , height = .jcall(x$obj, "I", "getDocHeight") ) / 914400, 5 )
  )
  out
}


#' @details
#' \code{print} print informations about an object of
#' class \code{pptx}.
#' @param ... further arguments, not used.
#' @rdname pptx
#' @export
print.pptx = function (x, ...){

  cat("[pptx object]\n")

  cat("title:", x$title, "\n")

  cat(paste( "Original document: '", x$basefile, "'\n", sep = "" ) )

  cat( "Slide layouts:\n" )
  print( slide.layouts( x ) )


  invisible()

}




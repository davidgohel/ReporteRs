#' @title Create Microsoft PowerPoint document object representation
#'
#' @description
#' Create a \code{"pptx"} object
#' 
#' @param title \code{"character"} value: title of the document (in the doc properties).
#' @param template \code{"character"} value, it represents the filename of the pptx file used as a template.
#' @return an object of class \code{"pptx"}.
#' @details
#' To send R output in a pptx document, a slide (see \code{\link{addSlide.pptx}}
#' have to be added to the object first (because output is beeing written in slides).
#' 
#' Several methods can used to send R output into an object of class \code{"pptx"}.
#' 
#' \itemize{
#'   \item \code{\link{addTitle.pptx}} add titles
#'   \item \code{\link{addParagraph.pptx}} add texts
#'   \item \code{\link{addPlot.pptx}} add plots
#'   \item \code{\link{addTable.pptx}} add tables
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
#' @export
#' @examples
#' \donttest{
#' library( ReporteRs )
#' 
#' # PowerPoint document to write
#' pptx.file <- "~/presentation.pptx"
#' 
#' 
#' # Create a new document
#' doc = pptx( title = "title" )
#' # display layouts names
#' slide.layouts( doc )
#' 
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#' doc = addTitle( doc, "Presentation title" ) #set the main title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title
#' 
#' # add a slide with layout "Title and Content" then add content
#' doc = addSlide( doc, slide.layout = "Two Content" )
#' doc = addTitle( doc, "Texts demo" )
#' texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
#' , "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
#' , "Quisque dictum tristique ligula."
#' )
#' # add simple text
#' doc = addParagraph( doc, value = texts)
#' 
#' # Add "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="red"
#' 	, font.size = 28 ) ) + " is " + pot("rich"		
#' 	, textProperties(font.weight="bold") )		
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="red", font.size = 28)
#' ) + " and " + pot("Dogs", textProperties(color="blue", font.size = 28) )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' doc <- addParagraph(doc, my.pars )
#' 
#' 
#' myplot = qplot(Sepal.Length, Petal.Length
#' 	, data = iris, color = Species		
#' 	, size = Petal.Width, alpha = I(0.7)		
#' )
#' 
#' # add a slide with layout "Section Header" then add content
#' doc = addSlide( doc, slide.layout = "Section Header" )
#' doc = addTitle( doc, "Plot examples", )
#' doc = addParagraph( doc, "Here we will output plots" )
#' 
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addTitle( doc, "Plot example 1" )
#' doc = addPlot( doc, function( ) print( myplot ) )
#' 
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addTitle( doc, "Plot example 2" )
#' doc = addPlot( doc, function( ) {
#' 	print( ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7) )		
#' 	}		
#' )
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addTitle( doc, "Plot example 3")
#' doc = addPlot( doc, function( ) {
#' 	plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)		
#' 	}, fontname = "Arial"		
#' )
#' 
#' # add a slide with layout "Section Header" then add content
#' doc = addSlide( doc, slide.layout = "Section Header" )
#' doc = addTitle( doc, "Table examples", )
#' doc = addParagraph( doc, "Here we will output table" )
#' 
#' # add a slide with layout "Comparison"
#' doc = addSlide( doc, slide.layout = "Comparison" )
#' doc = addTitle( doc, "Example 1 and 2" )
#' 
#' doc = addParagraph( doc, "Simple add" )
#' # add iris sample
#' doc = addTable( doc, data = iris[25:33, ] )
#' 
#' doc = addParagraph( doc, "Customized table add", stylename="Normal" )
#' data( data_ReporteRs )
#' # add dummy dataset and customise some options
#' doc <- addTable( doc
#' 	, data = data_ReporteRs		
#' 	, header.labels = c( "Header 1", "Header 2", "Header 3", "Header 4", "Header 5", "Header 6" )		
#' 	, groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2"), colspan = c(3, 3) )		
#' 	, col.types = c( "character", "integer", "double", "date", "percent", "character" )		
#' 	, columns.font.colors = list(		
#' 		col1 = c("#527578", "#84978F", "#ADA692", "#47423F")	
#' 		, "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")	
#' 	)		
#' 	, columns.bg.colors = list(		
#' 		col2 = c("#527578", "#84978F", "#ADA692", "#47423F")	
#' 		, "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")	
#' 	)		
#' )
#' 
#' # write the doc
#' writeDoc( doc, pptx.file)
#' # browseURL( pptx.file )
#' }
#' @seealso \code{\link{addTitle.pptx}}, \code{\link{addImage.pptx}}, \code{\link{addParagraph.pptx}}
#' , \code{\link{addPlot.pptx}}, \code{\link{addTable.pptx}}
#' , \code{\link{slide.layouts.pptx}}, \code{\link{writeDoc.pptx}}

pptx = function( title, template){
	
	# title mngt
	if( missing( title ) ) title = ""
	
	
	# pptx base file mngt
	if( missing( template ) )
		template = paste( find.package("ReporteRs"), "templates/EMPTY_DOC.pptx", sep = "/" )
	.reg = regexpr( paste( "(\\.(?i)(pptx))$", sep = "" ), template )
	
	if( !file.exists( template ) || .reg < 1 )
		stop(template , " is not a valid file.")
	
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
	obj = rJava::.jnew( class.pptx4r.document )
	
	basedoc.return = rJava::.jcall( obj, "I", "setBaseDocument", template )
	if( basedoc.return != error_codes["NO_ERROR"] ){
		stop( "an error occured - code[", names(error_codes)[which( error_codes == basedoc.return )], "].")
	}
	
	.Object = list( obj = obj
		, title = title
		, basefile = template
		, styles = rJava::.jcall( obj, "[S", "getStyleNames" ) 
		, plot_first_id = 0L
		, current_slide = NULL
		)
	class( .Object ) = "pptx"
	
	.Object
}


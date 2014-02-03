#' @title Create an Reveal document object representation
#'
#' @description
#' Create a \code{"reveal"} object
#' 
#' @param title \code{"character"} value: title of the document (in the doc properties).
#' @return an object of class \code{"reveal"}.
#' @details
#' 
#' \code{reveal} objects are experimental ; codes and api will probably change later.
#' 
#' To send R output in an reveal document, a page (see \code{\link{addSlide.reveal}}
#' have to be added to the object first (because output is beeing written in pages).
#' 
#' Several methods can used to send R output into an object of class \code{"reveal"}.
#'  
#' \itemize{
#'   \item \code{\link{addTitle.reveal}} add titles
#'   \item \code{\link{addImage.reveal}} add external images
#'   \item \code{\link{addParagraph.reveal}} add texts
#'   \item \code{\link{addPlot.reveal}} add plots
#'   \item \code{\link{addTable.reveal}} add tables
#'   \item \code{\link{addRScript.reveal}} add R Script
#' }
#' Once object has content, user can write the htmls pages into a file, see \code{\link{writeDoc.reveal}}.
#' @export
#' @examples
#' \donttest{
#' library( ReporteRs )
#' # Create a new document
#' library( ReporteRs )
#' # reveal document to write
#' reveal.directory <- "reveal_doc"
#' # Create a new document
#' doc = reveal( title = "document title" )
#' # add a page with title "Page 1"
#' doc = addSlide( doc, title = "Page 1" )
#' doc = addTitle( doc, "Texts demo", level = 1 )
#' texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
#'      , "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
#'      , "Quisque dictum tristique ligula."
#' )
#' # add simple text
#' doc = addParagraph( doc, value = texts )
#' # Add "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="purple"
#'      , font.size = 14 ) ) + " is " + pot("rich"
#'      , textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="purple", font.size = 14)
#' ) + " and " + pot("Dogs", textProperties(color="blue", font.size = 14) )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' doc <- addParagraph(doc, my.pars )
#' doc = addSlide( doc, title = "ggplot" )
#' myplot = qplot(Sepal.Length, Petal.Length
#'      , data = iris, color = Species
#'      , size = Petal.Width, alpha = I(0.7)
#' )
#' # Add myplot
#' doc = addTitle( doc, "Plot example 1", level = 1 )
#' doc = addPlot( doc, function( ) print( myplot ) )
#' doc = addSlide( doc, title = "ggplot 2" )
#' doc = addTitle( doc, "Plot example 2", level = 1 )
#' doc = addPlot( doc, function( ) {
#'              print( ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7) )
#'              }
#' )
#' doc = addSlide( doc, title = "ggplot 3" )
#' doc = addPlot( doc, function( ) {
#'              plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)
#'              }, fontname = "Arial"
#' )
#' # add a slide with layout "Comparison"
#' doc = addSlide( doc, title = "table 1" )
#' doc = addTitle( doc, "Table examples", level = 1 )
#' doc = addTitle( doc, "Simple add", level = 2 )
#' # add iris sample
#' doc = addTable( doc, data = iris[25:33, ] )
#' doc = addSlide( doc, title = "table 2" )
#' doc = addTitle( doc, "Customized table add", level = 2 )
#' data( data_ReporteRs )
#' # add dummy dataset and customise some options
#' doc <- addTable( doc
#'              , data = data_ReporteRs
#'              , header.labels = c( "Header 1", "Header 2", "Header 3", "Header 4", "Header 5", "Header 6" )
#'              , groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2"), colspan = c(3, 3) )
#'              , col.types = c( "character", "integer", "double", "date", "percent", "character" )
#'              , columns.font.colors = list(
#'                      col1 = c("#527578", "#84978F", "#ADA692", "#47423F")
#'                      , "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
#'              )
#'              , columns.bg.colors = list(
#'                      col2 = c("#527578", "#84978F", "#ADA692", "#47423F")
#'                      , "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
#'              )
#' )
#' reveal.files = writeDoc( doc, directory = reveal.directory )
#' 	
#' }

reveal = function( title = "untitled" ){
	
	
	# java calls
	obj = .jnew(class.reveal4r.document, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1") )
	
	rJava::.jcall( obj , "V", "addJavascript", "lib/js/head.min.js" )
	rJava::.jcall( obj , "V", "addJavascript", "js/reveal.min.js" )
	rJava::.jcall( obj , "V", "addJavascript", "js/raphael-min.js" )
	rJava::.jcall( obj , "V", "addJavascript", "js/jquery.min.js" )
	
	rJava::.jcall( obj , "V", "addStylesheet", "css/reveal.min.css" )
	rJava::.jcall( obj , "V", "addStylesheet", "css/theme/default.css" )
	
	.Object = list( obj = obj
		, title = title
		, canvas_id = 1
		, current_slide = NULL
		)

	class( .Object ) = "reveal"

	.Object
}


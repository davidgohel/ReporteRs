#' @title Create an HTML document object representation
#'
#' @description
#' Create a \code{"html"} object
#' 
#' @param title \code{"character"} value: title of the document (in the doc properties).
#' @return an object of class \code{"html"}.
#' @details
#' 
#' \code{html} objects are experimental ; codes and api will probably change later.
#' 
#' To send R output in an html document, a page (see \code{\link{addPage.html}}
#' have to be added to the object first (because output is beeing written in pages).
#' 
#' Several methods can used to send R output into an object of class \code{"html"}.
#'  
#' \itemize{
#'   \item \code{\link{addTitle.html}} add titles
#'   \item \code{\link{addImage.html}} add external images
#'   \item \code{\link{addParagraph.html}} add texts
#'   \item \code{\link{addPlot.html}} add plots
#'   \item \code{\link{addTable.html}} add tables
#'   \item \code{\link{addRScript.html}} add R Script
#' }
#' Once object has content, user can write the htmls pages into a directory, see \code{\link{writeDoc.html}}.
#' @export
#' @examples
#' \donttest{
#' # Create a new document 
#' library( ReporteRs )	
#' 	
#' # PowerPoint document to write	
#' html.directory <- "document"	
#' 
#' # Create a new document	
#' doc = html( title = "document title" )	
#' 	
#' # add a page with title "Page 1"
#' doc = addPage( doc, title = "Page 1" )
#' 	
#' doc = addTitle( doc, "Texts demo", level = 1 )
#' texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit." 
#'   	, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
#' 	, "Quisque dictum tristique ligula."
#' )
#' # add simple text
#' doc = addParagraph( doc, value = texts )
#' 
#' # Add "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="purple"
#' 	, font.size = 14 ) ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="purple", font.size = 14) 
#' ) + " and " + pot("Dogs", textProperties(color="blue", font.size = 14) )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' doc <- addParagraph(doc, my.pars )
#' 
#' 
#' myplot = qplot(Sepal.Length, Petal.Length
#' 	, data = iris, color = Species
#' 	, size = Petal.Width, alpha = I(0.7)
#' ) 
#' 
#' # Add myplot
#' doc = addTitle( doc, "Plot example 1", level = 1 )
#' doc = addPlot( doc, function( ) print( myplot ) )
#' 
#' doc = addTitle( doc, "Plot example 2", level = 1 )
#' doc = addPlot( doc, function( ) {
#' 		print( ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7) ) 				
#' 		}				
#' )	
#' doc = addPlot( doc, function( ) {	
#' 		plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)				
#' 		}, fontname = "Arial"				
#' )	
#' 	
#' # add a slide with layout "Comparison"	
#' doc = addTitle( doc, "Table examples", level = 1 )	
#' doc = addTitle( doc, "Simple add", level = 2 )	
#' # add iris sample	
#' doc = addTable( doc, data = iris[25:33, ] )	
#' doc = addTitle( doc, "Customized table add", level = 2 )	
#' 	
#' data( data_ReporteRs )	
#' # add dummy dataset and customise some options	
#' doc <- addTable( doc	
#' 		, data = data_ReporteRs				
#' 		, header.labels = c( "Header 1", "Header 2", "Header 3", "Header 4", "Header 5", "Header 6" )				
#' 		, groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2"), colspan = c(3, 3) )				
#' 		, col.types = c( "character", "integer", "double", "date", "percent", "character" )	
#' 		, columns.font.colors = list(
#' 			col1 = c("#527578", "#84978F", "#ADA692", "#47423F")
#' 			, "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
#' 		)
#' 		, columns.bg.colors = list(	
#' 			col2 = c("#527578", "#84978F", "#ADA692", "#47423F")
#' 			, "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
#' 		)
#' )
#'
#' # add a FlexTable with many options
#' # let's take a sample of iris
#' irisdata = iris[47:54,c(5,1:4)]
#' 
#' ## properties to use later
#' # cell headers props
#' cpHeader = cellProperties(background.color = "#102E37", border.color = "#F78D3F")
#' # cell data props
#' cpData = cellProperties( background.color = "#E8EDE0", border.color="#F78D3F")
#' # text headers props
#' tpHeader = textProperties( color = "#E8EDE0", font.weight="bold")
#' # text data props
#' tpData = textProperties( color = "#102E37")
#' 
#' # create the FlexTable
#' myFlexTable = FlexTable( data = irisdata
#'   , cell_format = cpData, text_format = tpData
#'   , span.columns = "Species"
#'   , header.columns = FALSE, row.names = FALSE
#'   )
#' 
#' # create a FlexRow to use as FlexTable header row
#' headerRow = FlexRow()
#' for(i in 1:ncol(irisdata))
#'    headerRow[i] = FlexCell( pot( names(irisdata)[i], format = tpHeader )
#'       , cellProp = cpHeader )
#' myFlexTable = addHeaderRow( myFlexTable, headerRow)
#' 
#' # Let's format text cells in red
#' myFlexTable[ 1:2, 1:2] = textProperties( color = "red" )
#' # Let's right align column 1 paragraphs
#' myFlexTable[ , 1] = parProperties( text.align = "right" )
#' # Let's change background color of a cell
#' myFlexTable[ 8, 5] = cellProperties( background.color = "#FF9729", border.width = 0)
#' 
#' # Replace a cell with a pot object
#' myFlexTable = setFlexCellContent( myFlexTable, 8, 5
#'   , pot("Hello", format = textProperties( font.weight = "bold" ) ) + pot("World"
#'       , format = textProperties( font.weight = "bold", vertical.align = "superscript") ) )
#' 
#' doc = addFlexTable( doc, myFlexTable )
#' html.files = writeDoc( doc, directory = html.directory )	
#' # browseURL( html.files[1] )	
#' }
#' @seealso \code{\link{docx}}, \code{\link{pptx}}

html = function( title = "untitled" ){
	
	
	# java calls
	obj = rJava::.jnew(class.html4r.document, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1") )
	
	.Object = list( obj = obj
		, title = title
		, canvas_id = 1
		, current_slide = NULL
		)
	class( .Object ) = "html"
	

	.Object
}


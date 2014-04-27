#' @title Add a plot into a docx object
#'
#' @description
#' Add a plot into the \code{docx} object.
#' 
#' @param doc the \code{docx} to use
#' @param fun plot function
#' @param width plot width in inches (default value is 6).
#' @param height plot height in inches (default value is 6).
#' @param vector.graphic logical scalar, default to FALSE. 
#' 
#' DrawingML instructions cannot be read by MS Word 2007. 
#' @param bookmark id of the Word bookmark to replace by the plot. optional.
#' 
#' \code{bookmark} is a character vector specifying bookmark id to replace by the plot(s).\cr 
#'   	If provided, plot(s) will replace the paragraph that contains the bookmark.\cr
#'   	If not provided, plot(s) will be added at the end of the document.
#' 
#' @param par.properties paragraph formatting properties of the paragraph that contains plot(s). An object of class \code{\link{parProperties}}
#' @param pointsize the default pointsize of plotted text in pixels, default to getOption("ReporteRs-fontsize").
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param editable logical value - if TRUE vector graphics elements (points, texts, etc.) are editable.
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' require( ggplot2 )
#' 
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' doc = addTitle( doc, "Plot 1", level = 1 )
#' # Add a base plot - set vector.graphic to FALSE if Word version 
#' # used to read the file is <= 2007
#' doc = addPlot( doc, fun = plot
#' 		, x = rnorm( 100 )
#' 		, y = rnorm (100 )
#' 		, main = "base plot main title"
#' 		, vector.graphic = TRUE
#' 		, width = 5, height = 7
#' 		, par.properties = parProperties(text.align = "left")
#' 	)
#' 
#' doc = addTitle( doc, "Plot 2", level = 1 )
#' myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
#' 	, size = Petal.Width, alpha = I(0.7))
#' doc = addPlot( doc = doc
#' 		, fun = print
#' 		, x = myplot #this argument MUST be named, print is expecting argument 'x'
#' 	)
#' 
#' # Write the object in file "addPlot_example.docx"
#' writeDoc( doc, "addPlot_example.docx" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{addPlot}}
#' @method addPlot docx
#' @S3method addPlot docx

addPlot.docx = function(doc, fun
		, pointsize = getOption("ReporteRs-fontsize")
		, vector.graphic = F
		, width = 6, height = 6
		, fontname = getOption("ReporteRs-default-font")
		, editable = TRUE
		, bookmark 
		, par.properties = parProperties(text.align = "center", padding = 5 )
		, ... ) {

	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )
	
	if( !vector.graphic ){
		
		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename
				, width = width, height = height, units = 'in'
				, pointsize = pointsize, res = 300
		)
		
		fun(...)
		dev.off()
	
		plotfiles = list.files( dirname , full.names = T )
		dims = as.integer( c( width*72.2 , height*72.2 )* 12700 )
		
		# Send the graph to java that will 'encode64ize' and place it in a docx4J object
		if( missing( bookmark ) )
			.jcall( doc$obj, "V", "addImage", .jarray( plotfiles ), .jarray(dims)
					, par.properties$text.align
					, par.properties$padding.bottom
					, par.properties$padding.top
					, par.properties$padding.left
					, par.properties$padding.right
			)
		else .jcall( doc$obj, "V", "insertImage", bookmark, .jarray( plotfiles ), .jarray(dims)
					, par.properties$text.align
					, par.properties$padding.bottom
					, par.properties$padding.top
					, par.properties$padding.left
					, par.properties$padding.right
			)
	} else {
		# one important and painful point is that shape ids must be unique 
		# in the whole document
		last_docx_elt_index = .jcall( doc$obj, "I", "getElementIndex") + 1L
		# OK, maybe start_id should be named last_id... 
		doc_elt_index = last_docx_elt_index;
		filename = file.path( dirname, "dml", fsep = "/"  )
		filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)
		env = dml.docx( file = filename, width=width*72.2, height = height*72.2
				, offx = 0, offy = 0, ps = pointsize, fontname = fontname
				, firstid = as.integer( last_docx_elt_index )
				, editable = editable
		)
		fun_res = try( fun(...), silent = T )
		last_id = .C("get_current_element_id", (dev.cur()-1L), 0L)[[2]]
		
#		browser()
		dev.off()
		

		.jcall( doc$obj, "V", "incrementElementIndex", as.integer( last_id - doc_elt_index + 1 ) )

		dims = as.integer( c( width*72.2 , height*72.2 )* 12700 )
		plotfiles = list.files( dirname , full.names = T )

		if( missing( bookmark ) ){
			
			.jcall( doc$obj, "V", "addDML", .jarray( plotfiles ), .jarray(dims)
					, par.properties$text.align
					, par.properties$padding.bottom
					, par.properties$padding.top
					, par.properties$padding.left
					, par.properties$padding.right
					)
		} else {
			.jcall( doc$obj, "V", "insertDML", bookmark, .jarray( plotfiles ), .jarray(dims) 
					, par.properties$text.align
					, par.properties$padding.bottom
					, par.properties$padding.top
					, par.properties$padding.left
					, par.properties$padding.right
					)
		}
	}

	doc
}


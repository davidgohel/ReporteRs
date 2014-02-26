#' @title Add a plot into a pptx object
#'
#' @description
#' Add a plot to the current slide of an existing \code{pptx} object.
#' 
#' @param doc the \code{pptx} to use
#' @param fun plot function
#' @param pointsize the default pointsize of plotted text, interpreted as big points (1/72 inch) at res ppi.
#' @param vector.graphic logical scalar, default to TRUE. If TRUE, vector graphics 
#' are produced instead of PNG images. Vector graphics in pptx document are DrawingML instructions. 
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param editable logical value - if TRUE vector graphics elements (points, texts, etc.) are editable.
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{"pptx"}.
#' @details
#' Width and height can't be controled here. They are defined by 
#' the width and height of the shape that will contain the graphics.
#' 
#' This dimensions can be defined in the layout 
#' of the PowerPoint template used to create the \code{pptx} object. 
#' @examples
#' # Create a new document 
#' doc = pptx( title = "title" )
#' 
#' # add a slide with layout "Title and Content" then add plot
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addTitle( doc, "base plot" )
#' # Add a base plot
#' doc = addPlot( doc, fun = plot
#' 		, x = rnorm( 100 )
#' 		, y = rnorm (100 )
#' 		, main = "base plot main title"
#' 	)
#' 
#' # add a slide with layout "Two Content" then add 2 plots
#' doc = addSlide( doc, slide.layout = "Two Content" )
#' doc = addTitle( doc, "2 ggplot2 examples" )
#' doc = addPlot( doc
#' 		, function(){
#' 			print( qplot(Sepal.Length, Petal.Length, data = iris, color = Species
#' 				, size = Petal.Width, alpha = I(0.7)) )
#' 		}
#' 	)
#' 
#' myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
#' 			, size = Petal.Width, alpha = I(0.7))
#' doc = addPlot( doc
#' 		, print
#' 		, x = myplot #this argument MUST be named, print is expecting argument 'x'
#' 		, vector.graphic = FALSE
#' 	)
#' 
#' # Write the object in file "presentation.pptx"
#' writeDoc( doc, "presentation.pptx" )
#' @seealso \code{\link{pptx}}, \code{\link{addPlot}}
#' @method addPlot pptx
#' @S3method addPlot pptx

addPlot.pptx = function(doc, fun, pointsize=getOption("ReporteRs-fontsize")
	, vector.graphic = TRUE, fontname = getOption("ReporteRs-default-font")
	, editable = TRUE
	, ... ) {
	slide = doc$current_slide 
	plot_first_id = doc$plot_first_id
	id = rJava::.jcall( slide, "I", "getNextIndex"  )
	maxid = rJava::.jcall( slide, "I", "getmax_shape"  )
	
	if( maxid-id < 1 ) stop( getSlideErrorString( shape_errors["NOROOMLEFT"] , "plot") )

	widths = double( maxid-id )
	heights = double( maxid-id )
	offxs = double( maxid-id )
	offys = double( maxid-id )
	j=0
	LayoutName = rJava::.jcall( slide, "S", "getLayoutName" )
	SlideLayout = rJava::.jcall( doc$obj, paste0("L", class.pptx4r.SlideLayout, ";"), "getSlideLayout", LayoutName )
	
	for(i in seq(id,maxid-1, by=1) ){
		dims = rJava::.jcall( SlideLayout, "[I", "getContentDimensions", as.integer(i) )
		j = j + 1
		widths[j] = dims[3] / 12700
		heights[j] = dims[4] / 12700
		offxs[j] = dims[1] / 12700
		offys[j] = dims[2] / 12700
	}

	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )
	if( vector.graphic ){
		filename = file.path( dirname, "/plot_"  )
		filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)
		
		env = dml.pptx( file = filename, width=widths, height=heights
			, offx = offxs, offy = offys, ps = pointsize, fontname = fontname
			, firstid = plot_first_id, editable = editable
			)
		fun_res = try( fun(...), silent = T )
		dev.off()
		doc$plot_first_id = get("start_id", envir = env ) + 1


		nbplots = maxid-id
		if( nbplots > 0 ){
			plotfiles = list.files( dirname , full.names = T )
			for( i in 1:length( plotfiles ) ){
				if( i <= nbplots ){
					gr = rJava::.jnew(class.pptx4r.DrawingMLList, plotfiles[i]  )
					out = rJava::.jcall( slide, "I", "add", gr )
					if( isSlideError( out ) ){
						stop( getSlideErrorString( out , "dml") )
					}	
					
				} else { 
					warning("plot ",i, " has no room left, dropped." )
				}
			}
		}
	} else {
		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename
				, width = widths[1], height = heights[1]
				, pointsize = pointsize
		)
		
		fun(...)
		dev.off()
		nbplots = maxid-id
		if( nbplots > 0 ){
			plotfiles = list.files( dirname , full.names = T )
			for( i in 1:length( plotfiles ) ){
				if( i <= nbplots ){
					out = rJava::.jcall( slide, "I", "addPicture", plotfiles[i] )
					if( isSlideError( out ) ){
						stop( getSlideErrorString( out , "png") )
					}
				} else { 
					warning("plot ",i, " has no room left, dropped." )
				}
			}
		}
	}
	doc
}

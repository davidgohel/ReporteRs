#' @title Add a plot into a docx object
#'
#' @description
#' Add a plot into the \code{docx} object.
#' 
#' @param doc the \code{docx} to use
#' @param fun plot function. The function will be executed to produce graphics. 
#' For \code{grid} or \code{lattice} or \code{ggplot} object, the function 
#' should just be print and an extra argument x should specify the object 
#' to plot. For traditionnal plots, the function should contain plot instructions. See examples.
#' @param width plot width in inches (default value is 6).
#' @param height plot height in inches (default value is 6).
#' @param vector.graphic logical scalar, default to FALSE. 
#' 
#' DrawingML instructions cannot be read by MS Word 2007. 
#' @param bookmark id of the Word bookmark to replace by the plot. optional.
#' 
#' \code{bookmark} is a character vector specifying bookmark id to replace by the plot(s).\cr 
#'   	If provided, plot(s) will replace the paragraph that contains the bookmark. See \code{\link{bookmark}}.\cr
#'   	If not provided, plot(s) will be added at the end of the document.
#' 
#' @param par.properties paragraph formatting properties of the paragraph that contains plot(s). An object of class \code{\link{parProperties}}
#' @param pointsize the default pointsize of plotted text in pixels, default to getOption("ReporteRs-fontsize").
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param editable logical value - if TRUE vector graphics elements (points, text, etc.) are editable.
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{\link{docx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addPlot_example.docx"
#' @example examples/docx.R
#' @example examples/addTitle1Level1.R
#' @example examples/addBasePlot_vg.R
#' @example examples/addTitle2Level1.R
#' @example examples/addggplot.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addPlot}}, \code{\link{bookmark}}.
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
		grDevices::png (filename = filename, 
				width = width, height = height, 
				units = 'in', pointsize = pointsize, res = 300
		)
		
		fun(...)
		dev.off()
	
		plotfiles = list.files( dirname , full.names = T )

		for( fi in seq_along( plotfiles ) ){
			if( !missing( bookmark ) && fi== 1 )
				doc = addImage( doc, filename = plotfiles[fi], 
						bookmark = bookmark )
			else if( missing( bookmark ) ) doc = addImage( doc, filename = plotfiles[fi] )
			else stop("bookmark can only be used when one single graph is inserted.")
		}
	

	} else {
		# one important and painful point is that shape ids must be unique 
		# in the whole document
		last_docx_elt_index = .jcall( doc$obj, "I", "getElementIndex") + 1L
		# start_id should be named last_id... 
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
		
		dev.off()
		

		.jcall( doc$obj, "V", "incrementElementIndex", as.integer( last_id - doc_elt_index + 1 ) )

		dims = as.integer( c( width*72.2 , height*72.2 )* 12700 )
		plotfiles = list.files( dirname , full.names = T )

		if( missing( bookmark ) ){
			for( fi in plotfiles ){
				dml.object = .jnew( class.DrawingML, fi )
				.jcall( dml.object, "V", "setWidth", as.integer( dims[1] ) )
				.jcall( dml.object, "V", "setHeight", as.integer( dims[2] ) )
				
				.jcall( doc$obj, "V", "add", dml.object, .jParProperties(par.properties) )
			}
		} else {
			if( length( plotfiles ) > 1 ) 
				warning("only one graph can be add to a bookmark")
			dml.object = .jnew( class.DrawingML, plotfiles[1] )
			.jcall( dml.object, "V", "setWidth", as.integer( dims[1] ) )
			.jcall( dml.object, "V", "setHeight", as.integer( dims[2] ) )
			.jcall( doc$obj, "V", "add", 
						dml.object, .jParProperties(par.properties), bookmark )
		}
	}

	doc
}


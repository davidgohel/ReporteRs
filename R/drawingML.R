#' @useDynLib ReporteRs
dml.docx <- function( file, width=504, height=504, offx = 0, offy = 0
	, ps=12, fontname= "Helvetica", editable = TRUE
	, firstid=1, env=new.env() ) {
	check.fontfamily(fontname)
#	assign("start_id", as.integer( firstid ), envir = env)
#	assign("editable", as.integer( editable ), envir = env)
	.Call("R_DOCX_Device", file, as.double(width), as.double(height)
			, as.double(offx), as.double(offy), as.double(ps), fontname 
			, as.integer( firstid ), as.integer( editable )
	)
	env
}

dml.pptx <- function( file, width=504, height=504, offx = 50, offy = 50
	, ps=12, fontname= "Helvetica", editable = TRUE
	, firstid=1, env=new.env() ) {
	check.fontfamily(fontname)
#	assign("start_id", as.integer( firstid ), envir = env)
#	assign("editable", as.integer( editable ), envir = env)
	.Call("R_PPTX_Device", file, as.double(width), as.double(height)
			, as.double(offx), as.double(offy), as.double(ps), fontname 
			, as.integer( firstid ), as.integer( editable )
	)
	env
}


raphael <- function( file, width=504, height=504, offx = 50, offy = 50, ps=12, fontname= "Helvetica", canvas_id=1, env=new.env()) {
	check.fontfamily(fontname)
	#assign("canvas_id", as.integer( canvas_id ), envir = env)
	assign("plot_ids", list(), envir = env)
	.Call("R_RAPHAEL_Device", file, as.double(width), as.double(height)
			, as.double(offx), as.double(offy), as.double(ps), fontname 
			, as.integer( canvas_id ), env
	)

	env
}

#' @title register Raphael plots
#'
#' @description register Raphael plots - internal use only
#' @param plot_attributes plot attributes
#' @param env environment
#' @export 
registerRaphaelGraph = function( plot_attributes, env ){
	# called from new_page - C code
	plot_ids = get("plot_ids" , envir = env )
	plot_attributes = as.list( plot_attributes )
	names( plot_attributes ) = c("filename", "js.plotid","div.id")
	plot_ids[[length( plot_ids ) + 1]] = plot_attributes
	assign("plot_ids", plot_ids, envir = env)
	invisible()
}

check.fontfamily = function( fontfamily ){
	font = .jnew("java/awt/Font", fontfamily, 0L, 12L )
	font_family = .jcall( font, "S", "getFamily" )
	if( font_family == "Dialog" )
		stop("Font ", fontfamily, " can't be found in available fonts on this machine.")
	invisible()
}




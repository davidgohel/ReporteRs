#' @useDynLib ReporteRs
dml.docx <- function( file, width=504, height=504, offx = 0, offy = 0
	, ps=12, fontname= "Helvetica", editable = TRUE
	, firstid=1, env=new.env() ) {
	check.fontfamily(fontname)
	assign("start_id", as.integer( firstid ), envir = env)
	assign("editable", as.integer( editable ), envir = env)
	.Call("R_DOCX_Device", file, as.double(width), as.double(height)
			, as.double(offx), as.double(offy), as.double(ps), fontname 
			, env
	)
	env
}

dml.pptx <- function( file, width=504, height=504, offx = 50, offy = 50
	, ps=12, fontname= "Helvetica", editable = TRUE
	, firstid=1, env=new.env() ) {
	check.fontfamily(fontname)
	assign("start_id", as.integer( firstid ), envir = env)
	assign("editable", as.integer( editable ), envir = env)
	.Call("R_PPTX_Device", file, as.double(width), as.double(height)
			, as.double(offx), as.double(offy), as.double(ps), fontname 
			, env
	)
	env
}


raphael <- function( file, width=504, height=504, offx = 50, offy = 50, ps=12, fontname= "Helvetica", canvas_id=1, env=new.env()) {
	check.fontfamily(fontname)
	assign("canvas_id", as.integer( canvas_id ), envir = env)
	assign("plot_ids", list(), envir = env)
	.Call("R_RAPHAEL_Device", file, as.double(width), as.double(height)
			, as.double(offx), as.double(offy), as.double(ps), fontname 
			, env
	)

	env
}




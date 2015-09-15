#' @useDynLib ReporteRs
dml.docx = function( file, width=504, height=504, offx = 0, offy = 0
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

dml.pptx = function( file, width=504, height=504, offx = 50, offy = 50
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


raphael = function( file, width=504, height=504, offx = 50, offy = 50, ps=12, fontname= "Helvetica", canvas_id=1, env=new.env()) {
	check.fontfamily(fontname)
	#assign("canvas_id", as.integer( canvas_id ), envir = env)
	assign("plot_ids", list(), envir = env)
	assign("element_ids", list(), envir = env)
	assign("post_commands", list(), envir = env)
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

#' @title add post plot commands
#'
#' @description internal use only
#' @param labels labels
#' @param ids ids
#' @param env environment
#' @export 
addPostCommand = function( labels, ids, env ){
	post_commands = get("post_commands" , envir = env )
	post_commands[[ length(post_commands) + 1 ]] = list( ids = ids, popup.labels = labels, len = length(ids) )
	assign("post_commands", post_commands, envir = env)
	invisible()
}

#' @title trigger post plot commands
#'
#' @description internal use only
#' @param env environment
#' @export 
triggerPostCommand = function( env ){
	post_commands = get("post_commands" , envir = env )	
	for( cmds in post_commands ){
		.C("add_popup", (dev.cur()-1L), as.integer(cmds$ids), as.character( cmds$popup.labels ), cmds$len )
	}
	assign("post_commands", list(), envir = env)
	invisible()
}

check.fontfamily = function( fontfamily, as.message = TRUE ){
	
	if( !is.character( fontfamily ) ){
		stop("fontfamily must be a single character.")
	} else if( length( fontfamily ) != 1 ) stop("fontfamily must be a single character.")
	
	font = .jnew(class.fontInfo)
	font_family = .jcall( font, "S", "getFontFamily", fontfamily )
	if( font_family == "Dialog" ){
		if( !as.message ) 
			stop("Font ", fontfamily, " can't be found in available fonts on this machine.")
		else 
			message("Font ", fontfamily, " can't be found in available fonts on this machine.")
	}
		
	invisible()
}


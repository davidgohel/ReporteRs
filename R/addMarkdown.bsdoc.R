#' @title Add a markdown text or file into an bsdoc object
#'
#' @description Add markdown into a \code{\link{bsdoc}} object.
#'
#' @param doc Object of class \code{\link{bsdoc}} where markdown has to be added
#' @param file markdown file. Not used if text is provided.
#' @param text character vector. The markdown text to parse.
#' @param text.properties default \code{\link{textProperties}} object
#' @param default.par.properties default \code{\link{parProperties}} object
#' @param blockquote.par.properties \code{\link{parProperties}} object used for
#' blockquote blocks.
#' @param code.par.properties \code{\link{parProperties}} object used for
#' code blocks.
#' @param hr.border \code{\link{borderProperties}} object used for
#' horizontal rules.
#' @param ... further arguments, not used.
#' @return an object of class \code{\link{bsdoc}}.
#' @details
#' You can configure backtick rendering (single or double backtick) with
#' options "ReporteRs-backtick-color" and "ReporteRs-backtick-shading-color".
#'
#' @examples
#' doc.filename = "addMarkdown_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addMarkdown.R
#' @example examples/writeDoc_file.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addMarkdown}}
#' @export
addMarkdown.bsdoc = function(doc, file, text,
	text.properties = textProperties( font.size = getOption("ReporteRs-fontsize") ),
	default.par.properties = parProperties(text.align = "justify"),
	blockquote.par.properties = parProperties(padding.top=0, padding.bottom=0, shading.color = "#eeeeee"),
	code.par.properties = parProperties(shading.color = "#eeeeee"),
	hr.border = borderSolid(width=2, color = "gray10"),
	... ) {

	if( !missing( file ) ){
		if( length( file ) != 1 ) stop("file must be a single filename.")
		if( !file.exists( file ) ) stop("file does not exist.")
	}

	if( missing( file ) ){
		markdown = paste( text, collapse = "\n" )
	} else {
		markdown = paste( scan( file = file, what = "character", sep = "\n", quiet = TRUE ), collapse = "\n" )
	}

	elt_table = get.blocks( markdown )

	footnotes_blocks = attr(elt_table, "footnotes" )
	footnotes = list()
	for(i in footnotes_blocks ){
		footnotes[[ i$id_ref[1] ]] = prepare.footnote(i,
				par.properties = default.par.properties,
				text.properties = text.properties )
	}
	attr(elt_table, "footnotes" ) = footnotes


	for(i in 1:nrow(elt_table) ){

		if( elt_table[ i, "block_type"]=="p" ){
			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], text.properties = text.properties,
					blocktable_info = elt_table )
			padding.left = default.par.properties$padding.left + guess.indentation(elt_table, i )*72
			doc = addParagraph( doc, value = pars,
				par.properties = chprop( default.par.properties, padding.left = padding.left )
				)
		} else if( elt_table[ i, "block_type"]=="blockquotes" ){
			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"],
					text.properties = text.properties,
					blocktable_info = elt_table )
			bq.par.properties = chprop( blockquote.par.properties,
					list.style = "blockquote",
					level = elt_table[ i, "blockquotes_level"] )
			doc = addParagraph( doc, value = pars, par.properties = bq.par.properties)
		} else if( elt_table[ i, "block_type"]=="code" ){
			.try = try( {doc = addRScript( doc, text = elt_table[ i, "text"], par.properties = code.par.properties )}, silent = FALSE )
			if( inherits( .try , "try-error") ){
				stop("invalid R script submitted")
			}
		} else if( elt_table[ i, "block_type"]=="list_item" ){
			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], text.properties = text.properties,
					blocktable_info = elt_table )
			doc = addParagraph( doc, value = pars,
					par.properties = chprop( default.par.properties,
							list.style = ifelse( elt_table[ i, "list_type"] == "ol", "ordered", "unordered" ),
							level = elt_table[ i, "level"]
					)
			)
		} else if( elt_table[ i, "block_type"]=="h" ){
#			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"],
#					text.properties = text.properties,
#					blocktable_info = elt_table )
			doc = addTitle( doc, value = elt_table[ i, "text"], level = elt_table[ i, "level"] )
		} else if( elt_table[ i, "block_type"]=="hr" ){
			doc = addParagraph( doc, value = "", par.properties = chprop( default.par.properties, border.bottom = hr.border) )
		}
	}

	doc
}

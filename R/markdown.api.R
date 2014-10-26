blockquotes_reg = "^\\s*(>\\s{1})+"
title_reg_atx = "^\\s*#{1,6}\\s+(.*)*#*"
title_reg_setext_firstlevel = "^(=)+(.*)*\\s*$"
title_reg_setext_secondlevel = "^(-)+(.*)*\\s*$"

ol_reg = "^\\s*[0-9]\\.\\s+(.*)*"
ul_reg = "^\\s*[\\*\\-]\\s+(.*)*"

hr_reg = "^(\\*{1}\\s{0,1}){3,}\\s*$|^(\\-{1}\\s{0,1}){3,}\\s*$|^(\\_{1}\\s{0,1}){3,}\\s*$"

reference_link_reg = "(( |\t)*\\[[[:alnum:]]+\\]\\:[[:blank:]]+[[:alnum:]\\s\\.\\:\\/#\\?\\=]+([[:blank:]]+(\"|'|\\()[[:alnum:][:blank:]\\s\\.\\:\\/#\\?\\=]+(\"|'|\\))){0,1})"


# qualify blocks and leave them at unqualified if further analysis is required
get.raw.blockmd = function( x ){
  
  out = character(1)
  if( length( x ) == 1 && regexpr(pattern = title_reg_atx, text = x) > 0 ){
    out = "title"
  } else if( length( x ) == 2 && regexpr(pattern = title_reg_setext_firstlevel, text = x[2]) > 0 ){
    out = "title"
  } else if( length( x ) == 2 && regexpr(pattern = title_reg_setext_secondlevel, text = x[2]) > 0 ){
    out = "title"
  } else if( regexpr(pattern = ol_reg, text = x[1]) > 0 ){
    out = "list"
  } else if( regexpr(pattern = ul_reg, text = x[1]) > 0 ){
    out = "list"
  } else if( regexpr(pattern = "( |\t)*\\[\\^[[:alnum:][:blank:]]+\\]\\:[[:blank:]]+", text = x[1]) > 0 ){
    out = "footnote"
  } else if( length( x ) == 1 && regexpr(pattern = hr_reg, text = x[1]) > 0 ){
    out = "hr"
  } else {
    out = "unqualified"
  }
  
  out
}


# count number of blanks at beginning of blocks
count.blanks = function ( x, first.only = FALSE ){
  
  if( first.only ){
    str = x[1]
  } else {
    str = x
  }
  
  nblanks = attr( regexpr( text = str, pattern = "^( )*" ), "match.length" )
  nbtabs = attr( regexpr( text = str, pattern = "^(\t)*" ), "match.length" )
  nblanks = nblanks + nbtabs * 4
  nblanks
}

# remove trailing blanks
rm.trailing.blanks = function( value ){
  value = gsub( "^(\\s)*$", "", value )
  value = gsub( "(\\s)*$", " ", value )
  value = gsub( "^(\\s)*", "", value )
  value
}





is.blockquotes = function( x, blank.ref = 0 ){
  nblanks = count.blanks( x, first.only = TRUE )
  if( nblanks > blank.ref ){
    return( FALSE )
  }
  if( !regexpr(pattern = blockquotes_reg, text = x[1]) > 0 ){
    return( FALSE )
  }
  return( TRUE )
}


is.code = function( x, blank.ref = 0 ){
  nblanks = count.blanks( x, first.only = FALSE )
  if( all( nblanks > ( blank.ref + 3 ) ) ){
    return( TRUE )
  }
  return( FALSE )
}

get.blockmd.data.template = function( n ){
  data.frame(
    list_type = character(n),
    list_index = integer(n),
    level = integer(n),
    indent = integer(n),
    blockquotes_level = integer(n),
    block_type = character(n),
    id_ref = character(n),
    text = character(n),
    stringsAsFactors = FALSE )
}

get.blockmd.hr = function(  ){
  
  out = get.blockmd.data.template( 1 )
  
  out$block_type = "hr"
  out
}

get.blockmd.title = function( x ){
  title_reg_atx = "^\\s*#{1,6}\\s+(.*)*#*"
  title_reg_setext_firstlevel = "^(=)+(.*)*\\s*$"
  title_reg_setext_secondlevel = "^(-)+(.*)*\\s*$"
  
  if( length( x ) == 1 && regexpr(pattern = title_reg_atx, text = x) > 0 ){
    .regex = regexpr(text = x, pattern = "^#{1,6}\\s{1}")
    if( .regex < 1 )
      stop("error while reading title level")
    level = attr( .regex, "match.length") - 1
    x = gsub( pattern = title_reg_atx, replacement = "\\1", x )
  } else if( length( x ) == 2 && regexpr(pattern = title_reg_setext_firstlevel, text = x[2]) > 0 ){
    x = x[1]
    level = 1
  } else if( length( x ) == 2 && regexpr(pattern = title_reg_setext_secondlevel, text = x[2]) > 0 ){
    x = x[1]
    level = 2
  }
  
  
  x = paste( rm.trailing.blanks(x), collapse = "" )
  
  out = get.blockmd.data.template( 1 )
  out$text = x
  out$level = level
  out$indent = 0
  out$block_type = "h"
  out
}

get.blockmd.code = function( value, blank.ref = 0 ){
  
  code_reg = paste0( "^\\s{", (blank.ref + 4), "}")
  
  # remove blanks at end of the line
  value = gsub( "(\\s)*$", "", value )
  value = gsub( code_reg, "", value )
  
  out = get.blockmd.data.template( 1 )
  out$text = paste0( value, collapse = "\n")
  out$indent = blank.ref
  out$block_type = "code"
  out
}

# structure blockquotes
get.blockmd.blockquotes = function( value, blank.ref = 0 ){
  
  blockquotes_reg = "^\\s*(>\\s{1})+"
  
  trim_value = rm.trailing.blanks( value )
  trim_value = gsub( "^\\s*(>\\s{1})+\\s*$", "", trim_value )
  
  bq_list = list( character(0) )
  orig_list = list( character(0) )
  curr_elt = 1
  for( i in 1:length( trim_value ) ){
    if( trim_value[i] != "" ){
      bq_list[[curr_elt]] = append( bq_list[[curr_elt]], trim_value[i] )
      orig_list[[curr_elt]] = append( orig_list[[curr_elt]], value[i] )
    } else {
      curr_elt = curr_elt + 1
      bq_list[[curr_elt]] = character(0)
      orig_list[[curr_elt]] = character(0)
    }
  }
  
  blocklevels = sapply( bq_list, function( x ){
    .reg = regexpr(text = x[1], pattern = "^(>\\s{1})+" )
    attr( .reg, "match.length" )
  } )
  blocklevels = blocklevels %/% 2
  
  bq = sapply( bq_list, function(x) {
    x = gsub( "^\\s*(>\\s{1})+", "", x )
    paste( x, collapse = "")
  })
  
  .lv = length( blocklevels )
  out = get.blockmd.data.template( .lv )
  out$blockquotes_level = blocklevels
  out$text = bq
  out$indent = blank.ref
  out$block_type = "blockquotes"
  out
}

get.blockmd.refnote = function( x ){
  
  pat = "\\[\\^([[:alnum:][:blank:]]+)\\]\\:"
  if( !str_detect(string = x[1], pattern = pat ) )
    stop("can not detect footnote id")
  
  reference = str_extract(string = x[1], pattern = pat )
  reference = gsub( "^\\[\\^", "", reference )
  reference = gsub( "\\]\\:$", "", reference )
  
  x[1] = str_replace( x[1], pattern = pat, replacement = "" )	
  
  indent = 0
  x = paste( rm.trailing.blanks(x), collapse = "" )
  out = get.blockmd.data.template( 1 )
  out$text = x
  out$id_ref = reference
  out$indent = indent
  out$block_type = "refnote"
  out
  
}

get.blockmd.paragraph = function( x, blank.ref = 0 ){
  indent = count.blanks( paste( x, collapse = "" ), first.only = FALSE )
  x = paste( rm.trailing.blanks(x), collapse = "" )
  out = get.blockmd.data.template( 1 )
  out$text = x
  out$indent = indent
  out$block_type = "p"
  out
}

get.blockmd.list.item = function( value, blank.ref ){
  
  l_reg = "^(\\s)*([0-9]\\.\\s+|[\\*\\-]\\s+)(.*)*"
  ol_reg = "^([0-9]\\.\\s+)"
  ul_reg = "^([\\*\\-]\\s+)"
  
  ipositions = regexpr( text = value, pattern = l_reg )
  
  last_id = length(value)
  
  cuts = which( ipositions > 0 )
  
  if( !is.element( last_id + 1 , cuts ) ){
    cuts = c( cuts, last_id + 1 )
  }
  
  treated_text = rm.trailing.blanks( value )
  
  cuts_str = paste0( "list(", paste( "seq( from = ", cuts[-length(cuts)], ", to = ", cuts[-1]-1, ", by = 1)", sep = "", collapse = "," ), ")" )
  li = sapply( eval( parse( text = cuts_str ) ), function( x , ref ) paste( ref[x], collapse = ""),
    ref = treated_text )
  
  nblanks = count.blanks( value[which( ipositions > 0 )], first.only = FALSE )
  isol = regexpr( text = li, pattern = ol_reg ) > 0
  isul = regexpr( text = li, pattern = ul_reg ) > 0
  
  levs = ( nblanks %/% 4 ) + 1
  levs[ !isol & !isul ] = NA
  
  index = rep( NA, length( nblanks ) )
  index[ isol ] = as.integer( gsub("^([0-9])+(.*)*", "\\1", li[ isol ] ) )
  
  text = gsub( l_reg , "\\3", li )
  
  types = rep("", length( text ) )
  
  types[isol] = "ol"
  types[isul] = "ul"
  
  out = get.blockmd.data.template( length( text ) )
  out$list_type = types
  out$level = levs
  out$list_index = index
  out$block_type = "list_item"
  out$text = text
  out$indent = nblanks
  out
}

get.blocks = function( value ){
  
  reference_links = unlist( str_extract_all(string = value, pattern = reference_link_reg ) )
  value = gsub(reference_link_reg, "", value )
  
  raw_blocks = gsub("^\\s*\n*", "", value )
  raw_blocks = gsub("\n\\s+\n", "\n\n", raw_blocks )
  
  pat_break = "(\n|\r){2,}"
  raw_blocks = unlist( strsplit( raw_blocks, pat_break ) )
  blocks = strsplit( raw_blocks, "(\n|\r){1}" )
  blocks = lapply( blocks, function(x) {
    x = gsub("[[:space:]]*$", " ", x )
    x
  })
  
  qualified_blocks = update.through.blocks(blocks)
  blocks = do.call( rbind, qualified_blocks )
  
  ##### add refnote to sub paragraph
  i = 1
  while(i < nrow(blocks) ){
    
    if( blocks[i, "block_type"]=="refnote" ){
      idref = blocks[i, "id_ref"]
      
      while( blocks[i+1, "indent"] > 0 && !is.element( blocks[i+1, "block_type"] , c("hr", "h") ) ){
        blocks[i+1, "id_ref"] = idref
        blocks[i+1, "indent"] = blocks[i+1, "indent"] - 4
        i = i + 1
      }
      i = i + 1
    } else i = i + 1
  }
  ###
  
  which.listfn = blocks$id_ref!="" & blocks$block_type=="list_item"
  blocks[ which.listfn, "level"] = blocks[ which.listfn, "level"] - 1
  
  footnotes = blocks[ blocks$id_ref!="", ]
  footnotes = split( footnotes, footnotes$id_ref )
  
  blocks = blocks[ blocks$id_ref == "", ]
  
  attr(blocks, "footnotes" ) = footnotes
  attr(blocks, "reference_link" ) = extract.reference.links( reference_links )
  blocks
}

extract.reference.links = function( x ){
  link_id = gsub( x = x, pattern = "^\\[(\\w+)\\](.*)*", replacement = "\\1" )
  url_reg = regexpr( x, pattern = "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+" )
  url_value = substring( text = x, url_reg, url_reg + attr(url_reg,"match.length") -1 )
  names(url_value) = link_id
  url_value
}


prepare.footnote = function( elt_table, par.properties, text.properties ){
  out = list()
  
  pars = get.paragraph.from.blockmd( text = elt_table[ 1, "text"], blocktable_info = elt_table,
    text.properties = text.properties )
  out[[1]] = list( fun = "addParagraph", args = list( value = pars, 
    par.properties = chprop( par.properties, padding.left = guess.indentation(elt_table, 1 )*72 )
  ) )
  if( nrow(elt_table) > 1 )
    for(i in 2:nrow(elt_table) ){
      if( elt_table[ i, "block_type"]=="p" ){
        pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], blocktable_info = elt_table,
          text.properties = text.properties )
        p.par.properties = chprop( par.properties, padding.left = guess.indentation(elt_table, i )*72 )
        out[[i]] = list( fun = "addParagraph", args = list( value = pars, par.properties = p.par.properties ) )
      } else if( elt_table[ i, "block_type"]=="blockquotes" ){
        pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], blocktable_info = elt_table,
          text.properties = text.properties )
        bq.par.properties = chprop( par.properties, border.left = borderDashed(),
          padding.top=0, padding.bottom=0, 
          shading.color = "#eeeeee", 
          list.style = "blockquote", 
          level = elt_table[ i, "blockquotes_level"],
          padding.left = guess.indentation(elt_table, i )*72 )
        out[[i]] = list( fun = "addParagraph", args = list( value = pars, par.properties = bq.par.properties ) )
      } else if( elt_table[ i, "block_type"]=="code" ){
        out[[i]] = list( fun = "addRScript", args = list( value = elt_table[ i, "text"], 
          par.properties = chprop( par.properties, padding.bottom = 0,
            padding.top = 0,
            shading.color = "grey95",
            padding.left = guess.indentation(elt_table, i )*72 ) 
        )
        )
      } else if( elt_table[ i, "block_type"]=="list_item" ){
        pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], blocktable_info = elt_table,
          text.properties = text.properties )
        out[[i]] = list( fun = "addParagraph", args = list( value = pars, 
          par.properties = chprop( par.properties,
            list.style = ifelse( elt_table[ i, "list_type"] == "ol", "ordered", "unordered" ),
            level = elt_table[ i, "level"]
          ) ) 
        )
      } 
    }
  out
}

set.text.format = function(textP, chunk ){
  font.weight = ifelse( attr(chunk,"spec")["bold"], "bold", "normal")
  font.style = ifelse( attr(chunk,"spec")["italic"], "italic", "normal")
  if( attr(chunk,"spec")["singlebacktick"] || attr(chunk,"spec")["doublebacktick"] )
    chprop(textP, font.weight = font.weight, font.style = font.style, shading.color = "gray90" )
  else chprop(textP, font.weight = font.weight, font.style = font.style )
}

guess.indentation = function( x, i ){
  if( x[i,"indent"] < 4 ){
    return(0)
  } else {
    
    list.options = getOption("ReporteRs-list-definition")
    
    level = x[i,"indent"] / 4
    
    for( n in seq(i-1, 1, by = -1) ){
      if( x[n, "list_type"] == "ul"){
        list.type = "ul"
        break; 
      }
      if( x[n, "list_type"] == "ol"){
        list.type = "ol"
        break; 
      }
    }
    
    left.name = paste0(list.type, ".left")
    hanging.name = paste0(list.type, ".hanging")
    out = list.options[[left.name]][level] + list.options[[hanging.name]][level]
    return( out )
  }
}


update.through.blocks = function( blocks, last.indent = 0, index = 1 ){
  nblanks = sapply( blocks, count.blanks, first.only = TRUE )
  types = sapply( blocks, get.raw.blockmd )
  
  goon = TRUE
  blank.ref = 0
  attr( blocks, "reference_link" ) = list()
  while( index <= length( blocks ) ){
    block = blocks[[index]]
    
    if( types[index] == "title" ) {
      blocks[[index]] = get.blockmd.title( block )
      blank.ref = 0
    } else if( types[index] == "list") {
      blocks[[index]] = get.blockmd.list.item( block, blank.ref = blank.ref )
      blank.ref = tail(blocks[[index]], n = 1)$indent + 4
    } else if( types[index] == "hr") {
      blocks[[index]] = get.blockmd.hr(  )
      blank.ref = 0
    } else if( types[index] == "footnote") {
      blocks[[index]] = get.blockmd.refnote( block )
      blank.ref = 4
    } else {              
      if( is.blockquotes( block, blank.ref = blank.ref ) ){
        blocks[[index]] = get.blockmd.blockquotes( block, blank.ref = blank.ref )
      } else if( is.code( block, blank.ref = blank.ref ) ){
        blocks[[index]] = get.blockmd.code( block  )
      } else {
        blocks[[index]] = get.blockmd.paragraph( block )
      }
    }
    index = index + 1         
  }
  blocks
}


get.paragraph.from.blockmd = function( text, blocktable_info, text.properties = textProperties() ){
  
  Span = .jnew("org/lysis/markdown/tools/Span" , text )
  character_dataset = data.frame( text = substring(text, seq_len(nchar(text)), seq_len(nchar(text)) ),
    stringsAsFactors = F )
  types_matrix = matrix( .jcall( Span, "[Z", "getEmphasisMatrix"), ncol = 9 ,
    dimnames = list( NULL, 
      c("bold", "singlebacktick", "doublebacktick", "italic", 
        "inline_link", "reference_link", 
        "inline_img", "reference_img", "footnote"
      ) ) )
  types_matrix[types_matrix[,"inline_img"], "inline_link"]=FALSE
  
  character_dataset = cbind( character_dataset, types_matrix)
  
  drop_lines_id = integer(0)
  
  cmp_rle = rle( character_dataset$bold )
  llre = length(cmp_rle[[2]])
  idx = 1
  for( i in 1:llre ){
    if( cmp_rle[[2]][i] ){
      drop_lines_id = c( drop_lines_id, idx, idx + 1, (idx+cmp_rle[[1]][i])-2, (idx+cmp_rle[[1]][i])-1 )
    }
    idx = idx + cmp_rle[[1]][i]
  }
  
  cmp_rle = rle( character_dataset$doublebacktick )
  llre = length(cmp_rle[[2]])
  idx = 1
  for( i in 1:llre ){
    if( cmp_rle[[2]][i] ){
      drop_lines_id = c( drop_lines_id, idx, idx + 1, (idx+cmp_rle[[1]][i])-2, (idx+cmp_rle[[1]][i])-1 )
    }
    idx = idx + cmp_rle[[1]][i]
  }
  
  cmp_rle = rle( character_dataset$singlebacktick )
  llre = length(cmp_rle[[2]])
  idx = 1
  for( i in 1:llre ){
    if( cmp_rle[[2]][i] ){
      drop_lines_id = c( drop_lines_id, idx, (idx+cmp_rle[[1]][i])-1 )
    }
    idx = idx + cmp_rle[[1]][i]
  }
  
  cmp_rle = rle( character_dataset$italic )
  llre = length(cmp_rle[[2]])
  idx = 1
  for( i in 1:llre ){
    if( cmp_rle[[2]][i] ){
      drop_lines_id = c( drop_lines_id, idx, (idx+cmp_rle[[1]][i])-1 )
    }
    idx = idx + cmp_rle[[1]][i]
  }
  if( length(drop_lines_id )> 0 ){
    types_matrix = types_matrix[-drop_lines_id,]
    character_dataset = character_dataset[-drop_lines_id,]
  }
  
  compar_str = apply( types_matrix, 1, function(x) paste( ifelse(x, "1", "0"), collapse = "" ) )
  cmp_rle = rle( compar_str )
  llre = length(cmp_rle[[2]])
  idx = 1
  chunks = list()
  for( i in 1:llre ){
    idstart = idx
    idend = (idx -1 +cmp_rle[[1]][i])
    chunks[[i]] = paste( character_dataset$text[idstart:idend], collapse = "" )
    attr( chunks[[i]], "spec" ) = types_matrix[idstart,]
    idx = idx + cmp_rle[[1]][i]
  }
  
  chunks = lapply( chunks, function( chunk ){
    if( attr(chunk,"spec")["inline_link"] ){
      text = gsub( "\\[([[:alnum:][:blank:]]*)\\].*", "\\1", chunk )
      link = gsub( ".*\\(([[:alnum:]\\s\\.\\:\\/#\\?\\=]*)\\)", "\\1", chunk )
      tp = set.text.format(text.properties, chunk )
      pot( value = text, format = chprop(tp, underline = TRUE ), 
        hyperlink = link )
    } else if( attr(chunk,"spec")["reference_link"] ){
      text = gsub( "\\[([[:alnum:][:blank:]]*)\\].*", "\\1", chunk )
      link = gsub( ".*\\[([[:alnum:][:blank:]]*)\\].*", "\\1", chunk )
      link = attr(blocktable_info, "reference_link")[link]
      tp = set.text.format(text.properties, chunk )
      pot( value = text, format = chprop(tp, underline = TRUE ), 
        hyperlink = link )
    } else if( attr(chunk,"spec")["footnote"] ){
      fnid = substring( chunk, 3, nchar(chunk) - 1 )
      fn_obj = attr(blocktable_info, "footnotes" )[[fnid]]
      fn.pars = lapply( fn_obj, function( x ) {
        if( x$fun == "addParagraph" ) x$args$value 
        else NULL
      } )
      fn = Footnote( do.call( set_of_paragraphs , fn.pars ),
        par.properties = parProperties() )
      pot( value = "", 
        format = chprop( text.properties, vertical.align = "superscript" ), 
        footnote = fn )
    } else if( attr(chunk,"spec")["inline_img"] ){
      pot( value = " [images not supported] " )
    } else if( !any(attr(chunk,"spec")[5:8]) ){
      pot( value = as.character(chunk), format = set.text.format(text.properties, chunk ) )
    } else chunk
  })
  for(i in 1:length( chunks ) ){
    if( i == 1 ) out = chunks[[i]]
    else out = out + chunks[[i]]
  }
  out
}


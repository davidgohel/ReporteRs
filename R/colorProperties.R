#' @title color properties object
#'
#' @description create a color properties object.
#'
#' @param value valid color
#' @export
colorProperties = function( value = "black" ){

  stopifnot( is.color( value ) )
  col_spec <- col2rgb(value, alpha = TRUE )
  out = list( r = col_spec[1, 1], g = col_spec[2, 1],
              b = col_spec[3, 1], a = col_spec[4, 1] )
  class( out ) = "colorProperties"
  out
}

get_color_compounds = function( values = "black" ){

  if( any( !is.color(values) ) ){
    stop("values must be valid colors.")
  }

  col_spec <- col2rgb(values, alpha = TRUE )
  out = list( r = col_spec[1, ], g = col_spec[2, ],
              b = col_spec[3, ], a = col_spec[4, ] )
  out
}

#' @export
#' @rdname colorProperties
#' @param x a colorProperties object
#' @param ... unused
print.colorProperties = function( x, ... ){
  cat(as.character(x), "\n")
  invisible()
}

#' @export
#' @rdname colorProperties
as.character.colorProperties = function( x, ... ){
  paste0("rgba(", x$r, ",", x$g, ",", x$b, ",", sprintf(fmt = "%.2f" , x$a/255), ")" )
}

.jcolorProperties = function( object ){
  .jnew(class.text.Color, object$r, object$g, object$b, object$a )
}


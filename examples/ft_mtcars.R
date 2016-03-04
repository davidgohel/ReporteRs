# ft_mtcars ------------

# properties to use later
header_cell <- cellProperties( background.color = "#00557F" )
header_par <- parCenter(padding = 2 )
header_text <- textBold( color = "white", font.size = 11 )
body_text <- textProperties( font.size = 10 )
body_par <- parLeft( padding = 2 )

inner_border = borderSolid( color="#0070A8" )
outer_border <- borderSolid( color = "#006699", width = 2 )


# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body
ft_mtcars <- FlexTable( data = mtcars, add.rownames = TRUE,
  header.cell.props = header_cell, header.text.props = header_text,
  header.par.props = header_par, body.par.props = body_par,
  body.text.props = body_text )

# zebra stripes - alternate colored backgrounds on table rows
ft_mtcars <- setZebraStyle( ft_mtcars, odd = "#E1EEf4", even = "white" )

# applies a border grid on table
ft_mtcars <- setFlexTableBorders( ft_mtcars,
  inner.vertical = inner_border, inner.horizontal = borderNone(),
  outer.vertical = outer_border, outer.horizontal = outer_border )

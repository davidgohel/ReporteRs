textProp = textProperties()

textProp01 = chprop( textProp, color = "red" )
textProp02 = chprop( textProp, font.size = 12 )
textProp03 = chprop( textProp, font.weight = "bold" )
textProp04 = chprop( textProp, font.style = "italic" )
textProp05 = chprop( textProp, underlined = TRUE )
\dontrun{
textProp06 = chprop( textProp, font.family = "Arial" )
}
textProp07 = chprop( textProp, vertical.align = "superscript" )

textProp08 = chprop( textProp, font.size = 12, 
	font.weight = "bold", shading.color = "red" )

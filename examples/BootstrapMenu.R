mymenu = BootstrapMenu( title = "my title")

mydd = DropDownMenu( label = "Mon menu" )
mydd = addLinkItem( mydd, 
	label = "GitHub", "http://github.com/")
mydd = addLinkItem( mydd, separator.after = TRUE)
mydd = addLinkItem( mydd, 
	label = "Wikipedia", "http://www.wikipedia.fr")

mymenu = addLinkItem( mymenu, 
	label = "ReporteRs", "http://github.com/davidgohel/ReporteRs")
mymenu = addLinkItem( mymenu, dd = mydd )

library( ReporteRs )

doc = bsdoc( title = "my document" )

mymenu = BoostrapMenu( title = "my title")

mydd = DropDownMenu( label = "Mon menu" )
mydd = addLinkItem( mydd, label = "GitHub", "http://github.com/")
mydd = addLinkItem( mydd, separator.after = TRUE)
mydd = addLinkItem( mydd, label = "Wikipedia", "http://www.wikipedia.fr")

mymenu = addLinkItem( mymenu, label = "ReporteRs", "http://github.com/davidgohel/ReporteRs")
mymenu = addLinkItem( mymenu, dd = mydd )

doc = addBootstrapMenu( doc, mymenu )

pages = writeDoc( doc, file = "addBoostrapMenu_example/example.html")

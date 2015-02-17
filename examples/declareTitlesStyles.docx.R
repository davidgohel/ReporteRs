styles( doc )
# [1] "Normal"                  "Title1"                  "Title2"
# [4] "Title3"                  "Title4"                  "Title5"
# [7] "Title6"                  "Title7"                  "Title8"
#[10] "Title9"                  "Defaut"                  ...
doc = declareTitlesStyles(doc
	, stylenames = c("Titre1", "Titre2", "Titre3"
		, "Titre4", "Titre5", "Titre6", "Titre7", "Titre8", "Titre9" ) )
doc = addTitle( doc, "title 1", 1 )

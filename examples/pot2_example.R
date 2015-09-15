
# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) ) + 
  " and " + 
  pot("dogs", textProperties( color = "blue" ), 
    hyperlink = "http://www.wikipedia.org/" )

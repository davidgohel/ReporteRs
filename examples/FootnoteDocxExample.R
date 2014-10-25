## docx example 
doc = docx( )

par1 = pot("About this reference", textBold( ) )
par2 = pot("Omni ab coalitos pro malivolus obsecrans graviter 
cum perquisitor perquisitor pericula saepeque inmunibus coalitos ut.", 
	textItalic(font.size = 8) )

Footnote1 = Footnote( set_of_paragraphs( par1, par2 ), 
	par.properties = parProperties(text.align = "justify") )

pot5 = pot("This is another reference" )
Footnote2 = Footnote( pot5, 
	par.properties = parProperties(text.align = "center") )

doc = addTitle( doc, "Title example 1", level = 1 )

pot1 = "Hae duae provinciae " + pot("bello", 
	footnote = Footnote1, format = textBold(color="blue")
) + " quondam piratico catervis mixtae praedonum a Servilio pro consule missae sub 
iugum factae sunt vectigales. et hae quidem regiones velut in prominenti terrarum 
lingua positae ob orbe eoo monte Amano disparantur."

pot2 = pot("Latius iam disseminata licentia onerosus bonis omnibus Caesar nullum 
post haec adhibens modum orientis latera cuncta vexabat nec honoratis parcens 
nec urbium primatibus nec plebeiis." ) + pot(" Here is another note.", footnote = Footnote2)


# Add my.pars into the document doc
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )

docx.file = "footnote.docx"

writeDoc( doc, file = docx.file )

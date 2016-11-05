\donttest{
## docx example
doc = docx( )

par1 = pot("About this reference", textBold( ) )
par2 = pot("Omni ab coalitos pro malivolus obsecrans graviter
cum perquisitor perquisitor pericula saepeque inmunibus coalitos ut.",
	textItalic(font.size = 8) )

Footnote1 = Footnote( )
Footnote1 = addParagraph( Footnote1, set_of_paragraphs( par1, par2 ),
	parProperties(text.align = "justify"))
Footnote1 = addParagraph( Footnote1,
	set_of_paragraphs( "list item 1", "list item 2" ),
	parProperties(text.align = "left", list.style = "ordered"))
an_rscript = RScript( par.properties = parProperties(shading.color = "gray90"),
	text = "ls()
x = rnorm(10)" )
Footnote1 = addParagraph( Footnote1, an_rscript,
	parProperties(text.align = "left"))


Footnote2 = Footnote(  )
Footnote2 = addParagraph( Footnote2, pot("This is another reference" ),
	par.properties = parProperties(text.align = "center"))

doc = addTitle( doc, "Title example 1", level = 1 )

pot1 = "Hae duae provinciae " + pot("bello",
	footnote = Footnote1 ) + " quondam piratico catervis mixtae
praedonum a Servilio pro consule missae sub
iugum factae sunt vectigales. et hae quidem regiones velut in prominenti
lingua positae ob orbe eoo monte Amano disparantur."

pot2 = pot("Latius iam disseminata licentia onerosus bonis Caesar
post haec adhibens modum orientis latera cuncta vexabat nec honoratis
nec urbium primatibus nec plebeiis." ) + pot(" Here is another note.",
  footnote = Footnote2)


# Add my.pars into the document doc
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )

docx.file = "footnote.docx"

writeDoc( doc, file = docx.file )
}

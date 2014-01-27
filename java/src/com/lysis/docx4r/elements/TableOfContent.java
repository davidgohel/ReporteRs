package com.lysis.docx4r.elements;


import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;

import org.docx4j.jaxb.Context;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.openpackaging.parts.relationships.Namespaces;
import org.docx4j.wml.FldChar;
import org.docx4j.wml.ObjectFactory;
import org.docx4j.wml.P;
import org.docx4j.wml.R;
import org.docx4j.wml.STFldCharType;
import org.docx4j.wml.Text;

public class TableOfContent {
	private static ObjectFactory factory = Context.getWmlObjectFactory();

	public static void addTableOfContents(MainDocumentPart documentPart) {
		Context.getWmlObjectFactory();

		P paragraph = factory.createP();
		addFieldBegin(paragraph);
		addTableOfContentsField(paragraph, "TOC \\o \"1-3\" \\h \\z \\u");
		addFieldEnd(paragraph);
		documentPart.getJaxbElement().getBody().getContent().add(paragraph);
	}
	public static void addTableOfContents(MainDocumentPart documentPart, String stylename) {
		Context.getWmlObjectFactory();
		P paragraph = factory.createP();
		addFieldBegin(paragraph);
		addTableOfContentsField(paragraph, "TOC \\h \\z \\t \"" + stylename + ";1\"");
		addFieldEnd(paragraph);
		documentPart.getJaxbElement().getBody().getContent().add(paragraph);
	}

	private static void addTableOfContentsField(P paragraph, String expr) {
		R run = factory.createR();
		Text txt = new Text();
		txt.setSpace("preserve");
		txt.setValue( expr );
		run.getContent().add(factory.createRInstrText(txt));
		paragraph.getContent().add(run);
	}

	//TOC \h \z \t "Légende" \c
	private static void addFieldBegin(P paragraph) {
		R run = factory.createR();
		FldChar fldchar = factory.createFldChar();
		fldchar.setFldCharType(STFldCharType.BEGIN);
		fldchar.setDirty(true);
		run.getContent().add(getWrappedFldChar(fldchar));
		paragraph.getContent().add(run);
	}

	private static void addFieldEnd(P paragraph) {
		R run = factory.createR();
		FldChar fldcharend = factory.createFldChar();
		fldcharend.setFldCharType(STFldCharType.END);
		run.getContent().add(getWrappedFldChar(fldcharend));
		paragraph.getContent().add(run);
	}


	public static JAXBElement<FldChar> getWrappedFldChar(FldChar fldchar) {
		return new JAXBElement<FldChar>(
				new QName(Namespaces.NS_WORD12, "fldChar"), FldChar.class, fldchar);
	}

}
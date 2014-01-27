package com.lysis.docx4r.elements;

import java.util.LinkedHashMap;

import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.wml.P;
import org.docx4j.wml.R;
import org.docx4j.wml.RPr;
import org.docx4j.wml.Text;

import com.lysis.docx4r.tools.Format;


public class POT {

	private String style;
	private MainDocumentPart mdp;
	private LinkedHashMap<Integer, P> pList;
	private int index;

	public POT(WordprocessingMLPackage doc, String stylename){
		style = stylename;
		mdp = doc.getMainDocumentPart();
		pList = new LinkedHashMap<Integer, P>();
		index = -1;

	}
	public void addP ( ){
		index++;
		P p = mdp.createStyledParagraphOfText(style, "");
		pList.put(index, p);
	}
	public void addPot ( String value, int size, boolean bold, boolean italic, boolean underlined, String color, String fontfamily ){
		P p = pList.get(index);

		R run = new R();
		Text text = new Text();
		text.setValue( value );
		text.setSpace("preserve");
		run.getContent().add(text);
		RPr rpr = Format.getTextProperties(color, size, bold, italic, underlined, fontfamily);
		run.setRPr(rpr);
		p.getContent().add(run);
	}
	
	public void addText ( String value ){
		P p = pList.get(index);
		R run = new R();
		Text text = new Text();
		text.setValue( value );
		text.setSpace("preserve");
		run.getContent().add(text);
		p.getContent().add(run);
	}
	
	public int getLength(){
		return index + 1;
	}
	
	public P getP( int i) {
		return pList.get(i);
	}

}

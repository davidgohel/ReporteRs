package com.lysis.docx4r.elements;

import org.docx4j.wml.Br;
import org.docx4j.wml.P;

import org.docx4j.wml.STBrType;

public class PageBreak {

	/**
	 * @param args
	 */
	public static P getBreak(){
		P p = new P();
		Br br = new Br();
		br.setType(STBrType.PAGE); 
		p.getContent().add(br);
		return p;
		
	}

}

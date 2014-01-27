package com.lysis.pptx4r.elements;

import javax.xml.bind.JAXBException;

import org.docx4j.dml.CTRegularTextRun;

public class Utils {
	public static CTRegularTextRun getRun( String text ) throws JAXBException{
		CTRegularTextRun ct = new CTRegularTextRun();
		ct.setT(text);
		return ct;
	}

}

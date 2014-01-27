package com.lysis.pptx4r.elements;

import java.util.LinkedHashMap;
import java.util.List;

import org.docx4j.XmlUtils;
import org.docx4j.dml.CTRegularTextRun;
import org.docx4j.dml.CTTextCharacterProperties;
import org.docx4j.dml.CTTextParagraph;
import org.pptx4j.jaxb.Context;
import org.pptx4j.pml.Shape;

import com.lysis.pptx4r.tools.Format;


public class POT {
	private static String SAMPLE_SHAPE_START =                         
            "<p:sp xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:p=\"http://schemas.openxmlformats.org/presentationml/2006/main\">"
            + "<p:nvSpPr>"
	            + "<p:cNvPr id=\"${id_shape}\" name=\"Title ${title_shape}\" />"
		            + "<p:cNvSpPr>"
		                    + "<a:spLocks noGrp=\"${noGrp}\" />"
		            + "</p:cNvSpPr>"
	            + "<p:nvPr>"
                    + "<p:ph idx=\"${idx}\"/>"//+ "<p:ph idx=\"${idx}\" ${size}/>"
	            + "</p:nvPr>"
		    + "</p:nvSpPr>"
		    + "<p:spPr>"
		      + "<a:xfrm>"
		        + "<a:off x=\"0\" y=\"0\"/>"
		        + "<a:ext cx=\"0\" cy=\"0\"/>"
		      + "</a:xfrm>"
		    + "</p:spPr>"
		    + "<p:txBody>"
	            + "<a:bodyPr />";
	private static String SAMPLE_SHAPE_END = "</p:txBody>" + "</p:sp>";
	
	//private P p;
	private LinkedHashMap<Integer, CTTextParagraph> pList;
	private int index;
	
	public POT(){
		pList = new LinkedHashMap<Integer, CTTextParagraph>();
		index = -1;
	}

	public void addP ( ){
		index++;
		CTTextParagraph p = new CTTextParagraph();
		pList.put(index, p);
	}
	
	public void addPot ( String value, int size, boolean bold, boolean italic, boolean underlined, String color, String fontfamily ){
		CTTextParagraph p = pList.get(index);
		CTRegularTextRun textRun = new CTRegularTextRun();
		
		textRun.setT(value);
		
		CTTextCharacterProperties rpr;
		try {
			rpr = Format.getTextProperties(color, size, bold, italic, underlined, fontfamily);
			textRun.setRPr(rpr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		p.getEGTextRun().add(textRun);
	}
	
	public void addText ( String value ){
		CTTextParagraph p = pList.get(index);
		CTRegularTextRun textRun = new CTRegularTextRun();
		textRun.setT(value);
		p.getEGTextRun().add(textRun);

	}

	private CTTextParagraph getP( int i) {
		return pList.get(i);
	}
	public Shape getShape(long shape_id, long idx) throws Exception{

		java.util.HashMap<String, String>mappings = new java.util.HashMap<String, String>();
        mappings.put("id_shape", shape_id + "" );
        mappings.put("title_shape", "Texts" + shape_id);
        mappings.put("idx", idx+"" );
        mappings.put("noGrp", "1" );

        Shape o = (Shape) XmlUtils.unmarshallFromTemplate(SAMPLE_SHAPE_START + "<a:p/>" + SAMPLE_SHAPE_END, mappings,Context.jcPML, Shape.class);        
        
        List<CTTextParagraph> p = o.getTxBody().getP();
        p.clear();
        for(int i = 0 ; i <= index ; i++){
        	CTTextParagraph text = getP(i);
        	p.add(text);
        }
		return o;
	}
}

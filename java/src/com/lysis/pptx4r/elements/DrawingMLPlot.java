package com.lysis.pptx4r.elements;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.List;

import org.pptx4j.jaxb.Context;
import org.pptx4j.pml.Sld;

//"<p:cNvSpPr><a:spLocks noSelect=\"0\" noResize=\"0\" noEditPoints=\"0\" noMove=\"1\" noRot=\"1\" noChangeShapeType=\"1\"/></p:cNvSpPr><p:nvPr /></p:nvSpPr>";

public class DrawingMLPlot {
	private String filename;
	private static String slidebase=
			"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
					+ "<p:sld xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" "
						+ "xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" "
						+ "xmlns:p=\"http://schemas.openxmlformats.org/presentationml/2006/main\" >"
						+ "<p:cSld><p:spTree>"

						+ "<p:nvGrpSpPr>"
							+ "<p:cNvPr id=\"${id_shape}\" name=\"Plot ${id_shape}\" />"
							+ "<p:cNvGrpSpPr><a:grpSpLocks noResize=\"1\" noUngrp=\"1\" noChangeAspect=\"1\" /></p:cNvGrpSpPr>"
							+ "<p:nvPr />"
						+ "</p:nvGrpSpPr>"
						+ "<p:grpSpPr>"
							+ "<a:xfrm>"
								+ "<a:off x=\"0\" y=\"0\" />"
								+ "<a:ext cx=\"0\" cy=\"0\" />"
								+ "<a:chOff x=\"0\" y=\"0\" />"
								+ "<a:chExt cx=\"0\" cy=\"0\" />"
							+ "</a:xfrm>"
						+ "</p:grpSpPr>"
						+ "<p:grpSp>"
							+ "<p:nvGrpSpPr>"
								+ "<p:cNvPr id=\"${id_properties}\" name=\"Groupe ${id_properties}\" />"
								+ "<p:cNvGrpSpPr />"
								+ "<p:nvPr />"
							+ "</p:nvGrpSpPr>"
							+ "<p:grpSpPr>"
								+ "<a:xfrm>"
									+ "<a:off x=\"${offx}\" y=\"${offy}\" />"
									+ "<a:ext cx=\"${cx}\" cy=\"${cy}\" />"
									+ "<a:chOff x=\"${offx}\" y=\"${offy}\" />"
									+ "<a:chExt cx=\"${cx}\" cy=\"${cy}\" />"
								+ "</a:xfrm>"
							+ "</p:grpSpPr>"
						+ "${content}"
						+ "</p:grpSp>"						
	
						+ "</p:spTree></p:cSld>"
			+ "</p:sld>";
	
	
	public DrawingMLPlot(String filename) throws Exception{
		this.filename=filename;

	}

	public List<Object> getShape(long idx, long shape_id, long offx, long offy, long cx, long cy) throws Exception{

		String sCurrentLine;
		String data="";
		
		BufferedReader br = new BufferedReader(new FileReader(filename));
		while ((sCurrentLine = br.readLine()) != null) {
			data = data + sCurrentLine;
		}
		br.close();
		
		java.util.HashMap<String, String>mappings = new java.util.HashMap<String, String>();
        mappings.put("content", data );
        mappings.put("id_shape", shape_id + "" );
        mappings.put("id_properties", idx + "" );
        mappings.put("offx", offx + "" );
        mappings.put("offy", offy + "" );
        mappings.put("cx", cx + "" );
        mappings.put("cy", cy + "" );
        Sld o = (Sld)org.docx4j.XmlUtils.unmarshallFromTemplate(slidebase, mappings, Context.jcPML, Sld.class) ;
		return o.getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame();
		}
}

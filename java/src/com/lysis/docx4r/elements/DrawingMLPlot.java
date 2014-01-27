package com.lysis.docx4r.elements;

import java.io.BufferedReader;
import java.io.FileReader;

import javax.xml.bind.JAXBException;

import org.docx4j.XmlUtils;
import org.docx4j.jaxb.Context;
import org.docx4j.wml.Drawing;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.R;


public class DrawingMLPlot {
	
	private String filename;
	
	public DrawingMLPlot(String filename) throws Exception{
		this.filename=filename;
	}
	
//	private static String base=
//			"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
//					+ "<w:p xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:w10=\"urn:schemas-microsoft-com:office:word\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" xmlns:w15=\"http://schemas.microsoft.com/office/word/2012/wordml\" xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" mc:Ignorable=\"w14 w15 wp14\" ><w:r>"
//					  + "<w:rPr/>"
//					  + "<mc:AlternateContent><mc:Choice Requires=\"wpc\">"
//					  	+ "<w:drawing>"
//					  	//+ "<w:drawing xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:w10=\"urn:schemas-microsoft-com:office:word\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" xmlns:w15=\"http://schemas.microsoft.com/office/word/2012/wordml\" xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" mc:Ignorable=\"w14 w15 wp14\" >"
//							+ "<wp:inline distT=\"0\" distB=\"0\" distL=\"0\" distR=\"0\">"
//								+ "<wp:extent cx=\"${cx}\" cy=\"${cy}\" />"
//								+ "<wp:effectExtent l=\"0\" t=\"0\" r=\"0\" b=\"0\" />"
//								+ "<wp:docPr id=\"${id}\" name=\"Zone de dessin ${id}\" />"
//								+ "<wp:cNvGraphicFramePr>"
//										+ "<a:graphicFrameLocks xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" noChangeAspect=\"1\" />"
//								+ "</wp:cNvGraphicFramePr>"
//								+ "<a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">"
//									+ "<a:graphicData uri=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\">"
//										+ "<wpc:wpc>"
//											+ "<wpc:bg />"
//											+ "<wpc:whole />"
//											+ "${content}"
//										+ "</wpc:wpc>"
//									+ "</a:graphicData>"
//								+ "</a:graphic>"
//							+ "</wp:inline>"
//						+ "</w:drawing>"
//					+ "</mc:Choice><mc:Fallback>"
//					+ "<w:p><w:r></w:r></w:p></mc:Fallback></mc:AlternateContent>"
//					+ "</w:r></w:p>"
//					;
	
	private static String base = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
	  	+ "<w:drawing xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:w10=\"urn:schemas-microsoft-com:office:word\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" xmlns:w15=\"http://schemas.microsoft.com/office/word/2012/wordml\" xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" mc:Ignorable=\"w14 w15 wp14\" >"
			+ "<wp:inline distT=\"0\" distB=\"0\" distL=\"0\" distR=\"0\">"
				+ "<wp:extent cx=\"${cx}\" cy=\"${cy}\" />"
				//+ "<wp:effectExtent l=\"0\" t=\"0\" r=\"0\" b=\"0\" />"
				+ "<wp:docPr id=\"${id}\" name=\"Zone de dessin ${id}\" />"
				+ "<wp:cNvGraphicFramePr/>"
				+ "<a:graphic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\">"
					+ "<a:graphicData uri=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\">"
						+ "<wpg:wgp>"
							+ "<wpg:cNvGrpSpPr />"
							+ "<wpg:grpSpPr>"
								+ "<a:xfrm>"
									+ "<a:off x=\"0\" y=\"0\" />"
									+ "<a:ext cx=\"${cx}\" cy=\"${cy}\" />"
									+ "<a:chOff x=\"0\" y=\"0\" />"
									+ "<a:chExt cx=\"${cx}\" cy=\"${cy}\" />"
								+ "</a:xfrm>"
								+ "</wpg:grpSpPr>"
								+ "${content}"
						+ "</wpg:wgp>"
					+ "</a:graphicData>"
				+ "</a:graphic>"
			+ "</wp:inline>"
		+ "</w:drawing>";
	
	public P getP(long cx, long cy, long id, PPr ppr) throws JAXBException, Exception{
		
		String sCurrentLine;
		String data="";
		
		BufferedReader br = new BufferedReader(new FileReader(filename));
		while ((sCurrentLine = br.readLine()) != null) {
			data = data + sCurrentLine;
		}
		br.close();

		
		java.util.HashMap<String, String>mappings = new java.util.HashMap<String, String>();
        mappings.put("cx", cx + "" );
        mappings.put("cy", cy + "");
        mappings.put("id", id + "" );
        mappings.put("content", data );
        
        Drawing o = (Drawing) XmlUtils.unmarshallFromTemplate(base, mappings,Context.jc, Drawing.class);

        P p = new P();
        R r = new R();
        r.getContent().add(o);
        p.getContent().add(r);
        p.setPPr(ppr);
		return p;
	}
}

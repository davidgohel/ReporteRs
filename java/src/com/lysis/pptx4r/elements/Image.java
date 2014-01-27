package com.lysis.pptx4r.elements;

import java.io.File;

import org.docx4j.openpackaging.packages.PresentationMLPackage;
import org.docx4j.openpackaging.parts.PresentationML.SlidePart;
import org.docx4j.openpackaging.parts.WordprocessingML.BinaryPartAbstractImage;
import org.docx4j.relationships.Relationship;
import org.pptx4j.jaxb.Context;
import org.pptx4j.pml.Pic;

public class Image {

	static private String PICTURE = 
			"<p:pic xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:p=\"http://schemas.openxmlformats.org/presentationml/2006/main\"> "
		    + "<p:nvPicPr>"
		      + "<p:cNvPr id=\"${element_id}\" name=\"Picture ${element_id}\" />"
		      + "<p:cNvPicPr>"
		        + "<a:picLocks noChangeAspect=\"1\"/>"
		      + "</p:cNvPicPr>"
	            + "<p:nvPr>"
	            	+ "<p:ph idx=\"${idx}\"/>"//+ "<p:ph idx=\"${idx}\" ${size}/>"
	            + "</p:nvPr>"
		    + "</p:nvPicPr>"
		    + "<p:blipFill>"
		      + "<a:blip r:embed=\"${rEmbedId}\" cstate=\"print\"/>"
		      + "<a:stretch>"
		        + "<a:fillRect/>"
		      + "</a:stretch>"
		    + "</p:blipFill>"
		    + "<p:spPr>"
		      + "<a:xfrm>"
		        + "<a:off x=\"0\" y=\"0\"/>"
		        + "<a:ext cx=\"0\" cy=\"0\"/>"
		      + "</a:xfrm>"
		      + "<a:prstGeom prst=\"rect\">"
		        + "<a:avLst/>"
		      + "</a:prstGeom>"
		    + "</p:spPr>"
		  + "</p:pic>";

	public static Object getShape(PresentationMLPackage  obj, SlidePart slidePart
			, String filename, long shape_id, long idx) throws Exception {
				
		File file = new File(filename);
        BinaryPartAbstractImage imagePart = BinaryPartAbstractImage.createImagePart(obj, slidePart, file);
        Relationship rel = slidePart.addTargetPart(imagePart);
        
		java.util.HashMap<String, String>mappings = new java.util.HashMap<String, String>();
        mappings.put("element_id", shape_id + "" );
        mappings.put("rEmbedId", rel.getId() );
        mappings.put("idx", idx + "" );

        Object o = org.docx4j.XmlUtils.unmarshallFromTemplate(PICTURE, mappings, Context.jcPML, Pic.class ) ;

        return o;
	}
}

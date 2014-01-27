package com.lysis.pptx4r.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Vector;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.docx4j.dml.CTPoint2D;
import org.docx4j.dml.CTPositiveSize2D;
import org.docx4j.dml.CTTransform2D;
import org.docx4j.openpackaging.exceptions.InvalidFormatException;
import org.docx4j.openpackaging.packages.PresentationMLPackage;
import org.docx4j.openpackaging.parts.Part;
import org.docx4j.openpackaging.parts.PartName;
import org.docx4j.openpackaging.parts.PresentationML.SlideLayoutPart;
import org.docx4j.openpackaging.parts.PresentationML.SlideMasterPart;
import org.pptx4j.pml.Shape;

import com.lysis.pptx4r.elements.layouts.LayoutProperties;
import com.lysis.pptx4r.elements.layouts.ShapeDescription;
import com.lysis.pptx4r.elements.layouts.SlideLayout;

public class DocExplorer {
	
	public static HashMap<String, LayoutProperties> browseLayouts(PresentationMLPackage basedoc) throws InvalidFormatException {
		
		HashMap<String, LayoutProperties> layoutDescriptionList = new HashMap<String, LayoutProperties>();
		
		Iterator<Entry<PartName, Part>> partIterator = basedoc.getParts().getParts().entrySet().iterator();
		
		while (partIterator.hasNext()) {
			Entry<PartName, Part> en =partIterator.next(); 

			if( en.getValue().getContentType().equals("application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml")){
				SlideLayoutPart layoutPart = (SlideLayoutPart)basedoc.getParts().getParts().get(new PartName(en.getKey().getName()));
				Vector<ShapeDescription> shapesProperties = new Vector<ShapeDescription>(); 

				String lpName = layoutPart.getJaxbElement().getCSld().getName();
				String lpKey = en.getKey().getName();
				
				List<Object> slidesSet = layoutPart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame();
				Iterator<Object> itr = slidesSet.iterator();
				while(itr.hasNext()) {
					
			         Object element = itr.next();
			         if( element.getClass().equals(org.pptx4j.pml.Shape.class) ) {
			        	 Shape s = (Shape)element;
			        	 shapesProperties.add( new ShapeDescription( s ) );
			         }
			    }
				LayoutProperties lp = new LayoutProperties(lpName, lpKey, shapesProperties);
				layoutDescriptionList.put(lpName, lp);
			} 
	    }
		return layoutDescriptionList;
	}

	public static HashMap<Integer, ShapeDescription> browseMasterLayout(PresentationMLPackage basedoc) throws InvalidFormatException {
		HashMap<Integer, ShapeDescription> out = new HashMap<Integer, ShapeDescription> ();
		
		Iterator<Entry<PartName, Part>> partIterator = basedoc.getParts().getParts().entrySet().iterator();
		
		while (partIterator.hasNext()) {
			Entry<PartName, Part> en =partIterator.next(); 

			if( en.getValue().getContentType().equals("application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml")){
				
				SlideMasterPart layoutPart = (SlideMasterPart)basedoc.getParts().getParts().get(new PartName(en.getKey().getName()));
				
				List<Object> slidesSet = layoutPart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame();
				Iterator<Object> itr = slidesSet.iterator();
				while(itr.hasNext()) {
					
			         Object element = itr.next();
			         if( element.getClass().equals(org.pptx4j.pml.Shape.class) ) {
			        	 Shape s = (Shape)element;
			        	 ShapeDescription sd = new ShapeDescription( s ) ;
			        	 //System.out.println(sd.getShapeType());
			        	 if( sd.getShapeType().equals("dt") ) out.put( SlideLayout.DATE, sd );
			        	 else if( sd.getShapeType().equals("title") ) out.put( SlideLayout.TITLE, sd );
			        	 else if( sd.getShapeType().equals("ftr") ) out.put( SlideLayout.FOOTER, sd );
			        	 else if( sd.getShapeType().equals("sldNum") ) out.put( SlideLayout.SLIDENUMBER, sd );
			         }
			    }
				return out;
			} 
	    }
		return null;
	}

	
	public CTTransform2D getXfrm(double offx, double offy, double width, double height) {
		org.docx4j.dml.ObjectFactory dmlFactory = new org.docx4j.dml.ObjectFactory();
		org.docx4j.dml.CTTransform2D xfrm = dmlFactory.createCTTransform2D();
		CTPositiveSize2D ext = dmlFactory.createCTPositiveSize2D();
		ext.setCx(EMU.getFromCm(width));
		ext.setCy(EMU.getFromCm(height));
		xfrm.setExt(ext);
		CTPoint2D off = dmlFactory.createCTPoint2D();
		xfrm.setOff(off);
		off.setX(EMU.getFromCm(offx));
		off.setY(EMU.getFromCm(offy));
		return xfrm;
	}

	
	public static int countExistingSlides(PresentationMLPackage basedoc){
		int id_slide = 0;
		
		Iterator<Entry<PartName, Part>> partIterator = basedoc.getParts().getParts().entrySet().iterator();
		
		while (partIterator.hasNext()) {
			Entry<PartName, Part> en =partIterator.next(); 

			if( en.getValue().getContentType().equals("application/vnd.openxmlformats-officedocument.presentationml.slide+xml")){
				id_slide++;
			}
	    }
		return id_slide;
	}
	public static void getZipFiles(String filename, String destinationname) {
	    try {
	        byte[] buf = new byte[1024];
	        ZipInputStream zipinputstream = null;
	        ZipEntry zipentry;
	        zipinputstream = new ZipInputStream(
	                new FileInputStream(filename));

	        zipentry = zipinputstream.getNextEntry();
	        while (zipentry != null) {
	            //for each entry to be extracted
	            String entryName = destinationname + zipentry.getName();
	            entryName = entryName.replace('/', File.separatorChar);
	            entryName = entryName.replace('\\', File.separatorChar);
	            //System.out.println("entryname " + entryName);
	            int n;
	            FileOutputStream fileoutputstream;
	            File newFile = new File(entryName);
	            if (zipentry.isDirectory()) {
	                if (!newFile.mkdirs()) {
	                    break;
	                }
	                zipentry = zipinputstream.getNextEntry();
	                continue;
	            }

	            fileoutputstream = new FileOutputStream(entryName);

	            while ((n = zipinputstream.read(buf, 0, 1024)) > -1) {
	                fileoutputstream.write(buf, 0, n);
	            }

	            fileoutputstream.close();
	            zipinputstream.closeEntry();
	            zipentry = zipinputstream.getNextEntry();

	        }//while

	        zipinputstream.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
}

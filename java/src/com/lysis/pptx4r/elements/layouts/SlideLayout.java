package com.lysis.pptx4r.elements.layouts;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Vector;

import org.docx4j.dml.CTTransform2D;

public class SlideLayout {

	public static int TITLE = 0;
	public static int FOOTER = 1;
	public static int SLIDENUMBER = 2;
	public static int DATE = 3;
	public static int SUBTITLE = 4;
	public static int CRTTITLE = 5;
	
	private Vector<Boolean> filledElement;
	private int filledContent;
	private int contentSize;

	private LinkedHashMap<Integer, ShapeDescription> shapeDescriptionMetadata;
	private LinkedHashMap<Integer, ShapeDescription> shapeDescriptionContent;
	private HashMap<Integer, ShapeDescription> masterLayout;
	
	public SlideLayout( LayoutProperties slideLayout, HashMap<Integer, ShapeDescription> master ){
		filledElement = new Vector<Boolean>();
		
		filledContent = 0;
		contentSize = 0;
		
		shapeDescriptionMetadata = new LinkedHashMap<Integer, ShapeDescription>();
		shapeDescriptionContent = new LinkedHashMap<Integer, ShapeDescription>();
		
		filledElement.add(TITLE, false);
		filledElement.add(FOOTER, false);
		filledElement.add(SLIDENUMBER, false);
		filledElement.add(DATE, false);
		filledElement.add(SUBTITLE, false);
		filledElement.add(CRTTITLE, false);

		Vector<ShapeDescription> shapeDesc = slideLayout.getContents();
		
		for (Iterator<ShapeDescription> it2 = shapeDesc.iterator(); it2.hasNext();) {
			ShapeDescription sd=it2.next();

			if( sd.getShapeType().equals("title") ) {
				shapeDescriptionMetadata.put(TITLE, sd);
			}
			if( sd.getShapeType().equals("dt") ) {
				shapeDescriptionMetadata.put(DATE, sd);
			}
			if( sd.getShapeType().equals("ftr") ) {
				shapeDescriptionMetadata.put(FOOTER, sd);
			}
			if( sd.getShapeType().equals("sldNum") ) {
				shapeDescriptionMetadata.put(SLIDENUMBER, sd);
			}
			
			if( sd.getShapeType().equals("subTitle") ) {
				shapeDescriptionMetadata.put(SUBTITLE, sd);
			}
			if( sd.getShapeType().equals("ctrTitle") ) {
				shapeDescriptionMetadata.put(CRTTITLE, sd);
			}

			if( sd.getShapeType().equals("body") 
				|| sd.getShapeType().equals("tbl")
				|| sd.getShapeType().equals("obj") 
				|| sd.getShapeType().equals("pic") 
				|| sd.getShapeType().equals("undefined") ) {
				shapeDescriptionContent.put(contentSize, sd);
				contentSize++;
			}
		}
		masterLayout = master;

	}
	
	
	public boolean contains(int what){
		return shapeDescriptionMetadata.containsKey(what);
	}
	public boolean isFilled(int what){
		return filledElement.get(what);
	}
	public void setFilled(int what){
		filledElement.add(what, true);
	}
	public long id(int what){
		return shapeDescriptionMetadata.get(what).getIdx();
	}
	public long idContent(int what){
		Iterator<Entry<Integer, ShapeDescription>> it = shapeDescriptionContent.entrySet().iterator();
		int index = 0;

	    while (it.hasNext()) {
	    	ShapeDescription sd = (ShapeDescription)it.next().getValue();
	        if( index == what ) {
	        	return sd.getIdx();
	        }
	        index++;
	    }

		return -1;
	}
	
	
	
	public int[] getContentDimensions(int id) {
		int[] data = new int[4];
		CTTransform2D xfrm ;
		try{ 
			xfrm = shapeDescriptionContent.get(id).getXfrm();
			
			Long offx = new Long(xfrm.getOff().getX());
			Long offy = new Long(xfrm.getOff().getY());
			Long extx = new Long(xfrm.getExt().getCx());
			Long exty = new Long(xfrm.getExt().getCy());
			data[0] = offx.intValue();
			data[1] = offy.intValue();
			data[2] = extx.intValue();
			data[3] = exty.intValue();
		} catch( NullPointerException e){
			data[0] = -1;
			data[1] = -1;
			data[2] = -1;
			data[3] = -1;
		}
 
		return data;
	}
	public int[] getMetaDimensions(int id) {
		int[] data = new int[4];
		CTTransform2D xfrm;
		try{ 
			xfrm = getXfrmMeta(id);
			Long offx = new Long(xfrm.getOff().getX());
			Long offy = new Long(xfrm.getOff().getY());
			Long extx = new Long(xfrm.getExt().getCx());
			Long exty = new Long(xfrm.getExt().getCy());
			data[0] = offx.intValue();
			data[1] = offy.intValue();
			data[2] = extx.intValue();
			data[3] = exty.intValue();
		} catch( NullPointerException e){
			data[0] = -1;
			data[1] = -1;
			data[2] = -1;
			data[3] = -1;
		}
		return data;
	}
	
	public CTTransform2D getXfrmContent(int what){
		return shapeDescriptionContent.get(what).getXfrm();
	}
	public CTTransform2D getXfrmMeta(int what){
		CTTransform2D out;
		try{
			out = shapeDescriptionMetadata.get(what).getXfrm();
		} catch( NullPointerException e ){
			out = masterLayout.get(what).getXfrm();
		}
		return out;
	}
	
	public void setContentFilled(){
		filledContent++;
	}
	public int getContentFilled(){
		return filledContent;
	}
	public int getContentSize(){
		return shapeDescriptionContent.size();
	}
	
}

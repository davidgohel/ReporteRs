package com.lysis.pptx4r.elements.layouts;

import org.docx4j.dml.CTTransform2D;
import org.pptx4j.pml.Shape;

public class ShapeDescription {

	private long idx;
	private CTTransform2D xfrm;
	private String shapeType ;
	
	
	public ShapeDescription( Shape s ){
		shapeType = "undefined";
        try{
        	shapeType = s.getNvSpPr().getNvPr().getPh().getType().value();
        } catch( java.lang.NullPointerException e) {}
        
        try{
        	idx = s.getNvSpPr().getNvPr().getPh().getIdx();
        } catch( java.lang.NullPointerException e) {}
        setValues( s );
	}
	
	private void setValues(Shape s){
		try{
			xfrm = s.getSpPr().getXfrm();
		} catch( Exception e){
		}
	}
	public void setDefaultXfrm( CTTransform2D xfrm){
		this.xfrm = xfrm;
	}
	
	public long getIdx() {
		return idx;
	}

	public CTTransform2D getXfrm() throws NullPointerException{

		if( xfrm == null ) throw new NullPointerException("No Xfrm defined");
		return xfrm;
	}

	public String getShapeType(){
		return shapeType;
	}

	
	public boolean isContent(){
		return getShapeType().equals("body") 
				|| getShapeType().equals("obj") 
				|| getShapeType().equals("title") 
				|| getShapeType().equals("pic")
				|| getShapeType().equals("tbl")
				|| getShapeType().equals("subTitle")
				|| getShapeType().equals("dt")
				|| getShapeType().equals("sldNum")
				|| getShapeType().equals("ftr")
				|| getShapeType().equals("undefined")
				;
	}

	public String toString(){ 
		return("type=" + shapeType + "\t{offx:" + xfrm.getOff().getX() + ",offy:" + xfrm.getOff().getY() + ",extx:" + xfrm.getExt().getCx() + ",exty:" + xfrm.getExt().getCy() + "}");
	}
}

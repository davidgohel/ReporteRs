package com.lysis.pptx4r.elements.layouts;

import java.util.Vector;

import org.docx4j.dml.CTTransform2D;

/*
 * LayoutProperties is a container for shape read in the layouts
 * any layout can be described in that layout*/
public class LayoutProperties {
	
	private String key;
	private String name;
	private Vector<ShapeDescription> contents;
	
	public LayoutProperties(String name, String key, Vector<ShapeDescription> props) {
		super();
		this.name = name;
		this.key = key;
		this.contents = props;
	}
	
	public String getName() {
		return name;
	}
	public String getKey() {
		return key;
	}
	public Vector<ShapeDescription> getContents() {
		return contents;
	}
	
	public int getMaxShape(){
		int out = 0;
		for( int i = 0 ; i < contents.size() ; i++ ){
			if( contents.get(i).isContent() ) out++;
		}
		return out;
	}
	public long getShapeIdx(int id){
		int out = 0;
		long idx = -1;
		for( int i = 0 ; i < contents.size() ; i++ ){
			if( contents.get(i).isContent() ) {
				if( id == out ) {
					idx = contents.get(i).getIdx();
					break;
				}
				out++;
			}
		}
		return idx;
	}

	public long getShapeIdx(String type){
		long idx = -1;
		for( int i = 0 ; i < contents.size() ; i++ ){
			if( contents.get(i).getShapeType().equals(type) ) {
				idx = contents.get(i).getIdx();
				return idx;
			}
		}
		return idx;
	}
	
	public CTTransform2D getXfrm(int id) {
		int out = 0;
		CTTransform2D outXfrm=null;
		for( int i = 0 ; i < contents.size() ; i++ ){
			if( contents.get(i).isContent() ) {
				if( id == out ) {
					outXfrm = contents.get(i).getXfrm();
					break;
				}
				out++;
			}
		}
		
		return outXfrm;	
	}
	
	
	public String toString(){
		String cont="";
		for( int i = 0 ; i < contents.size() ; i++ ){
			if( i>0)
				cont = cont + ";" + contents.get(i);
			else cont = cont + contents.get(i);
		}
		return name + " [" + key + "]\t{" + cont + "}";
	}
	
}

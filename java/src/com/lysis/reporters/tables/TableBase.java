package com.lysis.reporters.tables;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Vector;

import com.lysis.docx4r.datatable.data.RCharacter;
import com.lysis.docx4r.datatable.data.RDate;
import com.lysis.docx4r.datatable.data.RInteger;
import com.lysis.docx4r.datatable.data.RList;
import com.lysis.docx4r.datatable.data.RLogical;
import com.lysis.docx4r.datatable.data.RNumeric;
import com.lysis.docx4r.datatable.data.RPercent;


public class TableBase {
	
	protected Map<String,Integer> groupColsSpecifications ;
	protected Map<String,String> columnLabels ;
	protected RList data ;
	protected Map<String,String[]> fillColors ;
	protected Map<String,String[]> fontColors ;
	protected Map<String,int[]> mergeInstructions ;
	
	public TableBase( ) throws FileNotFoundException, IOException {
		groupColsSpecifications = new LinkedHashMap<String, Integer>();
		data = new RList();
		columnLabels = new LinkedHashMap<String, String>();
		fillColors = new LinkedHashMap<String, String[]>();
		fontColors = new LinkedHashMap<String, String[]>();
		mergeInstructions = new LinkedHashMap<String, int[]>();		
	}
	
	public void setGroupedCols( String colGroupedName, int colspan){
		groupColsSpecifications.put(colGroupedName, colspan);
	}


	public void setData( String colName, String label, String[] x){
		Vector<String> cvector = new Vector<String>();
		for(int i = 0 ; i < x.length ; i++ )
			cvector.add(x[i]);
		RCharacter robj = new RCharacter(cvector);
		data.append(robj, colName);
		columnLabels.put(colName, label);
	}
	
	public void setDateData( String colName, String label, String[] x){
		Vector<String> cvector = new Vector<String>();
		for(int i = 0 ; i < x.length ; i++ )
			cvector.add(x[i]);
		RDate robj = new RDate(cvector);
		data.append(robj, colName);
		columnLabels.put(colName, label);
	}
	
	public void setLogicalData( String colName, String label, String[] x){
		Vector<String> cvector = new Vector<String>();
		for(int i = 0 ; i < x.length ; i++ )
			cvector.add(x[i]);
		RLogical robj = new RLogical(cvector);
		data.append(robj, colName);
		columnLabels.put(colName, label);
	}
	
	public void setData( String colName, String label, double[] x){
		Vector<Double> cvector = new Vector<Double>();
		for(int i = 0 ; i < x.length ; i++ )
			cvector.add(x[i]);
		RNumeric robj = new RNumeric(cvector);
		data.append(robj, colName);
		columnLabels.put(colName, label);
	}
	public void setPercentData( String colName, String label, double[] x){
		Vector<Double> cvector = new Vector<Double>();
		for(int i = 0 ; i < x.length ; i++ )
			cvector.add(x[i]);
		RPercent robj = new RPercent(cvector);
		data.append(robj, colName);
		columnLabels.put(colName, label);
	}
	public void setData( String colName, String label, int[] x){
		Vector<Integer> cvector = new Vector<Integer>();
		for(int i = 0 ; i < x.length ; i++ )
			cvector.add(x[i]);
		RInteger robj = new RInteger(cvector);
		data.append(robj, colName);
		columnLabels.put(colName, label);
	}
	
//	protected boolean isValidGroupColSpecifications(){
//		boolean out;
//		int nbcols=0;
//		if( groupColsSpecifications.size() > 0 ){
//			for (Iterator<String> it1 = groupColsSpecifications.keySet().iterator(); it1.hasNext();) {
//				String groupColName = it1.next();
//				nbcols = nbcols + groupColsSpecifications.get(groupColName).length;
//			}
//		}
//		out = (nbcols==data.size());
//		return out;
//	}

	protected boolean hasGroupColumns(){
		return ( groupColsSpecifications.size() > 0 );
	}


	public void setFillColors(String colName, String[] x) {

		fillColors.put(colName, x);
		
	}

	public void setFontColors(String colName, String[] x) {
		fontColors.put(colName, x);
		
	}

	public void setMergeInstructions( String colname, int[] x ) {
		mergeInstructions.put(colname, x);
	}
}

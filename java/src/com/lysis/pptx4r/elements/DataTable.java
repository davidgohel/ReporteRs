package com.lysis.pptx4r.elements;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;

import org.docx4j.XmlUtils;
import org.docx4j.dml.CTNoFillProperties;
import org.docx4j.dml.CTRegularTextRun;
import org.docx4j.dml.CTTable;
import org.docx4j.dml.CTTableCell;
import org.docx4j.dml.CTTableCellProperties;
import org.docx4j.dml.CTTableCol;
import org.docx4j.dml.CTTableGrid;
import org.docx4j.dml.CTTableProperties;
import org.docx4j.dml.CTTableRow;
import org.docx4j.dml.CTTextBody;
import org.docx4j.dml.CTTextBodyProperties;
import org.docx4j.dml.CTTextCharacterProperties;
import org.docx4j.dml.CTTextListStyle;
import org.docx4j.dml.CTTextParagraph;
import org.docx4j.dml.CTTextParagraphProperties;
import org.docx4j.dml.Graphic;
import org.docx4j.dml.GraphicData;
import org.pptx4j.pml.CTGraphicalObjectFrame;

import com.lysis.docx4r.datatable.data.RAtomicInterface;
import com.lysis.pptx4r.tools.Format;
import com.lysis.reporters.tables.TableBase;
import com.lysis.reporters.tables.TableLayoutPPTX;


public class DataTable extends TableBase{
	
	private TableLayoutPPTX rSpecFormats;
	
	public DataTable(TableLayoutPPTX tf) throws FileNotFoundException, IOException {
		super();
		rSpecFormats = tf;
		
	}
	

	private void addHeader( CTTable reviewtable ) throws JAXBException{
		CTTableRow workingRow;
		CTTableCell tc;
		CTTextBody p;
		//Grouped Headers
		if( hasGroupColumns() ){
			workingRow = new CTTableRow();
			for (Iterator<String> it1 = groupColsSpecifications.keySet().iterator(); it1.hasNext();) {
				String groupColName = it1.next();
				int colSpan = groupColsSpecifications.get(groupColName);
				p = getP(groupColName,rSpecFormats.getGroupedheaderPar(),rSpecFormats.getGroupedheaderText() );
				tc = getCell(rSpecFormats.getGroupedheaderCell(), p, colSpan, 1);
				workingRow.getTc().add(tc);
				for(int cc = 1 ; cc < colSpan ; cc++ ){
					p = getEmptyP( rSpecFormats.getGroupedheaderPar() );
					tc = getCell(rSpecFormats.getGroupedheaderCell(), p, 0, 1);
					workingRow.getTc().add(tc);
				}
			}
			reviewtable.getTr().add(workingRow);
		} 
		//Headers
		workingRow = new CTTableRow();

		for (Iterator<String> it2 = columnLabels.keySet().iterator(); it2.hasNext();) {
			String colName = it2.next();
			p = getP(columnLabels.get(colName),rSpecFormats.getHeaderPar(),rSpecFormats.getHeaderText() );
			tc = getCell(rSpecFormats.getHeaderCell(), p, 1, 1);
			workingRow.getTc().add(tc);
		}
		reviewtable.getTr().add(workingRow);

	}
	
	private void addContent(CTTable reviewtable) throws Exception {

		for( int i = 0 ; i < data.get(0).size() ; i++ ){
			CTTableRow workingRow = new CTTableRow();
			for( int j = 0 ; j < data.size() ; j++ ){
				RAtomicInterface robj = data.get(j);
				CTTableCell tc = null;
				CTTextBody temp;
				CTTableCellProperties tcpr;
				if( !fontColors.containsKey(data.names(j))){
					temp = robj.getP(i, rSpecFormats );
				} else temp = robj.getP(i, rSpecFormats, fontColors.get(data.names(j))[i] );
				tcpr = robj.getCellProperties(rSpecFormats);
				//System.out.println(data.);
				if( fillColors.containsKey(data.names(j))){
					tcpr = XmlUtils.deepCopy(tcpr);
					tcpr.setSolidFill(Format.getCol(fillColors.get(data.names(j))[i]));
				} 


				if( !mergeInstructions.containsKey( data.names(j) ) ){
					tc = getCell(tcpr, temp, 1, 1);
				} else {
					tc = getCell(tcpr, temp, 1, mergeInstructions.get( data.names( j ) )[i]);
				} 
				
				workingRow.getTc().add(tc);
			}
			reviewtable.getTr().add(workingRow);
		}
	}

	
	private CTTableCell getCell(CTTableCellProperties cellProp, CTTextBody p, int colspan, int rowspan){
		CTTableCell tc = new CTTableCell();
		tc.setTxBody(p);
		
		if( colspan > 1 ){
			tc.setGridSpan(colspan);
		} else if( colspan < 1 ){
			tc.setHMerge(true);
			CTTableCellProperties temp = new CTTableCellProperties();
			temp.setNoFill(new CTNoFillProperties());
			tc.setTcPr(temp);
			return tc;
		}

		if( rowspan > 1 )
			tc.setRowSpan(rowspan);
		else if( rowspan < 1 ){
			tc.setVMerge(true);
		}
		if( colspan > 0 )
			tc.setTcPr(cellProp);
		return tc;
	}
	
	private CTTextBody getP(String value, CTTextParagraphProperties formatPar, CTTextCharacterProperties formatText) throws JAXBException{
		CTTextBody p = new CTTextBody();

		CTTextBodyProperties pp = new CTTextBodyProperties();
		CTTextListStyle ls = new CTTextListStyle();
		p.setBodyPr(pp);
		p.setLstStyle(ls);
		CTRegularTextRun textRun = Utils.getRun(value);
		textRun.setRPr(formatText);
		CTTextParagraph textPar = new CTTextParagraph();
		List<Object> runs = textPar.getEGTextRun();
		runs.add(textRun);
		
		textPar.setPPr(formatPar);
		p.getP().add(textPar);
		return p;
	}
	private CTTextBody getEmptyP(CTTextParagraphProperties formatPar) throws JAXBException{
		CTTextBody p = new CTTextBody();

		CTTextBodyProperties pp = new CTTextBodyProperties();
		CTTextListStyle ls = new CTTextListStyle();
		p.setBodyPr(pp);
		p.setLstStyle(ls);
		CTTextParagraph textPar = new CTTextParagraph();

		
		textPar.setPPr(formatPar);
		textPar.setEndParaRPr(new CTTextCharacterProperties());
		p.getP().add(textPar);
		return p;
	}
	public CTTable getTbl(long width) throws Exception {
		CTTable newTable = new CTTable();
		CTTableProperties tablpro = new CTTableProperties();
		CTTableGrid tg = new CTTableGrid();
		for(int i = 0 ; i < data.size() ; i++ ){
			List<CTTableCol> gc = tg.getGridCol();
			CTTableCol tc = new CTTableCol();
			tc.setW(width);
			gc.add( tc );
		}
		newTable.setTblPr(tablpro);
		newTable.setTblGrid(tg);
		
		if( data.size() > 0 ){
			addHeader(newTable);
			addContent(newTable);
		}
		return newTable;
	} 

	public CTGraphicalObjectFrame getShape(long idx, long shape_id, long width) throws Exception{
		// instatiation the factory for later object creation.
		org.docx4j.dml.ObjectFactory dmlFactory = new org.docx4j.dml.ObjectFactory();
		org.pptx4j.pml.ObjectFactory pmlFactory = new org.pptx4j.pml.ObjectFactory();
		CTGraphicalObjectFrame graphicFrame = pmlFactory.createCTGraphicalObjectFrame();
		
		org.pptx4j.pml.CTGraphicalObjectFrameNonVisual nvGraphicFramePr = pmlFactory.createCTGraphicalObjectFrameNonVisual();

		org.docx4j.dml.CTNonVisualDrawingProps cNvPr = dmlFactory.createCTNonVisualDrawingProps();

		org.docx4j.dml.CTNonVisualGraphicFrameProperties cNvGraphicFramePr = dmlFactory.createCTNonVisualGraphicFrameProperties();
		org.docx4j.dml.CTGraphicalObjectFrameLocking graphicFrameLocks = new org.docx4j.dml.CTGraphicalObjectFrameLocking();
		
		org.docx4j.dml.CTTransform2D xfrm = dmlFactory.createCTTransform2D();
		Graphic graphic = dmlFactory.createGraphic();
		GraphicData graphicData = dmlFactory.createGraphicData();
		
		
		graphicFrame.setNvGraphicFramePr(nvGraphicFramePr);
		nvGraphicFramePr.setCNvPr(cNvPr);
		cNvPr.setName("nvGraphicFrame " + shape_id);
		cNvPr.setId(shape_id);
		
		nvGraphicFramePr.setCNvGraphicFramePr(cNvGraphicFramePr);
		cNvGraphicFramePr.setGraphicFrameLocks(graphicFrameLocks);
		graphicFrameLocks.setNoGrp(true);
		nvGraphicFramePr.setNvPr(pmlFactory.createNvPr());
		
		graphicFrame.setXfrm(xfrm);
		
		graphicFrame.setGraphic(graphic);
		
		graphic.setGraphicData(graphicData);
		graphicData.setUri("http://schemas.openxmlformats.org/drawingml/2006/table");
		
		CTTable ctTable = getTbl( new Double(width/data.size()).longValue());
		JAXBElement<CTTable> tbl = dmlFactory.createTbl(ctTable);
		graphicData.getAny().add(tbl);

		return graphicFrame;
		}
	
}

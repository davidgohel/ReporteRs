package com.lysis.docx4r.elements;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Iterator;
import java.util.List;

import javax.xml.bind.JAXBElement;

import org.docx4j.XmlUtils;
import org.docx4j.jaxb.Context;
import org.docx4j.wml.CTShd;
import org.docx4j.wml.Jc;
import org.docx4j.wml.JcEnumeration;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.R;
import org.docx4j.wml.RPr;
import org.docx4j.wml.Tbl;
import org.docx4j.wml.TblPr;
import org.docx4j.wml.Tc;
import org.docx4j.wml.TcPr;
import org.docx4j.wml.TcPrInner.GridSpan;
import org.docx4j.wml.TcPrInner.VMerge;
import org.docx4j.wml.Text;
import org.docx4j.wml.Tr;
import org.docx4j.wml.TrPr;

import com.lysis.docx4r.datatable.data.RAtomicInterface;
import com.lysis.reporters.tables.TableBase;
import com.lysis.reporters.tables.TableLayoutDOCX;


public class DataTable extends TableBase{
	

	private TableLayoutDOCX rSpecFormats;
	
	public DataTable(TableLayoutDOCX tf) throws FileNotFoundException, IOException {
		super();
		rSpecFormats = tf;
		
	}
	


	private void addHeader( Tbl reviewtable ){
		Tr workingRow;
		Tc tc;
		P p;
		//Grouped Headers
		if( hasGroupColumns() ){
			workingRow = new Tr();
			TrPr trpr = new TrPr();
			List<JAXBElement<?>> cnfStyleOrDivIdOrGridBefore = trpr.getCnfStyleOrDivIdOrGridBefore();
			cnfStyleOrDivIdOrGridBefore.add(Context.getWmlObjectFactory().createCTTrPrBaseTblHeader(Context.getWmlObjectFactory().createBooleanDefaultTrue()));
			workingRow.setTrPr(trpr);
			for (Iterator<String> it1 = groupColsSpecifications.keySet().iterator(); it1.hasNext();) {
				String groupColName = it1.next();
				int colSpan = groupColsSpecifications.get(groupColName);
				p = getP(groupColName,rSpecFormats.getGroupedheaderPar(),rSpecFormats.getGroupedheaderText() );
				tc = getCell(rSpecFormats.getGroupedheaderCell(), p, colSpan, false, null);

				workingRow.getContent().add(tc);
			}
			reviewtable.getContent().add(workingRow);
		} 
		//Headers
		workingRow = new Tr();
		TrPr trpr = new TrPr();
		List<JAXBElement<?>> cnfStyleOrDivIdOrGridBefore = trpr.getCnfStyleOrDivIdOrGridBefore();
		cnfStyleOrDivIdOrGridBefore.add(Context.getWmlObjectFactory().createCTTrPrBaseTblHeader(Context.getWmlObjectFactory().createBooleanDefaultTrue()));
		workingRow.setTrPr(trpr);
		for (Iterator<String> it2 = columnLabels.keySet().iterator(); it2.hasNext();) {
			String colName = it2.next();
			p = getP(columnLabels.get(colName),rSpecFormats.getHeaderPar(),rSpecFormats.getHeaderText() );
			tc = getCell(rSpecFormats.getHeaderCell(), p, 1, false, null);
			workingRow.getContent().add(tc);
		}
		reviewtable.getContent().add(workingRow);

	}
	
	private void addContent(Tbl reviewtable) {
		for( int i = 0 ; i < data.get(0).size() ; i++ ){
			Tr workingRow = new Tr();
			for( int j = 0 ; j < data.size() ; j++ ){
				RAtomicInterface robj = data.get(j);
				Tc tc = null;
				P temp;
				TcPr tcpr;
				if( !fontColors.containsKey(data.names(j))){
					temp = robj.getP(i, rSpecFormats );
				} else temp = robj.getP(i, rSpecFormats, fontColors.get(data.names(j))[i] );
				tcpr = robj.getCellProperties(rSpecFormats);
				
				CTShd shdold = tcpr.getShd();
				if( fillColors.containsKey(data.names(j))){
					CTShd shd = new CTShd();
					shd.setFill(fillColors.get(data.names(j))[i]);
					tcpr.setShd(shd);
				} 


				if( !mergeInstructions.containsKey( data.names(j) ) ){
					tc = getCell(tcpr, temp, 1, false, null);
				} else if( mergeInstructions.get( data.names( j ) )[i] == 0 ){
					tc = getCell(tcpr, temp, 1, false, null);
				} else if( mergeInstructions.get( data.names( j ) )[i] == 1 ){
					tc = getCell(tcpr, temp, 1, true, "restart");
				} else if( mergeInstructions.get( data.names( j ) )[i] == 2 ){
					tc = getCell(tcpr, temp, 1, true, "continue");
				} else {
					tc = getCell(tcpr, temp, 1, false, null);
				} 
				
				workingRow.getContent().add(tc);
				tcpr.setShd(shdold);
			}
			reviewtable.getContent().add(workingRow);
		}
	}

	
	private Tc getCell(TcPr cellProp, P p, int colspan, boolean spanrow, String mergeval){
		Tc tc = new Tc();
		tc.getContent().add(p);
		TcPr tcpr = XmlUtils.deepCopy(cellProp);
		if( spanrow ){
			VMerge merge = new VMerge();
			merge.setVal(mergeval);
			tcpr.setVMerge(merge);
		}

		tc.setTcPr(tcpr);
		setCellColspan(tc, colspan);

		return tc;
	}
	
	private P getP(String value, PPr formatPar, RPr formatText){
		P p = new P();
		R run = new R();
		Text text = new Text();
		
		text.setValue(value);
		run.getContent().add(text);
		run.setRPr(formatText);
		p.getContent().add(run);
		p.setPPr(formatPar);
		//log.info( "getP : str {" + value + "} ; formatPar {" + formatPar.toString() + "} ; formatText {" + formatText.toString() + "}");
		
		return p;
	}

	public Tbl getTbl() throws Exception {
		Tbl newTable = new Tbl();
		if( data.size() > 0 ){
			addHeader(newTable);
			addContent(newTable);
		}
		TblPr tblpr = new TblPr();
		Jc alignment = new Jc();
		alignment.setVal(JcEnumeration.CENTER);
		tblpr.setJc(alignment);
		newTable.setTblPr(tblpr);
		return newTable;
	} 

	private static void setCellColspan( Tc tablecell, int colspan ){
		if( colspan > 1 ){
			GridSpan gridSpan = new GridSpan();
	        gridSpan.setVal(BigInteger.valueOf(colspan));
			tablecell.getTcPr().setGridSpan(gridSpan);
		}
	}

}

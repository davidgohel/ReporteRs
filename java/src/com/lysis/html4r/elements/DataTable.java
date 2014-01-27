package com.lysis.html4r.elements;

import static org.rendersnake.HtmlAttributesFactory.class_;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;

import org.rendersnake.HtmlAttributes;
import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

import com.lysis.docx4r.datatable.data.RAtomicInterface;
import com.lysis.html4r.tools.Format;
import com.lysis.html4r.tools.utils;
import com.lysis.reporters.tables.TableBase;
import com.lysis.reporters.tables.TableLayoutHTML;


public class DataTable extends TableBase implements Renderable{
	

	private TableLayoutHTML rSpecFormats;
	private String uid;
	public DataTable(TableLayoutHTML tf) throws FileNotFoundException, IOException {
		super();
		rSpecFormats = tf;
		uid = utils.generateUniqueId();

	}
	
	private void addHeader( HtmlCanvas reviewtable ) throws IOException{
		HtmlCanvas workingRow;
		HtmlCanvas tc;
		HtmlCanvas p;
		HtmlCanvas span;
		//Grouped Headers
		reviewtable.thead();

		if( hasGroupColumns() ){
			workingRow = reviewtable.tr();
			for (Iterator<String> it1 = groupColsSpecifications.keySet().iterator(); it1.hasNext();) {
				String groupColName = it1.next();
				int colSpan = groupColsSpecifications.get(groupColName);
				HtmlAttributes ha_tc = new HtmlAttributes();
				HtmlAttributes ha_p = new HtmlAttributes();
				HtmlAttributes ha_s = new HtmlAttributes();
				ha_tc.class_("GroupedheaderCell");
				ha_tc.colspan(colSpan+"");
				tc = workingRow.th( ha_tc );
				ha_p.class_("GroupedheaderPar");
				p = tc.p(ha_p);
				ha_s.class_("GroupedheaderText");
				span = p.span(ha_s);
				span.content(groupColName, false);
				p._p();
				tc._th();
			}
			reviewtable._tr();
		} 
		//Headers
		workingRow = reviewtable.tr();
		for (Iterator<String> it2 = columnLabels.keySet().iterator(); it2.hasNext();) {
			String colName = it2.next();
			HtmlAttributes ha_tc = new HtmlAttributes();
			HtmlAttributes ha_p = new HtmlAttributes();
			HtmlAttributes ha_s = new HtmlAttributes();
			ha_tc.class_("HeaderCell");
			tc = workingRow.th( ha_tc );
			ha_p.class_("HeaderPar");
			p = tc.p(ha_p);
			ha_s.class_("HeaderText");
			span = p.span(ha_s);
			span.content(columnLabels.get(colName), false);
			p._p();
			tc._th();
		}
		reviewtable._tr();

		reviewtable._thead();

	}
	private void addCss(HtmlCanvas html) throws IOException {
		HtmlCanvas s = html.style();
		s.write("#" + uid + " .GroupedheaderCell{" + Format.getJSString(rSpecFormats.getGroupedheaderCell()) + "}", false);
		s.write("#" + uid + " .HeaderCell{" + Format.getJSString(rSpecFormats.getHeaderCell()) + "}", false);
		s.write("#" + uid + " .IntegerCell{" + Format.getJSString(rSpecFormats.getIntegerCell()) + "}", false);
		s.write("#" + uid + " .DoubleCell{" + Format.getJSString(rSpecFormats.getDoubleCell()) + "}", false);
		s.write("#" + uid + " .PercentCell{" + Format.getJSString(rSpecFormats.getPercentCell()) + "}", false);
		s.write("#" + uid + " .CharacterCell{" + Format.getJSString(rSpecFormats.getCharacterCell()) + "}", false);
		s.write("#" + uid + " .DateCell{" + Format.getJSString(rSpecFormats.getDateCell()) + "}", false);
		s.write("#" + uid + " .LogicalCell{" + Format.getJSString(rSpecFormats.getLogicalCell()) + "}", false);

		s.write("#" + uid + " .GroupedheaderPar{margin: 0px;" + Format.getJSString(rSpecFormats.getGroupedheaderPar()) + "}", false);
		s.write("#" + uid + " .HeaderPar{margin: 0px;" + Format.getJSString(rSpecFormats.getHeaderPar()) + "}", false);
		s.write("#" + uid + " .IntegerPar{margin: 0px;" + Format.getJSString(rSpecFormats.getIntegerPar()) + "}", false);
		s.write("#" + uid + " .DoublePar{margin: 0px;" + Format.getJSString(rSpecFormats.getDoublePar()) + "}", false);
		s.write("#" + uid + " .PercentPar{margin: 0px;" + Format.getJSString(rSpecFormats.getPercentPar()) + "}", false);
		s.write("#" + uid + " .CharacterPar{margin: 0px;" + Format.getJSString(rSpecFormats.getCharacterPar()) + "}", false);
		s.write("#" + uid + " .DatePar{margin: 0px;" + Format.getJSString(rSpecFormats.getDatePar()) + "}", false);
		s.write("#" + uid + " .LogicalPar{margin: 0px;" + Format.getJSString(rSpecFormats.getLogicalPar()) + "}", false);

		s.write("#" + uid + " .GroupedheaderText{" + Format.getJSString(rSpecFormats.getGroupedheaderText()) + "}", false);
		s.write("#" + uid + " .HeaderText{" + Format.getJSString(rSpecFormats.getHeaderText()) + "}", false);
		s.write("#" + uid + " .IntegerText{" + Format.getJSString(rSpecFormats.getIntegerText()) + "}", false);
		s.write("#" + uid + " .DoubleText{" + Format.getJSString(rSpecFormats.getDoubleText()) + "}", false);
		s.write("#" + uid + " .PercentText{" + Format.getJSString(rSpecFormats.getPercentText()) + "}", false);
		s.write("#" + uid + " .CharacterText{" + Format.getJSString(rSpecFormats.getCharacterText()) + "}", false);
		s.write("#" + uid + " .DateText{margin: 0px;" + Format.getJSString(rSpecFormats.getDateText()) + "}", false);
		s.write("#" + uid + " .LogicalText{margin: 0px;" + Format.getJSString(rSpecFormats.getLogicalText()) + "}", false);

		html._style();
	}

	private void addContent(HtmlCanvas reviewtable) throws IOException {
		reviewtable.tbody();
		
		for( int i = 0 ; i < data.get(0).size() ; i++ ){
			HtmlCanvas workingRow = reviewtable.tr();
			for( int j = 0 ; j < data.size() ; j++ ){
				RAtomicInterface robj = data.get(j);
				HtmlCanvas tc = null;
				
				HtmlAttributes ha_tc = new HtmlAttributes();
				ha_tc.class_(robj.getTdCssClass());
				LinkedHashMap<String, String> tcPr = new LinkedHashMap<String, String>();
				if( fillColors.containsKey(data.names(j))){
					tcPr.put("background-color", fillColors.get(data.names(j))[i]);	
					ha_tc.add("style", com.lysis.html4r.tools.Format.getJSString(tcPr));
				} 

				if( !mergeInstructions.containsKey( data.names(j) ) ){
					tc = workingRow.td(ha_tc);

				} else if( mergeInstructions.get( data.names( j ) )[i] == 0 ){
					
				} else if( mergeInstructions.get( data.names( j ) )[i] == 1 ){
					tc = workingRow.td(ha_tc);
				} else if( mergeInstructions.get( data.names( j ) )[i] > 1 ){
					ha_tc.rowspan(mergeInstructions.get( data.names( j ) )[i]+"");
					tc = workingRow.td(ha_tc);
				} else {
					tc = workingRow.td(ha_tc);
				} 
				
				if( mergeInstructions.containsKey( data.names(j) ) && mergeInstructions.get( data.names( j ) )[i] == 0 ){
					
				} else {
					if( !fontColors.containsKey(data.names(j))){
						robj.setP(tc, i, rSpecFormats );
						workingRow._td();
					} else {
						robj.setP(tc, i, rSpecFormats, fontColors.get(data.names(j))[i] );
						workingRow._td();
					}
				}
			}
		workingRow._tr();
		}
		reviewtable._tbody();

	}



	@Override
	public void renderOn(HtmlCanvas html) throws IOException {
		
		addCss(html);
//		html.write("<div class=\"bs-docs-section\"><div class=\"page-header\">", false );
		HtmlCanvas table = html.table(class_("datatable").id(uid));
		addHeader(table);
		addContent(table);
		html._table();
//		html.write("</div></div>", false );

	}

}

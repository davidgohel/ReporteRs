package com.lysis.docx4r.datatable.data;

import java.io.IOException;
import java.util.LinkedHashMap;

import org.docx4j.dml.CTTableCellProperties;
import org.docx4j.dml.CTTextBody;
import org.docx4j.wml.P;
import org.docx4j.wml.TcPr;
import org.rendersnake.HtmlCanvas;

public interface RAtomicInterface {
	public void print();
	public int size();
	public P getP(int i, com.lysis.reporters.tables.TableLayoutDOCX tf);
	public P getP(int i, com.lysis.reporters.tables.TableLayoutDOCX tf, String fontColor);
	public CTTextBody getP(int i, com.lysis.reporters.tables.TableLayoutPPTX tf) throws Exception;
	public CTTextBody getP(int i, com.lysis.reporters.tables.TableLayoutPPTX tf, String fontColor) throws Exception;
	public void setP(HtmlCanvas html, int i, com.lysis.reporters.tables.TableLayoutHTML tf) throws IOException;
	public void setP(HtmlCanvas html, int i, com.lysis.reporters.tables.TableLayoutHTML tf, String fontColor) throws IOException;
	public TcPr getCellProperties( com.lysis.reporters.tables.TableLayoutDOCX tf );
	public CTTableCellProperties getCellProperties( com.lysis.reporters.tables.TableLayoutPPTX tf );
	public LinkedHashMap<String, String> getCellProperties( com.lysis.reporters.tables.TableLayoutHTML tf );
	public Object get(int i);
	public String getTdCssClass();
}

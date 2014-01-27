package com.lysis.fonts;

import java.awt.Canvas;
import java.awt.Font;
import java.awt.FontMetrics;

public class FontMetric {

	private String fontname;
	private Font[] fonts;
	
	public FontMetric(String fontname, int fontsize) {
		this.fontname = fontname;
		fonts = new Font[4];
		fonts[0] = new Font(this.fontname,Font.PLAIN,fontsize);
		fonts[1] = new Font(this.fontname,Font.BOLD,fontsize);
		fonts[2] = new Font(this.fontname,Font.ITALIC,fontsize);
		fonts[3] = new Font(this.fontname,Font.BOLD+Font.ITALIC,fontsize);

	}
	
	public int[] getWidths(int face){
		Canvas c = new Canvas();
		FontMetrics fm = c.getFontMetrics(fonts[face]);
		return fm.getWidths();
	}
	
	public int[] getStr(int face){
		Canvas c = new Canvas();
		FontMetrics fm = c.getFontMetrics(fonts[face]);
		int[] out = new int[3];
		out[0] = fm.getAscent();
		out[1] = fm.getDescent();
		out[2] = fm.getHeight();
		return out;
	}
}

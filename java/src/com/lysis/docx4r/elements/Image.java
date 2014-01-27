package com.lysis.docx4r.elements;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.docx4j.dml.CTPositiveSize2D;
import org.docx4j.dml.wordprocessingDrawing.Inline;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.BinaryPartAbstractImage;
import org.docx4j.wml.Drawing;
import org.docx4j.wml.ObjectFactory;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.R;

public class Image {

//	public static Inline getImageInline(String filename, WordprocessingMLPackage wordMLPackage, int docPrId, int cNvPrId ) throws Exception {
//		File file = new File(filename);
//		byte[] bytes = convertImageToByteArray(file);
//		
//		BinaryPartAbstractImage imagePart =BinaryPartAbstractImage.createImagePart(wordMLPackage, bytes);
//		Inline inline = imagePart.createImageInline("Filename hint", "Alternative text", docPrId, cNvPrId, false);
//
//		return inline;
//	}
	
	public static P addImageToPackage(String filename, WordprocessingMLPackage wordMLPackage, int docPrId, int cNvPrId, int width, int height, PPr ppr) throws Exception {
		File file = new File(filename);
		byte[] bytes = convertImageToByteArray(file);
		
		BinaryPartAbstractImage imagePart =BinaryPartAbstractImage.createImagePart(wordMLPackage, bytes);
		Inline inline = imagePart.createImageInline("Filename hint", "Alternative text", docPrId, cNvPrId, false);
		CTPositiveSize2D size = new CTPositiveSize2D();
		size.setCx(width);
		size.setCy(height);
		inline.setExtent(size);
		return addInlineImageToParagraph(inline, ppr);
	}
	

	public static byte[] convertImageToByteArray(File file) throws FileNotFoundException, IOException {
		InputStream is = new FileInputStream(file );
		long length = file.length();
		// You cannot create an array using a long, it needs to be an int.
		if (length > Integer.MAX_VALUE) {
			System.out.println("File too large!!");
		}
		byte[] bytes = new byte[(int)length];
		int offset = 0;
		int numRead = 0;
		while (offset < bytes.length && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
			offset += numRead;
		}
		// Ensure all the bytes have been read
		if (offset < bytes.length) {
			System.out.println("Could not completely read file " + file.getName());
		}
		is.close();
		return bytes;
	}
	public static P addInlineImageToParagraph(Inline inline, PPr ppr) { 
		// Now add the in-line image to a paragraph 
		ObjectFactory factory = new ObjectFactory(); 
		P paragraph = factory.createP(); 
		paragraph.setPPr(ppr);
		R run = factory.createR(); 
		paragraph.getContent().add(run); 
		Drawing drawing = factory.createDrawing(); 
		run.getContent().add(drawing); 
		drawing.getAnchorOrInline().add(inline); 
		return paragraph; 
	} 
	
	public static Drawing addInlineImageToDrawing(String filename, WordprocessingMLPackage wordMLPackage, int docPrId, int cNvPrId) throws Exception { 
		File file = new File(filename);
		byte[] bytes = convertImageToByteArray(file);
		
		BinaryPartAbstractImage imagePart =BinaryPartAbstractImage.createImagePart(wordMLPackage, bytes);
		Inline inline = imagePart.createImageInline("Filename hint", "Alternative text", docPrId, cNvPrId, false);
		// Now add the in-line image to a paragraph 
		ObjectFactory factory = new ObjectFactory(); 
		Drawing drawing = factory.createDrawing();
		drawing.getAnchorOrInline().add(inline); 
		return drawing; 
	} 
}

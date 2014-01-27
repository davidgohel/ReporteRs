package com.lysis.html4r.elements;

import java.io.IOException;
import java.util.LinkedHashMap;

import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

import com.lysis.html4r.tools.Tree;

public class TOC implements Renderable{
	private LinkedHashMap<Integer, Title> titles;
	private int titleIndex;
	private Tree<Title> tree;
	private Title currentContainer;
	private int currentLevel;
	
	
	public TOC(String headStr){
		titles = new LinkedHashMap<Integer, Title>();
		titleIndex=-1;
		currentLevel = 0;
		Title root = new Title(headStr, 0);
		tree = new Tree<Title>(root);
		currentContainer = root;
	}
	
	public void addTitle(Title title){
		titleIndex++;
		titles.put(titleIndex, title);
		
		if( title.getLevel() > currentLevel ){
			tree.addLeaf(currentContainer, title);
		} else if( title.getLevel() == currentLevel ){
			tree.getTree(currentContainer).getParent().addLeaf(title);
		}else if( title.getLevel() < currentLevel ){
			tree.getTree(currentContainer).getParent().getParent().addLeaf(title);
		} else {
		}
		currentContainer = title; 
		currentLevel = title.getLevel();
	}
  
	@Override
	public void renderOn(HtmlCanvas html) throws IOException {
		tree.renderOnTree(html);
	}


}

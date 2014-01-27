package com.lysis.html4r.tools;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import org.rendersnake.HtmlCanvas;

import com.lysis.html4r.elements.Title;

/**
  * @author ycoppel@google.com (Yohann Coppel)
  * 
  * @param <T>
  *          Object's type in the tree.
*/
public class Tree<T> {

  private T head;

  private ArrayList<Tree<T>> leafs = new ArrayList<Tree<T>>();

  private Tree<T> parent = null;

  private HashMap<T, Tree<T>> locate = new HashMap<T, Tree<T>>();

  public Tree(T head) {
    this.head = head;
    locate.put(head, this);
  }

  public void addLeaf(T root, T leaf) {
    if (locate.containsKey(root)) {
      locate.get(root).addLeaf(leaf);
    } else {
      addLeaf(root).addLeaf(leaf);
    }
  }

  public Tree<T> addLeaf(T leaf) {
    Tree<T> t = new Tree<T>(leaf);
    leafs.add(t);
    t.parent = this;
    t.locate = this.locate;
    locate.put(leaf, t);
    return t;
  }

  public Tree<T> setAsParent(T parentRoot) {
    Tree<T> t = new Tree<T>(parentRoot);
    t.leafs.add(this);
    this.parent = t;
    t.locate = this.locate;
    t.locate.put(head, this);
    t.locate.put(parentRoot, t);
    return t;
  }

  public T getHead() {
    return head;
  }

  public Tree<T> getTree(T element) {
    return locate.get(element);
  }

  public Tree<T> getParent() {
    return parent;
  }

  public Collection<T> getSuccessors(T root) {
    Collection<T> successors = new ArrayList<T>();
    Tree<T> tree = getTree(root);
    if (null != tree) {
      for (Tree<T> leaf : tree.leafs) {
        successors.add(leaf.head);
      }
    }
    return successors;
  }

  public Collection<Tree<T>> getSubTrees() {
    return leafs;
  }

  public static <T> Collection<T> getSuccessors(T of, Collection<Tree<T>> in) {
    for (Tree<T> tree : in) {
      if (tree.locate.containsKey(of)) {
        return tree.getSuccessors(of);
      }
    }
    return new ArrayList<T>();
  }

  @Override
  public String toString() {
    return printTree(0);
  }

  private static final int indent = 2;

  private String printTree(int increment) {
    String s = "";
    String inc = "";
    for (int i = 0; i < increment; ++i) {
      inc = inc + " ";
    }
    s = inc + head;
    for (Tree<T> child : leafs) {
      s += "\n" + child.printTree(increment + indent);
    }
    return s;
  }

	public void renderOnTree(HtmlCanvas html) throws IOException {
		html.write("<ul class=\"nav nav-list\">", false);
		int lev = 0;
		if (leafs.size() > 0) {
			for (Tree<T> child : leafs) {
				child.renderOnLeftMenu(html, lev);
			}
		}
		html.write("</ul>", false);
	}




	public void renderOnLeftMenu(HtmlCanvas html, int level) throws IOException {

		Title temp = (Title) head;
		level++;

		if (leafs.size() < 1){
			html.write("<li>", false);
			html.write("<a href=\"#" + temp.getUID() + "\">", false);
			html.write(temp.getValue(), false);
			html.write("</a>", false);
			html.write("</li>", false);
		} else {
			html.write("<li>", false);
			html.write("<a href=\"#" + temp.getUID() + "\">", false);
			html.write(temp.getValue(), false);//
			html.write("</a>", false);
			html.write("<ul class=\"nav nav-list\">", false);
			for (Tree<T> child : leafs) {
				child.renderOnLeftMenu(html, level );
			}
			html.write("</ul>", false);
			html.write("</li>", false);
		}
		
	}
}
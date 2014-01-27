package com.lysis.docx4r.tools;

import java.util.List;

import org.docx4j.TraversalUtil;
import org.docx4j.XmlUtils;
import org.docx4j.wml.CTBookmark;
import org.docx4j.wml.P;


public class DocExplorer {
	



    // Used internally by findBookmarkedParagrapghInPart().
    public static P traversePartForBookmark(Object parent, String bookmark) {
        P p = null;
        bookmark = bookmark.toLowerCase();
        
        List<Object> children = TraversalUtil.getChildrenImpl(parent);
        if (children != null) {
            for (Object o : children) {
                o = XmlUtils.unwrap(o);
                if (o instanceof CTBookmark) {
                    if (((CTBookmark) o).getName().toLowerCase().equals(bookmark)) {
                        return (P) parent; // If bookmark found, the surrounding P is what is interesting.
                    }
                }
                p = traversePartForBookmark(o, bookmark);
                if (p != null) {
                    break;
                }
            }
        }
        return p;
    }


}

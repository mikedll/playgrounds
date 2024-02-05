package com.mikedll.codetours;

import java.io.File;
import java.util.Arrays;

public class DirWalk {
  
  public static void main(String[] args) {
    System.out.println("This is the dir walk");
    walkDir(".");    
  }
  
  public static void walkDir(String dir) {
    File asFile = new File(dir);
    String[] children = asFile.list();
    if(children == null) {
      return;
    }
    Arrays.asList(children).forEach((child) -> {
      String childInDir = dir + "/" + child;
      System.out.println(childInDir);
      File childFile = new File(childInDir);
      walkDir(childInDir);
    });
  }
}

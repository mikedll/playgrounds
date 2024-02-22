package com.mikedll.playgrounds;

import com.mikedll.playgrounds.topcoder.A0Paper;

public class TopCoder {  
  public static void main(String[] args) {
    A0Paper a0 = new A0Paper();
    System.out.println(a0.canBuild(new int[] { 0, 3 }));
    System.out.println(a0.canBuild(new int[] { 0, 1, 2 }));
    System.out.println(a0.canBuild(new int[] { 0, 0, 0, 0, 15 }));
  }
}

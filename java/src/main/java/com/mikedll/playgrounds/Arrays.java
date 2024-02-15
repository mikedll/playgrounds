package com.mikedll.playgrounds;

import java.util.Random;

public class Arrays {
  public static int[] getRandom(int size) {
    Random r = new Random();        
    int[] input = new int[size];
    for(int i=0; i<input.length; i++) {
      input[i] = r.nextInt(100);
    }
    return input;
  }
  
  public static void output(int[] input) {
    System.out.print("<");
    for(int i=0; i<input.length; i++) {
      System.out.print(input[i]);
      if(i < input.length-1) {
        System.out.print(",");
      }
    }
    System.out.print(">\n");
  }
}
package com.mikedll.playgrounds;

import java.util.Random;

public class Arrays {
  public static int[] getRandom(int size) {
    return getRandom(size, 100);
  }
  
  public static int[] getRandom(int size, int max) {
    Random r = new Random();        
    int[] input = new int[size];
    for(int i=0; i<input.length; i++) {
      input[i] = r.nextInt(max);
    }
    return input;    
  }
 
  public static void output(int[] input) {
    output("", input);
  }

  public static void output(String prefix, int[] input) {
    System.out.print(prefix + "<");
    for(int i=0; i<input.length; i++) {
      System.out.print(input[i]);
      if(i < input.length-1) {
        System.out.print(",");
      }
    }
    System.out.print(">\n");
  }
}
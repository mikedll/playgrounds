package com.mikedll.playgrounds;

import java.util.Random;

public class BinarySearch {
  public static void main(String[] args) {
    int[] input = Arrays.getRandom(10);
    InsertionSort is = new InsertionSort();
    is.sort(input);

    System.out.print("input: ");
    Arrays.output(input);
    
    Random r = new Random();        
    int indexOfX = r.nextInt(input.length);
    int x = input[indexOfX];
    
    BinarySearch bs = new BinarySearch();
    Integer foundIndex = bs.find(input, x, 0, input.length-1);

    if(foundIndex == null) {
      System.out.println("Failed to find index");
    } else {    
      System.out.println("x=" + x + ", decided index=" + indexOfX + ", foundIndex=" + foundIndex);
    }
  }
  
  public Integer find(int[] input, int x, int p, int r) {
    if(p > r) {
      return null;
    }
    
    int q = (p + r)/2;
    
    if(input[q] == x) {
      return q;
    }
    
    if(x < input[q]) {
      return find(input, x, p, q-1);
    } else {
      return find(input, x, q+1, r);
    }
  }
}
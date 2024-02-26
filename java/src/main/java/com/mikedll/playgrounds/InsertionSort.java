package com.mikedll.playgrounds;

public class InsertionSort {
  public static void main(String[] args) {    
    int[] input = Arrays.getRandom(6);
    InsertionSort is = new InsertionSort();
    Arrays.output(input);    
    is.recursiveSort(input, input.length-1);
    Arrays.output(input);
  }
  
  public void sort(int[] input) {
    for(int i=1; i<input.length; i++) {
      int key = input[i];
      int j = i-1;
      while(j >= 0 && input[j] > key) {
        input[j+1] = input[j];
        j--;
      }
      input[j+1] = key;
    }
  }
  
  public void recursiveSort(int[] input, int n) {
    if(n == 0) {
      return;
    }
    
    recursiveSort(input, n-1);
    
    int key = input[n];
    int j=n-1;
    while(j >= 0 && input[j] > key) {
      input[j+1] = input[j];
      j--;
    }
    input[j+1] = key;
  }
}
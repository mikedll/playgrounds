package com.mikedll.playgrounds;

public class InsertionSort {
  public static void main(String[] args) {    
    int[] input = Arrays.getRandom(6);
    InsertionSort is = new InsertionSort();
    Arrays.output(input);    
    is.sortDescending(input);
    Arrays.output(input);
  }
  
  public void sortSublist(int[] input, int p, int r) {
    int len = r-p+1;
    for(int i=1; i<len; i++) {
      int key = input[p+i];
      int j = i-1;
      while(j >= 0 && input[p+j] > key) {
        input[p+j+1] = input[p+j];
        j--;
      }
      input[p+j+1] = key;
    }
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

  public void sortDescending(int[] input) {
    for(int i=1; i<input.length; i++) {
      int key = input[i];
      int j = i-1;
      while(j >= 0 && input[j] <= key) {
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
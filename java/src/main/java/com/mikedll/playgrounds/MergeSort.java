package com.mikedll.playgrounds;

public class MergeSort {
  
  public static void main(String[] args) {
    int[] input = new int[] { 12, 3, 7, 9, 14, 6, 11, 2 };

    MergeSort ms = new MergeSort();   
    ms.mergeSort(input, 0, input.length-1);
    
    System.out.print("<");
    for(int i=0; i<input.length; i++) {
      System.out.print(input[i]);
      if(i < input.length -1) {
        System.out.print(",");
      }
    }
    System.out.print("> \n");
  }
  
  public void mergeSort(int[] input, int p, int r) {
    if(p >= r) {
      return;
    }
    
    int q = (p + r)/2;
    mergeSort(input, p, q);
    mergeSort(input, q+1, r);
    merge(input, p, q, r);
  }
  
  public void merge(int[] input, int p, int q, int r) {
    int lenLeft = (q-p)+1;
    int lenRight = r-q;
    int[] left = new int[lenLeft];
    int[] right = new int[lenRight];
    
    for(int i=0; i<lenLeft; i++) {
      left[i] = input[p+i];
    }
    for(int i=0; i<lenRight; i++) {
      right[i] = input[q+i+1];
    }
    int i = 0;
    int j = 0;
    int k = p;
    while(i < lenLeft && j < lenRight) {
      if(left[i] < right[j]) {
        input[k] = left[i];
        i++;
      } else {
        input[k] = right[j];
        j++;
      }
      k++;
    }
    
    while(i < lenLeft) {
      input[k] = left[i];
      i++;
      k++;
    }
    
    while(j < lenRight) {
      input[k] = right[j];
      j++;
      k++;
    }
  }
}
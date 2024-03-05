package com.mikedll.playgrounds;

import java.lang.NumberFormatException;
import java.time.Instant;
import java.time.Duration;
import java.lang.NumberFormatException;

public class MergeSort {
  
  public static void main(String[] args) {
    MergeSort ms = new MergeSort();   
    if(args.length == 2 && args[0].equals("withInsertionSort")) {
      ms.withInsertionSort(args[1]);
      return;
    } else if(args.length == 1 && args[0].equals("findN0")) {
      ms.findN0();
      return;
    } else if(args.length >= 1 && args[0].equals("inversions")) {
      ms.demoCountInversions(args);
      return;
    }
    int[] input = new int[] { 12, 3, 7, 9, 14, 6, 11, 2 };

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
  
  public void demoCountInversions(String[] args) {
    int[] input;
    if(args.length > 1) {
      input = new int[args.length-1];
      for(int i=1; i<args.length; i++) {
        try {
          input[i-1] = Integer.parseInt(args[i]);        
        } catch (NumberFormatException ex) {
          throw new RuntimeException(ex);
        }
      }
    } else {
      input = Arrays.getRandom(5);      
    }
    MyInteger inversions = new MyInteger();
    Arrays.output("Input", input);
    countInversions(input, inversions, 0, input.length-1);
    Arrays.output("Sorted", input);    
    System.out.println("Inversions: " + inversions.value);    
  }

  public void printTime(String title, Duration duration) {
    System.out.print(title + " cost (ns): ");
    System.out.printf("%,d", duration.getNano());
    System.out.println("");    
  } 
  
  public void findN0() {
    InsertionSort is = new InsertionSort();

    for(int i=1; i<=100; i++) {
      int[] input = Arrays.getRandom(i*10, 40);
      int[] inputCopy = Arrays.copy(input);
      
      Instant beforeMerge = Instant.now();
      mergeSort(input, 0, input.length-1);
      Instant afterMerge = Instant.now();
      Duration mergeCost = Duration.between(beforeMerge, afterMerge);
      
      Instant beforeIns = Instant.now();
      is.sort(inputCopy);
      Instant afterIns = Instant.now();
      Duration insCost = Duration.between(beforeIns, afterIns);
      
      int result = insCost.compareTo(mergeCost);
      if(result > 0) {
        printTime("MergeSort", mergeCost);    
        printTime("InsertionSort", insCost);
        System.out.println("Merge beat insertion sort at n=" + input.length);
        break;
      }
    }
  }
  
  public void withInsertionSort(String kArg) {
    int[] input = Arrays.getRandom(20, 40);
    Arrays.output("input: ", input);
    
    int k;
    try {
      k = Integer.parseInt(kArg);
    } catch(NumberFormatException ex) {
      throw new RuntimeException(ex);
    }
    mergeSortWithInsertion(input, 0, input.length-1, k);
    Arrays.output("sorted: ", input);
  }
  
  public void mergeSortWithInsertion(int[] input, int p, int r, int k) {
    if(p >= r) {
      return;
    }
    
    if((r-p+1) <= k) {
      InsertionSort is = new InsertionSort();
      is.sortSublist(input, p, r);
      return;
    }
    
    int q = (p + r)/2;
    mergeSortWithInsertion(input, p, q, k);
    mergeSortWithInsertion(input, q+1, r, k);
    merge(input, p, q, r);
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
  
  public void countInversions(int[] input, MyInteger inversionCount, int p, int r) {
    if(p >= r) {
      return;
    }
    
    int q = (p + r)/2;
    countInversions(input, inversionCount, p, q);
    countInversions(input, inversionCount, q+1, r);
    mergeToCountInversions(input, inversionCount, p, q, r);
  }
  
  public void mergeToCountInversions(int[] input, MyInteger inversionCount, int p, int q, int r) {
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
        inversionCount.value += (lenLeft-i);
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
  
  public class MyInteger {
    public int value;
  }
}

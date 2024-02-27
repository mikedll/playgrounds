package com.mikedll.playgrounds;

import java.util.Random;
import java.util.Set;
import java.util.HashSet;
import org.javatuples.Pair;

public class FindSum {
  
  public static void main(String[] args) {
    int[] input = Arrays.getRandom(20);
    
    Set<Integer> asSet = new HashSet<>();
    for(int i : input) {
      asSet.add(i);
    }
    
    int[] set = asSet.stream().mapToInt(Integer::intValue).toArray();
    MergeSort ms = new MergeSort();
    ms.mergeSort(set, 0, set.length-1);
    System.out.print("Array=");
    Arrays.output(set);
    
    Random r = new Random();
    int goal;
    if(r.nextInt(2) == 0) {
      // rigged to be found
      int indexOfX = r.nextInt(input.length);
      int indexOfY = r.nextInt(input.length);
      goal = input[indexOfX] + input[indexOfY];      
      System.out.println("Should find goal of " + goal);
    } else {
      // may or may not be found
      goal = r.nextInt(20*2);
      System.out.println("Might find goal of " + goal);
    }
    
    FindSum fs = new FindSum();
    Pair<Integer,Integer> indices = fs.find(set, goal);
    if(indices != null) {
      System.out.println("i=" + indices.getValue0() + "(" + set[indices.getValue0()] + ")" +
       "j=" + indices.getValue1() + "(" + set[indices.getValue1()] + ")");
    } else {
      System.out.println("Found no indices for goal " + goal);
    }
  }
  
  public Pair<Integer,Integer> find(int[] input, int x) {
    int i = 0;
    int j = input.length-1;
    while(i < j) {
      if(input[i] + input[j] == x) {
        return Pair.with(i, j);
      } else if(input[i] + input[j] > x) {
        j--;
      } else {
        i++;
      }
    }
    
    return null;
  }
}
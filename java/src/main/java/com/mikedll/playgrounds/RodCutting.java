package com.mikedll.playgrounds;

import java.lang.Math;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;
import java.util.stream.Collectors;
import org.javatuples.Pair;

public class RodCutting {
  
  public static void main(String[] args) {
    System.out.println("Hello args length=" + args.length);

    int[] rodValues = new int[] { 1, 5, 8, 9, 10, 17, 17, 20, 24, 30 };
    
    RodCutting rodCutting = new RodCutting();
    for(int i=1; i<=rodValues.length; i++) {
      int value = rodCutting.easyWork(rodValues, i);
      int easiserYet = rodCutting.easierYetWork(rodValues, i);
      System.out.println("Optimal for length " + i + ": " + value + ", via easier yet=" + easiserYet);
    }
    rodCutting.hardWork(rodValues);
  }
  
  // r_n = max{p_i + r_(n-i): 1<=i<=n}
  public int easierYetWork(int[] rodValues, int soughtLength) {
    int[] optimal = new int[soughtLength];
    optimal[0] = rodValues[0];
    for(int i=2; i<=soughtLength; i++) {
      for(int j=1; j<=i; j++) {
        int p_j = rodValues[j-1];
        int r_n_minus_j = j == i ? 0 : optimal[i-j-1];
        int thisCut = p_j + r_n_minus_j;
        optimal[i-1] = Math.max(optimal[i-1], thisCut);
      }
    }
    return optimal[soughtLength-1];
  }
  
  public int easyWork(int[] rodValues, int soughtLength) {
    int[] optimal = new int[rodValues.length];
    optimal[0] = rodValues[0];
    for(int rodLength = 2; rodLength <= soughtLength; rodLength++) {
      int halfWay = rodValues.length % 2 == 0 ? rodLength/2 : (rodLength+1)/2;
      for(int i = 0; i<=halfWay; i++) {
        int leftLength = i;
        int rightLength = rodLength-i;
        int thisCutValue = i == 0 ? rodValues[rightLength-1] : (optimal[leftLength-1] + optimal[rightLength-1]);
        if(thisCutValue > optimal[rodLength-1]) {
          optimal[rodLength-1] = thisCutValue;
        }
      }
    }
    return optimal[soughtLength-1];
  }
  
  public void hardWork(int[] rodValues) {
    for(int rodLength = 1; rodLength <= rodValues.length; rodLength++) {
      System.out.println("r_" + rodLength + ": ");
      Pair<List<List<Integer>>, MyInteger> result = run(rodValues, rodLength);
      List<List<Integer>> optimal = result.getValue0();
      MyInteger optimalValue = result.getValue1();
      
      for(List<Integer> lengths : optimal) {
        System.out.print("{");
        for(int i = 0; i < lengths.size(); i++) {
          System.out.print(lengths.get(i));
          if(i < lengths.size() - 1) {
            System.out.print(",");
          }            
        }
        System.out.print("} = " + optimalValue.value + "\n");
      }
    }    
  }

  public Pair<List<List<Integer>>, MyInteger> run(int[] rodValues, int rodLength) {
    MyInteger bestValue = new MyInteger();
    
    // For cut-counts, generate all possible lengths
    List<List<Integer>> optimal = new ArrayList<>();
    for(int numCuts = 0; numCuts < rodLength; numCuts++) {        
      List<Integer> lengths = Arrays.asList(new Integer[numCuts+1]);
      buildSeqFrom(rodLength, rodValues, optimal, lengths, 0, rodLength, bestValue);
    }
    
    return Pair.with(optimal, bestValue);
  }
  
  public void buildSeqFrom(int originalRodLength, int[] rodValues, List<List<Integer>> optimal, 
                           List<Integer> lengths, int offset, int remainingRodLength, MyInteger bestValue) {
    
    if(offset > lengths.size()) {
      throw new RuntimeException("offset of " + offset + " is greater than lengths size of " + lengths.size());
    }

    int sizeUsed = lengths.subList(0, offset).stream().reduce(0, Integer::sum);
    
    // base case: final length in the list of lengths.
    // it is determined to be a single value. no need for
    // for loop.
    if(offset == lengths.size()-1) {
      List<Integer> myLengths = new ArrayList<>(lengths);
      myLengths.set(offset, originalRodLength - sizeUsed);
      int seqValue = myLengths.stream().map(v -> rodValues[v-1]).reduce(0, Integer::sum);
      if(bestValue.value == null || seqValue > bestValue.value) {
        bestValue.value = seqValue;
        optimal.clear();
        optimal.add(myLengths);
      } else if(seqValue == bestValue.value) {
        optimal.add(myLengths);
      }
      return;
    }

    for(int i=1; i<originalRodLength - sizeUsed; i++) {
      List<Integer> myLengths = new ArrayList<>(lengths);
      myLengths.set(offset, i);
      buildSeqFrom(originalRodLength, rodValues, optimal, myLengths, offset+1, remainingRodLength-i, bestValue);
    }
  }
  
  public class MyInteger {
    public Integer value;
  }
}
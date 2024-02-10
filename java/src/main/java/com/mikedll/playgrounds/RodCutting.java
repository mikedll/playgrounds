package com.mikedll.playgrounds;

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
    
    for(int rodLength = 1; rodLength <= rodValues.length; rodLength++) {
      System.out.println("r_" + rodLength + ": ");
      Pair<List<List<Integer>>, MyInteger> result = rodCutting.run(rodValues, rodLength);
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
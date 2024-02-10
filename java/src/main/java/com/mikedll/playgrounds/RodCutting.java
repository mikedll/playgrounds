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
      Pair<List<List<Integer>>, Map<List<Integer>,Integer>> result = rodCutting.run(rodValues, rodLength);
      List<List<Integer>> optimal = result.getValue0();
      Map<List<Integer>, Integer> possibilityToValue = result.getValue1();
      
      for(List<Integer> possibility : optimal) {
        System.out.print("{");
        for(int i = 0; i < possibility.size(); i++) {
          System.out.print(possibility.get(i));
          if(i < possibility.size() - 1) {
            System.out.print(",");
          }            
        }
        System.out.print("} = " + possibilityToValue.get(possibility) + "\n");
      }
    }    
  }

  public Pair<List<List<Integer>>, Map<List<Integer>,Integer>> run(int[] rodValues, int rodLength) {
    // For cut-counts, generate all possible lengths
    List<List<Integer>> possibilities = new ArrayList<>();
    for(int numCuts = 0; numCuts < rodLength; numCuts++) {        
      List<Integer> lengths = Arrays.asList(new Integer[numCuts+1]);
      examineAfter(rodLength, possibilities, lengths, 0, rodLength);
    }
    
    Integer bestValue = null;
    Map<List<Integer>,Integer> possibilityToValue = new HashMap<>();
    for(List<Integer> possibility : possibilities) {
      int value = possibility.stream().map(v -> rodValues[v-1]).reduce(0, Integer::sum);
      possibilityToValue.put(possibility, value);
      if(bestValue == null || value > bestValue) {
        bestValue = value;
      }
    }

    final Integer bestValueCopy = bestValue; 
    List<List<Integer>> optimal = possibilities.stream()
      .filter(p -> possibilityToValue.get(p) == bestValueCopy)
      .collect(Collectors.toList());
    
    return Pair.with(optimal, possibilityToValue);
  }
  
  public void examineAfter(int originalRodLength, List<List<Integer>> possibilities, 
                                  List<Integer> lengths, int offset, int remainingRodLength) {
    
    if(offset > lengths.size()) {
      throw new RuntimeException("offset of " + offset + " is greater than lengths size of " + lengths.size());
    }

    // simple case: no cuts    
    if(offset == 0 && lengths.size() == 1) {
      List<Integer> possibility = Arrays.asList(originalRodLength);;
      possibilities.add(possibility);
      return;
    }

    int sizeUsed = lengths.subList(0, offset).stream().reduce(0, Integer::sum);
    
    // special case: final length in the list of lengths.
    // it is determined to be a single value. no need for
    // for loop.
    if(offset == lengths.size()-1) {
      List<Integer> myLengths = new ArrayList<>(lengths);
      myLengths.set(offset, originalRodLength - sizeUsed);
      possibilities.add(myLengths);
      return;
    }

    for(int i=1; i<originalRodLength - sizeUsed; i++) {
      List<Integer> myLengths = new ArrayList<>(lengths);
      myLengths.set(offset, i);
      examineAfter(originalRodLength, possibilities, myLengths, offset+1, remainingRodLength-i);
    }
  }
}
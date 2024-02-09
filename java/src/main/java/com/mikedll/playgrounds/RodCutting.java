package com.mikedll.playgrounds;

import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

public class RodCutting {
  
  public static void main(String[] args) {
    System.out.println("Hello");
    
    int[] rodValues = new int[] { 1, 5, 8, 9, 10, 17, 17, 20, 24, 30 };
    
    for(int rodLength = 1; rodLength <= rodValues.length; rodLength++) {
      System.out.println("r_" + rodLength + ": ");
      
      // Get possible cuts
      List<List<Integer>> possibilities = new ArrayList<>();
      for(int numCuts = 0; numCuts < rodLength; numCuts++) {        
        int[] lengths = new int[numCuts+1];
        examineAfter(rodLength, possibilities, lengths, 0, rodLength);
      }
      
      Integer bestValue = null;
      Map<List<Integer>,Integer> possibilityToValue = new HashMap<>();
      for(List<Integer> possibility : possibilities) {
        int value = 0;
        for(Integer cutLength : possibility) {
          value += rodValues[cutLength-1];
        }
        possibilityToValue.put(possibility, value);
        if(bestValue == null || value > bestValue) {
          bestValue = value;
        }
      }
  
      final Integer bestValueCopy = bestValue; 
      List<List<Integer>> optimal = possibilities.stream()
        .filter(p -> possibilityToValue.get(p) == bestValueCopy)
        .collect(Collectors.toList());
        
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
  
  public static void examineAfter(int originalRodLength, List<List<Integer>> possibilities, 
                                  int[] lengths, int offset, int remainingRodLength) {
    
    if(offset > lengths.length) {
      throw new RuntimeException("offset of " + offset + " is greater than lengths size of " + lengths.length);
    }

    // simple case: no cuts    
    if(offset == 0 && lengths.length == 1) {
      List<Integer> possibility = Arrays.asList(originalRodLength);;
      possibilities.add(possibility);
      return;
    }

    int sizeUsed = 0;
    for(int i=0; i<offset; i++) {
      sizeUsed += lengths[i];
    }
    
    // special case: final length in the list of lengths.
    // it is determined to be a single value. no need for
    // for loop.
    if(offset == lengths.length-1) {
      int[] myLengths = new int[lengths.length];
      for(int i=0; i<offset; i++) {
        myLengths[i] = lengths[i];
      }
      myLengths[offset] = originalRodLength - sizeUsed;
      List<Integer> possibility = new ArrayList<>(myLengths.length);
      for(int length : myLengths) {
        possibility.add(length);
      }
      possibilities.add(possibility);
      return;
    }

    for(int i=1; i<=originalRodLength; i++) {
      if((sizeUsed + i) < originalRodLength) {
        int[] myLengths = new int[lengths.length];
        for(int j=0; j<offset; j++) {
          myLengths[j] = lengths[j];
        }
        myLengths[offset] = i;
        examineAfter(originalRodLength, possibilities, myLengths, offset+1, remainingRodLength-i);
      }
    }
  }
}
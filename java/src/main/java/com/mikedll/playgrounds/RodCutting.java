package com.mikedll.playgrounds;

import java.lang.Math;
import java.util.Random;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;
import java.util.stream.Collectors;
import org.javatuples.Pair;

public class RodCutting {
  
  // mvn compile exec:java@RodCutting -Dexec.args="large"
  public static void main(String[] args) {
    RodCutting rodCutting = new RodCutting();

    int[] rodValues = new int[] { 1, 5, 8, 9, 10, 17, 17, 20, 24, 30 };
    if(args.length > 0 && args[0].equals("large")) {
      rodValues = new int[40];
      rodValues[0] = 1;
      Random rand = new Random();
      for(int i=1; i<rodValues.length; i++) {
        rodValues[i] = rodValues[i-1] + rand.nextInt(5);
      }
      return;
    } else if(args.length > 0 && args[0].equals("firstTry")) {
      rodCutting.firstTry(rodValues);
      return;
    }
    
    int value = rodCutting.easyWork(rodValues, rodValues.length);
    System.out.println("Easy work " + value);
    int memoizedBottomUp = rodCutting.memoizedBottomUp(rodValues, rodValues.length);
    System.out.println("memoizedBottomUp: " + memoizedBottomUp);
    int simpleRecursive = rodCutting.simpleRecursive(rodValues, rodValues.length);
    System.out.println("Naive Recursive: " + simpleRecursive);
    int memoizedTopDown = rodCutting.memoizedTopDown(rodValues, rodValues.length);
    System.out.println("memoizedTopDown: " + memoizedTopDown);
    
    // rodCutting.hardWork(rodValues);    
  }
  
  public int memoizedTopDown(int[] rodValues, int n) {
    int[] solutions = new int[n+1];
    for(int i=0; i<=n; i++) {
      solutions[i] = -1;
    }
    return memoizedTopDownAux(rodValues, n, solutions);
  }
  
  public int memoizedTopDownAux(int[] rodValues, int n, int[] solutions) {
    if(solutions[n] != -1) {
      return solutions[n];
    }
    
    int q = -1;
    if(n == 0) {
      return 0;
    } else {
      for(int i=1; i<=n; i++) {
        q = Math.max(q, rodValues[i-1] + memoizedTopDownAux(rodValues, n-i, solutions));
      }
    }    
    
    solutions[n] = q;
    return q;
  }
  
  public int simpleRecursive(int[] rodValues, int n) {
    if(n == 0) return 0;
    
    int q = -1;
    for(int i=1; i<=n; i++) {
      q = Math.max(q, rodValues[i-1] + simpleRecursive(rodValues,n-i));
    }
    
    return q;
  }
  
  // r_n = max{p_i + r_(n-i): 1<=i<=n}
  public int memoizedBottomUp(int[] rodValues, int soughtLength) {
    int[] optimal = new int[soughtLength+1];
    optimal[0] = 0;
    for(int i=1; i<=soughtLength; i++) {
      int q = -1;
      for(int j=1; j<=i; j++) {
        q = Math.max(q, rodValues[j-1] + optimal[i-j]);
      }
      optimal[i] = q;
    }
    return optimal[soughtLength];
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
  
  public void firstTry(int[] rodValues) {
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
      buildSeqFrom(rodLength, rodValues, optimal, lengths, 0, 0, bestValue);
    }
    
    return Pair.with(optimal, bestValue);
  }
  
  public void buildSeqFrom(int originalRodLength, int[] rodValues, List<List<Integer>> optimal, 
    List<Integer> lengths, int offset, int sizeUsed, MyInteger bestValue) {
    
    if(offset > lengths.size()) {
      throw new RuntimeException("offset of " + offset + " is greater than lengths size of " + lengths.size());
    }
    
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
      buildSeqFrom(originalRodLength, rodValues, optimal, myLengths, offset+1, sizeUsed + i, 
        bestValue);
    }
  }
  
  public class MyInteger {
    public Integer value;
  }
}
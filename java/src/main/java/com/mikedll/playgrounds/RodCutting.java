package com.mikedll.playgrounds;

import java.lang.Math;
import java.util.Random;
import java.util.List;
import java.util.ArrayList;
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
    } else if(args.length > 0 && args[0].equals("bottomUpPrint")) {
      for(int i=1; i<=rodValues.length; i++) {
        rodCutting.printSolutionBottomUp(rodValues, i);        
      }
      return;
    } else if(args.length > 0 && args[0].equals("topDownPrint")) {
      for(int i=1; i<=rodValues.length; i++) {
        Pair<Integer,List<Integer>> result = rodCutting.memoizedTopDown(rodValues, i);
        System.out.print("for i=" + i + ", val=" + result.getValue0() + ", solution=");
        Arrays.output(result.getValue1());
      }    
    } else if(args.length > 0 && args[0].equals("useDensity")) {
      rodValues = new int[] { 1,5,7};
      Arrays.output("rodValues=", rodValues);
      for(int j=0; j<rodValues.length; j++) {
        Pair<Integer,List<Integer>> densityValAndCuts = rodCutting.densitySolution(rodValues, j+1);
        Pair<Integer[], Integer[]> bottomUp = rodCutting.extendedBottomUp(rodValues, j+1);
        System.out.println("Density approach value for j=" + (j+1) + ", val=" + densityValAndCuts.getValue0() +
          ", memoizedBottomUp value=" + bottomUp.getValue0()[j+1]);
        if(!densityValAndCuts.getValue0().equals(bottomUp.getValue0()[j+1])) {
          System.out.print("densityValue=" + densityValAndCuts.getValue0() + "\n");
          Arrays.output("densityCuts=", densityValAndCuts.getValue1());
          System.out.print("bottomUpValue=" + bottomUp.getValue0()[j+1] + "\n");
          rodCutting.printSolutionBottomUp(rodValues, j+1);
        }
      }
      return;
    } else if(args.length == 2 && args[0].equals("withCutCost")) {
      Integer cost = Integer.parseInt(args[1]);
      for(int i =1; i<=rodValues.length; i++) {
        Pair<Integer,List<Integer>> result = rodCutting.withCutCost(rodValues, i, cost);
        System.out.print("n=" + i + ", optimal value=" + result.getValue0() + ", cuts=");
        Arrays.output(result.getValue1());
      }
      return;        
    }
    
    int value = rodCutting.easyWork(rodValues, rodValues.length);
    System.out.println("Easy work " + value);
    int memoizedBottomUp = rodCutting.memoizedBottomUp(rodValues, rodValues.length);
    System.out.println("memoizedBottomUp: " + memoizedBottomUp);
    int simpleRecursive = rodCutting.simpleRecursive(rodValues, rodValues.length);
    System.out.println("Naive Recursive: " + simpleRecursive);
    Pair<Integer,List<Integer>> topDown = rodCutting.memoizedTopDown(rodValues, rodValues.length);
    System.out.println("memoizedTopDown: " + topDown.getValue0());
    
    // rodCutting.hardWork(rodValues);    
  }
  
  public Pair<Integer,List<Integer>> memoizedTopDown(int[] rodValues, int n) {
    int[] solutions = new int[n+1];
    int[] firstCuts = new int[n];
    for(int i=0; i<=n; i++) {
      solutions[i] = -1;
    }
    int value = memoizedTopDownAux(rodValues, n, solutions, firstCuts);
    List<Integer> cuts = new ArrayList<>();
    while(n > 0) {
      cuts.add(firstCuts[n-1]);
      n -= firstCuts[n-1];
    }
    
    return Pair.with(value, cuts);
  }
  
  public int memoizedTopDownAux(int[] rodValues, int n, int[] solutions, int[] firstCuts) {
    if(solutions[n] != -1) {
      return solutions[n];
    }
    
    int q = -1;
    int firstCut = n;
    if(n == 0) {
      return 0;
    } else {
      for(int i=1; i<=n; i++) {
        int iCutValue = rodValues[i-1] + memoizedTopDownAux(rodValues, n-i, solutions, firstCuts);
        if(iCutValue > q) {
          q = iCutValue;
          firstCut = i;
        }
      }
    }    
    
    solutions[n] = q;
    firstCuts[n-1] = firstCut;
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
  
  public void printSolutionBottomUp(int[] rodValues, int soughtLength) {
    Pair<Integer[],Integer[]> results = extendedBottomUp(rodValues, soughtLength);
    System.out.print("r_" + soughtLength + "=" + results.getValue0()[soughtLength] + ", {");
    List<Integer> cuts = new ArrayList<>();
    int n = soughtLength;
    while(n > 0) {
      cuts.add(results.getValue1()[n-1]);
      n -= results.getValue1()[n-1];
    }
    for(int i=0; i<cuts.size(); i++) {
      System.out.print(cuts.get(i));
      if(i < cuts.size() - 1) {
        System.out.print(",");
      }
    }
    System.out.print("}\n");
  }
  
  public Pair<Integer[],Integer[]> extendedBottomUp(int[] rodValues, int soughtLength) {
    Integer[] optimalValues = new Integer[rodValues.length+1];
    Integer[] firstCutLengths = new Integer[soughtLength];
    
    optimalValues[0] = 0;
    for(int i=1; i<=soughtLength; i++) {
      optimalValues[i] = -1;
      firstCutLengths[i-1] = -1;
    }
    
    for(int i=1; i<=soughtLength;i++) {
      int q = -1;
      for(int j=1; j<=i; j++) {
        int thisCutValue = rodValues[j-1] + optimalValues[i-j];
        if(thisCutValue > optimalValues[i]) {
          optimalValues[i] = thisCutValue;
          firstCutLengths[i-1] = j;
        }
      }
    }
    
    return Pair.with(optimalValues, firstCutLengths);
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
      List<Integer> lengths = java.util.Arrays.asList(new Integer[numCuts+1]);
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
  
  public Pair<Integer,List<Integer>> densitySolution(int[] rodValues, int soughtLength) {
    List<Integer> cutLengths = new ArrayList<>();
    
    double[] densities = new double[rodValues.length];
    for(int i=0; i<rodValues.length; i++) {
      densities[i] = Double.valueOf(rodValues[i]) / Double.valueOf(i+1);
    }
    
    int value = 0;
    int n = soughtLength;
    while(n > 0) {
      double maxDensity = -1.0;
      int maxI = -1;
      for(int i=1; i<=densities.length && i<=n; i++) {
        if(densities[i-1] > maxDensity) {
          maxDensity = densities[i-1];
          maxI = i;
        }
      }
      if(maxI == -1) {
        throw new RuntimeException("maxI was not assigned a value (is -1)");
      }

      value += rodValues[maxI-1];
      cutLengths.add(maxI);
      n -= maxI;
    }
    
    return Pair.with(value, cutLengths);
  }
  
  public Pair<Integer,List<Integer>> withCutCost(int[] rodValues, int soughtLength, Integer cutCost) {
    int[] optimal = new int[rodValues.length+1];
    int[] firstCuts = new int[soughtLength];
    optimal[0] = 0;
    List<Integer> solutionCuts = new ArrayList<>();
    
    for(int i=1; i<=soughtLength; i++) {
      int q = -1;
      int optimalSizeLength = -1;
      for(int j=1; j<=i; j++) {
        int costIfCut = j == i ? 0 : cutCost;
        int thisSizeCost = rodValues[j-1] + optimal[i-j] - costIfCut;
        if(q < thisSizeCost) {
          q = thisSizeCost;
          optimalSizeLength = j;
        }
      }
      optimal[i] = q;
      firstCuts[i-1] = optimalSizeLength;
    }
    
    int n = soughtLength;
    while(n > 0) {
      solutionCuts.add(firstCuts[n-1]);
      n -= firstCuts[n-1];
    }
    if(n < 0) {
      throw new RuntimeException("n < 0, =" + n);
    }
    
    return Pair.with(optimal[soughtLength],solutionCuts);
  }
  
  public class MyInteger {
    public Integer value;
  }
}
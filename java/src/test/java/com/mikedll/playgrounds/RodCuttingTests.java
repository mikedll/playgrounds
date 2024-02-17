package com.mikedll.playgrounds;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.javatuples.Pair;

public class RodCuttingTests {
  
  @Test
  public void testBasics() {
    int[] rodValues = new int[] { 1, 5, 8, 9, 10, 17, 17, 20, 24, 30 };
    test(rodValues, 1, 1);
    test(rodValues, 5, 2);
    test(rodValues, 8, 3);
    test(rodValues, 10, 4);
    test(rodValues, 13, 5);
    test(rodValues, 17, 6);
    test(rodValues, 18, 7);
    test(rodValues, 22, 8);
    test(rodValues, 25, 9);
    test(rodValues, 30, 10);
  }
  
  public void test(int[] rodValues, Integer expected, int rodLength) {
    RodCutting rodCutting = new RodCutting();
    Pair<List<List<Integer>>, RodCutting.MyInteger> result = rodCutting.run(rodValues, rodLength);
    // System.out.println("expected of " + expected + " for rod lengths " + rodLength);
    Assertions.assertEquals(expected, result.getValue1().value, "set enumeration method");    
    Assertions.assertEquals(expected, rodCutting.easyWork(rodValues, rodLength), "dynamic programming method");
    Assertions.assertEquals(expected, rodCutting.memoizedBottomUp(rodValues, rodLength), "dynamic programming bottom up");
    Assertions.assertEquals(expected, rodCutting.memoizedTopDown(rodValues, rodLength), "dynamic programming top down");
  }
}
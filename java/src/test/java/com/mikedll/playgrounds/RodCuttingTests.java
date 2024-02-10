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
    test(rodValues, 5, 2);
    test(rodValues, 22, 8);
    test(rodValues, 25, 9);
  }
  
  public void test(int[] rodValues, Integer expected, int rodLength) {
    RodCutting rodCutting = new RodCutting();
    Pair<List<List<Integer>>, Map<List<Integer>, Integer>> result = rodCutting.run(rodValues, rodLength);
    List<List<Integer>> optimal = result.getValue0();
    Map<List<Integer>, Integer> possibilityToValue = result.getValue1();
    for(List<Integer> el : optimal) {
      Assertions.assertEquals(expected, possibilityToValue.get(el));      
    }    
  }
}
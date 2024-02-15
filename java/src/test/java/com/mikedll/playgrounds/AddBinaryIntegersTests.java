package com.mikedll.playgrounds;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

public class AddBinaryIntegersTests {
  
  @Test
  public void testAdd() {
    for(int i=0; i<10; i++) {
      int[] A = Arrays.getRandom(10, 2);
      int[] B = Arrays.getRandom(10, 2);
      AddBinaryIntegers abi = new AddBinaryIntegers();
      int[] C = abi.add(A, B, 10);
      Assertions.assertEquals(abi.valueOf(C), abi.valueOf(A) + abi.valueOf(B));      
    }
  }
  
  @Test
  public void testValueOf() {
    AddBinaryIntegers abi = new AddBinaryIntegers();
    int[] A = new int[] { 1, 0, 1 };
    Assertions.assertEquals(5.0, abi.valueOf(A));
    int[] B = new int[] { 1, 0, 1, 1, 1 };
    Assertions.assertEquals(29.0, abi.valueOf(B));
  }
}
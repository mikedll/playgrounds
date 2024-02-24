package com.mikedll.playgrounds;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

public class FibonacciTests {
  @Test
  public void basics() {
    Fibonacci f = new Fibonacci();
    Assertions.assertEquals(55, f.getN(10));
    Assertions.assertEquals(5, f.getN(5));
    Assertions.assertEquals(0, f.getN(0));
    Assertions.assertEquals(1, f.getN(1));
    Assertions.assertEquals(1, f.getN(2));
  }
}
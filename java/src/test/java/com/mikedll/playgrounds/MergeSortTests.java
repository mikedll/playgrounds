package com.mikedll.playgrounds;

import java.util.Arrays;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class MergeSortTests {
  
  @Test
  public void testBasics() {
    MergeSort ms = new MergeSort();
    
    int[] a = new int[] { 1, 2 };
    ms.mergeSort(a, 0, 1);
    Assertions.assertArrayEquals(new int[] { 1, 2 }, a);

    int[] b = new int[] { 3, 1, 6, 2 };
    ms.mergeSort(b, 0, 3);
    Assertions.assertArrayEquals(new int[] { 1, 2, 3, 6 }, b);

    int[] c = new int[] { 12, 3, 7, 9, 14, 6, 11, 2 };
    ms.mergeSort(c, 0, 7);
    Assertions.assertArrayEquals(new int[] { 2, 3, 6, 7, 9, 11, 12, 14 }, c);
    
    int[] d = new int[] { 12, 3, 7, 9, 14 };
    ms.mergeSort(d, 0, 4);
    Assertions.assertArrayEquals(new int[] { 3, 7, 9, 12, 14 }, d);
  }
}
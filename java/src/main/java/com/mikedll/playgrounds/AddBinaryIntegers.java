package com.mikedll.playgrounds;

import java.lang.Math;

public class AddBinaryIntegers {
  
  public static void main(String[] args) {
    int n = 10;
    int[] A = Arrays.getRandom(n, 2);
    int[] B = Arrays.getRandom(n, 2);
        
    AddBinaryIntegers abi = new AddBinaryIntegers();
    
    Arrays.output("valueOf(A)=" + abi.valueOf(A) + " from A=", A);
    Arrays.output("valueOf(B)=" + abi.valueOf(B) + " from B=", B);
    
    int[] C = abi.add(A, B, n);
    Arrays.output("valueOf(C)=" + abi.valueOf(C) + " from C=", C);
  }
  
  public double valueOf(int[] bitArray) {
    double result = 0;
    for(int i=0; i<bitArray.length; i++) {
      if(bitArray[i] == 1) {
        result += Math.pow(2, i);
      }
    }
    return result;
  }
  
  public int[] add(int[] A, int[] B, int n) {
    int[] C = new int[n+1];
    boolean carry = false;
    for(int i=0; i<n; i++) {
      int bitSum = A[i] + B[i];
      if(carry) {
        bitSum += 1;
        carry = false;
      }
      if(bitSum == 1 | bitSum == 3) {
        C[i] = 1;        
      } else {
        C[i] = 0;        
      }
      if(bitSum == 2 || bitSum == 3) {
        carry = true;
      }
    }
    if(carry) {
      C[n] = 1;
    }
    return C;
  }
}
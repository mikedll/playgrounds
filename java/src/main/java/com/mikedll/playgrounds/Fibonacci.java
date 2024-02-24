package com.mikedll.playgrounds;

public class Fibonacci {
  public static void main(String[] args) {
    Fibonacci f = new Fibonacci();
    System.out.println("n=5, fibonacci(n)=" + f.getN(5));
    System.out.println("n=10, fibonacci(n)=" + f.getN(10));
  }
  
  int getN(int n) {
    int[] values = new int[n+1];
    values[0] = 0;
    
    if(n >= 1) {
      values[1] = 1;
    }
    
    if(n <= 1) {
      return values[n];
    }
    for(int i = 2; i<=n; i++) {
      values[i] = values[i-1] + values[i-2];
    }
    return values[n];
  }
}
package com.mikedll.playgrounds.topcoder;

public class A0Paper {  
  public String canBuild(int[] input) {
      int nextRung = 0;
      for(int i=input.length-1; i>=0; i--) {
          int num = input[i];
          // System.out.println("at " + i + ", num=" + num + ", nextRung=" + nextRung);
          num += nextRung;
          if(num > 0) {
            if(i > 0) {
              if(num % 2 == 1) num = num-1;
              num = num / 2;
              // System.out.println("num = num / 2=" + num);
            } 
          }
          nextRung = num;
          // System.out.println("after " + i + ", nextRung=" + nextRung);
      }
      if(nextRung > 0) {
          return "Possible";
      } else {
          return "Impossible";
      }
  }
}

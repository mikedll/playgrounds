
#import "Rectangle.h"


// Fail: @interface Square {
// Rectangle* square = [Square alloc];
// main.m:102: warning: ‘Square’ may not respond to ‘+alloc’
// main.m:102: warning: (Messages without a matching method signature
//
// Other symptom:
// *** NSInvocation: warning: object 0x1000021a0 of class 'Square' does not implement methodSignatureForSelector: -- trouble ahead
// *** NSInvocation: warning: object 0x1000021a0 of class 'Square' does not implement doesNotRecognizeSelector: -- abort
// 
// Solution:
// 
//   @interface Square : Rectangle {}
//     ...
// 
//   @interface Rectangle : NSObject {
//     ...


@interface Square : Rectangle {}

@end

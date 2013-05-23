//
//  MUS147View.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/3/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <UIKit/UIKit.h>

// the number of maximum, simultaneous touches
#define kMaxNumTouches 10

@interface MUS147View : UIView <UIAccelerometerDelegate> {
    UITouch* touch[kMaxNumTouches];
}

-(void)doTouchesOn:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)doTouchesOff:(NSSet *)touches withEvent:(UIEvent *)event;

-(SInt8)getTouchPos:(UITouch*)t;
-(SInt8)addTouch:(UITouch*)t;
-(SInt8)removeTouch:(UITouch*)t;

@end

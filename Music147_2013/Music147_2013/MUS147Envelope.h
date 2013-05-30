//
//  MUS147Envelope.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/28/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUS147Envelope : NSObject {
    
    Float64 attack;     /* seconds */
    Float64 release;    /* seconds */
    
    Float64 delta_attack;
    Float64 delta_release;
    
    Float64 delta;
    
    Float64 output;     /* 0.0 ... 1.0 */
}

@property (nonatomic,readwrite) Float64 attack;
@property (nonatomic,readwrite) Float64 release;

@property (readonly) Float64 output;

-(void)update:(UInt32)num_samples;
-(void)on;
-(void)off;

@end

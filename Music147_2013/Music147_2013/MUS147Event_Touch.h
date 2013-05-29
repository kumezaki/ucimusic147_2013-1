//
//  MUS147Event_Touch.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/17/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Event.h"

enum {
    kMUS147Event_Touch_OFF = 0,
    kMUS147Event_Touch_ON
};

@interface MUS147Event_Touch : MUS147Event {
    Float64 x;
    Float64 y;
    UInt8 type;
}

@property (readwrite) Float64 x;
@property (readwrite) Float64 y;
@property (readwrite) UInt8 type;

+(Float64)xToFreq:(Float64)x;
+(Float64)yToAmp:(Float64)y;

@end

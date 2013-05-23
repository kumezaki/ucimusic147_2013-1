//
//  MUS147Sequence.h
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MUS147Event.h"

#define kMaxNumSeqEvents 1000

@interface MUS147Sequence : NSObject {
    MUS147Event* events[kMaxNumSeqEvents];
    UInt32 numEvents;
}

@property (readwrite) UInt32 numEvents;

-(MUS147Event*)getEvent:(UInt32)pos;

-(void)addEvent:(MUS147Event*)event;

@end

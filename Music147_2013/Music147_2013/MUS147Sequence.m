//
//  MUS147Sequence.m
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Sequence.h"

#import "MUS147Event_Note.h"

@implementation MUS147Sequence

@synthesize numEvents;

-(id)init
{
    self = [super init];

#if 0
    numEvents = 0;
#else
    numEvents = 4;

    MUS147Event_Note* e;
    
    for (UInt8 i = 0; i < numEvents; i++)
    {
        e = [[MUS147Event_Note alloc] init];

        switch (i)
        {
            case 0:
                e.startTime = 0.;
                e.duration = 1.;
                e.noteNum = 60;
                e.amp = 0.35;
                break;
            case 1:
                e.startTime = 1.5;
                e.duration = 0.5;
                e.noteNum = 65;
                e.amp = 0.25;
                break;
            case 2:
                e.startTime = 2.25;
                e.duration = 0.25;
                e.noteNum = 67;
                e.amp = 0.35;
                break;
            case 3:
                e.startTime = 3.75;
                e.duration = 0.75;
                e.noteNum = 62;
                e.amp = 0.30;
                break;
            default:
                break;
        }

        events[i] = e;
    }
#endif
    
    return self;
}

-(MUS147Event*)getEvent:(UInt32)pos
{
    return events[pos];
}

-(void)addEvent:(MUS147Event*)event
{
    events[numEvents++] = event;
}

@end

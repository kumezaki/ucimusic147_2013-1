//
//  MUS147Sequencer.m
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Sequencer.h"

#import "MUS147Event_Touch.h"

@implementation MUS147Sequencer

@synthesize scoreTime;
@synthesize bpm;
@synthesize playing;
@synthesize recording;

-(id)init
{
    self = [super init];
    
    seq = [[MUS147Sequence alloc] init];
    scoreTime = 0.;
    bpm = 60.;
    playing = NO;
    recording = NO;
    
    return self;
}

-(void)advanceScoreTime:(Float64)elapsed_seconds
{
    if (!playing && !recording) return;
    
    Float64 elapsed_beats = bpm / 60. * elapsed_seconds;
    scoreTime += elapsed_beats;
    
    if (playing)
        for (UInt32 i = 0; i < seq.numEvents; i++)
        {
            MUS147Event* event = [seq getEvent:i];

            if (scoreTime < event.startTime)
            {
                // WAIT
                if (event.on)
                    [event doOff];
            }
            else if (scoreTime >= event.startTime + event.duration)
            {
                // DONE
                if (event.on)
                    [event doOff];
            }
            else
            {
                // PLAYING
                if (!event.on)
                    [event doOn];
            }
        }
}

-(void)play
{
    playing = YES;
    recording = NO;
}

-(void)stop
{
    playing = NO;
    recording = NO;

    [self allOnNotesOff];
}

-(void)rewind
{
    scoreTime = 0.;

    [self allOnNotesOff];
}

-(void)record
{
    playing = NO;
    recording = YES;
    
    // reset the number of events in the sequence
    seq.numEvents = 0;
}

-(void)allOnNotesOff
{
    for (UInt32 i = 0; i < seq.numEvents; i++)
    {
        MUS147Event* event = [seq getEvent:i];
        if (event.on)
            [event doOff];
    }
}

-(void)addTouchEvent:(Float64)x :(Float64)y :(BOOL)on
{
    if (!recording) return;
    
    if (seq.numEvents > 0)
    {
        MUS147Event* prev_e = [seq getEvent:(seq.numEvents-1)];
        prev_e.duration = scoreTime - prev_e.startTime;
        
//      NSLog(@"%f %f %f %s PREV(%f,%f)",scoreTime,x,y,on?"YES":"NO",prev_e.startTime,prev_e.duration);
    }

    MUS147Event_Touch* e = [[MUS147Event_Touch alloc] init];
    e.startTime = scoreTime;
    e.duration = MAXFLOAT;
    e.x = x;
    e.y = y;
    e.type = on ? kMUS147Event_Touch_ON : kMUS147Event_Touch_OFF;
    
    [seq addEvent:e];
}

@end

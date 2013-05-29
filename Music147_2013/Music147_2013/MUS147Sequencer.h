//
//  MUS147Sequencer.h
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MUS147Sequence.h"

@interface MUS147Sequencer : NSObject {
    MUS147Sequence* seq;
    Float64 scoreTime;
    Float64 bpm;
    BOOL playing;
    BOOL recording;
}

@property (readwrite) Float64 scoreTime;
@property (readwrite) Float64 bpm;
@property (readonly) BOOL playing;;
@property (readonly) BOOL recording;

-(void)advanceScoreTime:(Float64)elapsed_seconds;

-(void)play;
-(void)stop;
-(void)rewind;
-(void)record;

-(void)allOnNotesOff;

-(void)addTouchEvent:(Float64)x :(Float64)y :(BOOL)on;

@end

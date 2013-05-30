//
//  MUS147AQRecorder.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

#import "MUS147AQShared.h"
#import "MUS147Voice_Sample_Mem.h"

// number of buffers used by AQ system for recording
#define kNumBuffers_Recording	3

@interface MUS147AQRecorder : NSObject {
    AudioQueueRef				queue;
	AudioQueueBufferRef			buffers[kNumBuffers_Recording];
	AudioStreamBasicDescription	dataFormat;

    MUS147Voice_Sample_Mem* voice;
}

@property (retain,readwrite) MUS147Voice_Sample_Mem* voice;

-(void)setup;

-(OSStatus)start;
-(OSStatus)stop;

-(void)doAudioBuffer:(Float64*)buffer :(UInt32)num_samples;

@end

//
//  MUS147AQPlayer.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

#import "MUS147AQShared.h"
#import "MUS147Sequencer.h"
#import "MUS147Voice.h"

@class MUS147Effect;
@class MUS147Effect_BiQuad;

// number of buffers used by AQ system for playback
#define kNumBuffers_Playback     3

// number of possible voices
#define kNumVoices      4

// number of possible effects
#define kNumEffects     3

@interface MUS147AQPlayer : NSObject {

	AudioQueueRef				queue;
	AudioQueueBufferRef			buffers[kNumBuffers_Playback];
	AudioStreamBasicDescription	dataFormat;
    
    UInt8 synthVoiceType; // 0 for BLIT, 1 for BLITSaw
    
    MUS147Voice* voice[kNumVoices];
    
    MUS147Effect* effect[kNumEffects];
    
    MUS147Sequencer* sequencer;
}

@property (readwrite) UInt8 synthVoiceType;
@property (readonly) MUS147Sequencer* sequencer;

-(void)setup;

-(OSStatus)start;
-(OSStatus)stop;

-(MUS147Voice*)getVoice:(UInt8)pos;
-(MUS147Voice*)getSynthVoice;
-(MUS147Voice*)getRecordVoice;

-(MUS147Effect_BiQuad*)getBiQuad;

-(void)reportElapsedFrames:(UInt32)num_frames;

-(void)doAudioBuffer:(Float64*)buffer :(UInt32)num_samples;

@end

//
//  MUS147AQPlayer.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MUS147AQPlayer.h"

#import "MUS147Effect_BiQuad.h"
#import "MUS147Effect_Delay.h"
#import "MUS147Effect_Limiter.h"
#import "MUS147Voice_Sample_SF.h"
#import "MUS147Voice_Sample_Mem.h"
#import "MUS147Voice_Synth.h"
#import "MUS147Voice_BLIT.h"
#import "MUS147Voice_BLITSaw.h"

MUS147AQPlayer *aqp = nil;

void MUS147AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer);

void MUS147AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer)
{
    // compute the requested number of sample frames of audio
	const SInt32 numFrames = (inAQBuffer->mAudioDataBytesCapacity) / sizeof(SInt16);
    
    // create a temporary buffer of Float64 type samples
	Float64 buffer[numFrames];
    
    // set all sample values in buffer to zero (no sound)
    memset(buffer,0,sizeof(Float64)*numFrames);
	
    // call AQPlayer fillAudioBuffer method to get a new block of samples
	[aqp doAudioBuffer:buffer:numFrames];
	
    // fill the outgoing buffer as SInt16 type samples
	for (SInt32 i = 0; i < numFrames; i++)
		((SInt16 *)inAQBuffer->mAudioData)[i] = buffer[i] * (SInt16)INT16_MAX;
	
    // set the mAudioDataByteSize and mPacketDescriptionCount AudioQueueBuffer fields (for some reason)
	inAQBuffer->mAudioDataByteSize = 512;
	inAQBuffer->mPacketDescriptionCount = 0;
    
	// queue the updated AudioQueueBuffer
	AudioQueueEnqueueBuffer(inAQ, inAQBuffer, 0, nil);
    
    [aqp reportElapsedFrames:numFrames];
}

@implementation MUS147AQPlayer

@synthesize sequencer;
@synthesize synthVoiceType;

-(void)dealloc
{
	[self stop];
}

-(id)init
{
    self = [super init];

	aqp = self;
    
    // first allocate pools of voices ...
    //voice_samp_mem[0] = [[MUS147Voice_Sample_Mem alloc] init];
    
    //this is the background beat
    
    beat = [[MUS147Voice_Sample_SF alloc] initWithFile:@"beat"];
    
    //all button beats
    voice[0] = [[MUS147Voice_Sample_SF alloc] initWithFile:@"call"];
    voice[1] = [[MUS147Voice_Sample_SF alloc] initWithFile:@"crunk"];
    voice[2] = [[MUS147Voice_Sample_SF alloc] initWithFile:@"hiphop"];
    voice[3] = [[MUS147Voice_Sample_SF alloc] initWithFile:@"VEC1"];
    
    voice[4] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*4*2)];
    voice[5] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*5*2)];
    voice[6] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*6*2)];
    voice[7] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*8*2)];
    
    voice[8] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*4*3)];
    voice[9] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*5*3)];
    voice[10] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*6*3)];
    voice[11] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*8*3)];
    
    voice[12] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*4*4)];
    voice[13] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*5*4)];
    voice[14] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*6*4)];
    voice[15] = [[MUS147Voice_Synth alloc] initWithFreq:(32.7*8*4)];
    

    for (UInt8 i = 0; i < kNumEffects; i++)
    {
        switch (i)
        {
            case 0:
            {
                MUS147Effect_BiQuad* bq = [[MUS147Effect_BiQuad alloc] init];
                [bq biQuad_set:LPF:0.:5000.:kSR:1.0];
                effect[i] = bq;
                break;
            }
            case 1:
                effect[i] = [[MUS147Effect_Delay alloc] init];
                break;
            case 2:
                effect[i] = [[MUS147Effect_Limiter alloc] init];
                break;
            default:
                break;
        }
    }
    
    sequencer = [[MUS147Sequencer alloc] init];
    
	[self start];
    
	return self;
}

-(void)setup
{
	dataFormat.mFormatID = kAudioFormatLinearPCM;
	dataFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger;
	dataFormat.mChannelsPerFrame = 1;
	dataFormat.mSampleRate = kSR;
	dataFormat.mBitsPerChannel = 16;
	dataFormat.mFramesPerPacket = 1;
	dataFormat.mBytesPerPacket = sizeof(SInt16);
	dataFormat.mBytesPerFrame = sizeof(SInt16);

    OSStatus result = AudioQueueNewOutput(&dataFormat, MUS147AQBufferCallback, nil, nil, nil, 0, &queue);
	
	if (result != noErr)
		NSLog(@"AudioQueueNewOutput %ld\n",result);
	
    for (SInt32 i = 0; i < kNumBuffers_Playback; i++)
	{
		result = AudioQueueAllocateBuffer(queue, 512, &buffers[i]);
		if (result != noErr)
			NSLog(@"AudioQueueAllocateBuffer %ld\n",result);
	}
}

-(OSStatus)start
{
	OSStatus result = noErr;

    // if we have no queue, create one now
    if (queue == nil)
        [self setup];
    
    // prime the queue with some data before starting
    for (SInt32 i = 0; i < kNumBuffers_Playback; ++i)
        MUS147AQBufferCallback(nil, queue, buffers[i]);
	
    result = AudioQueueStart(queue, nil);
		
	return result;
}

-(OSStatus)stop
{
	OSStatus result = noErr;

    result = AudioQueueStop(queue, true);
	
	return result;
}

-(void)setSynthVoiceType:(UInt8)type
{
    synthVoiceType = type;
    
    switch (synthVoiceType)
    {
        case 0:
            for (UInt8 i = 0; i < kNumVoices_Synth; i++)
                voice[i+2] = voice_synth_blit[i];
            break;
        case 1:
            for (UInt8 i = 0; i < kNumVoices_Synth; i++)
                voice[i+2] = voice_synth_blitsaw[i];
            break;
    }
}

-(MUS147Voice*)getVoice:(UInt8)pos
{
    return voice[pos];
}

-(MUS147Voice*)getBeat
{
    return beat;
}

-(MUS147Effect*)getDelay
{
    return effect[1];
}

-(void)setDelay:(Float64)value
{
    effect[1] = [[MUS147Effect_Delay alloc] initWithDelayTime:value];
}

-(MUS147Effect*)getLimiter
{
    return effect[2];
}

-(MUS147Voice*)getSynthVoice
{
    MUS147Voice* v = nil;
    
    switch (synthVoiceType)
    {
        case 0:
            for (UInt8 i = 0; i < kNumVoices_Synth; i++)
                if (![voice_synth_blit[i] isOn])
                    v = voice_synth_blit[i];
            break;
        case 1:
            for (UInt8 i = 0; i < kNumVoices_Synth; i++)
                if (![voice_synth_blitsaw[i] isOn])
                    v = voice_synth_blitsaw[i];
            break;
        default:
            break;
    }

    return v;
}

-(MUS147Voice*)getRecordVoice
{
    return voice[0];
}

-(MUS147Effect_BiQuad*)getBiQuad
{
    return (MUS147Effect_BiQuad*)effect[0];
}

-(void)reportElapsedFrames:(UInt32)num_frames
{
    [sequencer advanceScoreTime:num_frames/kSR];

//    NSLog(@"%f",num_frames/kSR);
}

-(void)doAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
    for (UInt8 i = 0; i < kNumVoices; i++)
    {
        [voice[i] addToAudioBuffer:buffer:num_samples];
        [effect[2] processAudioBuffer:buffer:num_samples];
    }
    [effect[0] processAudioBuffer:buffer:num_samples];
    [effect[1] processAudioBuffer:buffer:num_samples];
    [effect[2] processAudioBuffer:buffer:num_samples];
    
    [beat addToAudioBuffer:buffer:num_samples];
    
    [effect[2] processAudioBuffer:buffer:num_samples];
}

@end

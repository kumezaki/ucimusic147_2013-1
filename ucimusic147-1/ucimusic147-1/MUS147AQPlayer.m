//
//  MUS147AQPlayer.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MUS147AQPlayer.h"

#import "MUS147Voice_Sample.h"
#import "MUS147Voice_Synth.h"

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
	[aqp fillAudioBuffer:buffer:numFrames];
	
    // fill the outgoing buffer as SInt16 type samples
	for (SInt32 i = 0; i < numFrames; i++)
		((SInt16 *)inAQBuffer->mAudioData)[i] = buffer[i] * (SInt16)INT16_MAX;
	
    // set the mAudioDataByteSize and mPacketDescriptionCount AudioQueueBuffer fields (for some reason)
	inAQBuffer->mAudioDataByteSize = 512;
	inAQBuffer->mPacketDescriptionCount = 0;
    
	// queue the updated AudioQueueBuffer
	AudioQueueEnqueueBuffer(inAQ, inAQBuffer, 0, nil);
}

@implementation MUS147AQPlayer

- (void)dealloc {

	[self stop];
}

- (id)init
{
    self = [super init];
    
	aqp = self;
    
    for (UInt8 i = 0; i < kNumVoices; i++)
    {
        voice[i] = [[MUS147Voice_Synth alloc] init];
    }
	
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
	
    for (SInt32 i = 0; i < kNumBuffers; i++)
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
    for (SInt32 i = 0; i < kNumBuffers; ++i)
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

-(MUS147Voice*)getVoice:(UInt8)pos
{
    return voice[pos];
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    for (UInt8 i = 0; i < kNumVoices; i++)
    {
        [voice[i] fillAudioBuffer:buffer:num_samples];
    }
}

@end

//
//  MUS147AQRecorder.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147AQRecorder.h"

MUS147AQRecorder *aqr = nil;

void AQRecBufferCallback (void                                *inUserData,
                          AudioQueueRef                       inAQ,
                          AudioQueueBufferRef                 inAQBuffer,
                          const AudioTimeStamp                *inStartTime,
                          UInt32                              inNumberPacketDescriptions,
                          const AudioStreamPacketDescription  *inPacketDescs
                          );

void AQRecBufferCallback (void                                *inUserData,
                          AudioQueueRef                       inAQ,
                          AudioQueueBufferRef                 inAQBuffer,
                          const AudioTimeStamp                *inStartTime,
                          UInt32                              inNumberPacketDescriptions,
                          const AudioStreamPacketDescription  *inPacketDescs
                          )
{
	const SInt32 numFrames = inNumberPacketDescriptions;
	
	SInt16 *in_buffer = (SInt16*)inAQBuffer->mAudioData;
    
//  NSLog(@"AQRecBufferCallback - %d %d [%d] [%d]", inNumberPacketDescriptions, aqr->dataFormat.mBytesPerPacket, in_buffer[0], in_buffer[1]);
	
	Float64 buffer[numFrames];
	memset(buffer,0,sizeof(Float64)*numFrames);
    
	for (SInt32 i = 0; i < inNumberPacketDescriptions; i++)
		buffer[i] = (Float64)in_buffer[i] / (SInt16)INT16_MAX;
	
	[aqr doAudioBuffer:buffer:inNumberPacketDescriptions];
    
    AudioQueueEnqueueBuffer( inAQ, inAQBuffer, 0, NULL );
}

@implementation MUS147AQRecorder

@synthesize voice;

- (void)dealloc
{
    [self stop];
}

- (id)init
{
	self = [super init];
    
	aqr = self;
    
	return self;
}

-(void)setup
{
	dataFormat.mFormatID = kAudioFormatLinearPCM;
	dataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
	dataFormat.mChannelsPerFrame = 1;
	dataFormat.mSampleRate = kSR;
	dataFormat.mBitsPerChannel = 16;
	dataFormat.mFramesPerPacket = 1;
	dataFormat.mBytesPerPacket = sizeof(SInt16);
	dataFormat.mBytesPerFrame = sizeof(SInt16);
	
    OSStatus result = AudioQueueNewInput(&dataFormat, AQRecBufferCallback, nil, nil, nil, 0, &queue);
    
	if (result != noErr)
		NSLog(@"AudioQueueNewInput %ld",result);
    
    for (SInt32 i = 0; i < kNumBuffers_Recording; ++i)
	{
		result = AudioQueueAllocateBuffer(queue, 512, &buffers[i]);
		if (result != noErr)
			NSLog(@"AudioQueueAllocateBuffer %ld",result);
	}
}

-(OSStatus)start
{
	OSStatus result = noErr;
	
    // if we have no queue, create one now
    if (queue == nil)
        [self setup];
    
    // prime the queue with some data before starting
    for (SInt32 i = 0; i < kNumBuffers_Recording; ++i)
        AudioQueueEnqueueBuffer(queue, buffers[i],0,NULL);
	
    result = AudioQueueStart(queue, nil);
	
	return result;
}

-(OSStatus)stop
{
	OSStatus result = noErr;
	
    result = AudioQueueStop(queue, true);
	
	return result;
}

-(void)doAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
//  NSLog(@"saveAudioBuffer %ld",writePos);

    if (voice != nil)
        [voice writeToSampleMemory:buffer:num_samples];
}

@end

//
//  MUS147Voice_Sample_Mem.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Voice_Sample_Mem.h"

@implementation MUS147Voice_Sample_Mem

-(id)init
{
	self = [super init];
    
	readPos = 0;
	writePos = 0;
	
	return self;
}

-(void)writeToSampleMemory:(Float64*)buffer :(UInt32)num_samples
{
    for (int i = 0; i < num_samples && writePos < kMaxRecBufferSize; i++)
		sampleMemory[writePos++] = buffer[i];
}

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
    if (writePos == 0) return;
    
	// convert the buffer of sample read from sound file into the app's internal audio buffer
	for (UInt32 buf_pos = 0; buf_pos < num_samples; buf_pos++)
	{
        if (readPos >= writePos)
            readPos -= writePos; // loop back if past writePos

		buffer[buf_pos] += amp * sampleMemory[(UInt32)readPos];

        readPos += speed;
	}
}

@end

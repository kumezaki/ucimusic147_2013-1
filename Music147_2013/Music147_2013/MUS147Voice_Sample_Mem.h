//
//  MUS147Voice_Sample_Mem.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Voice_Sample.h"

#import "MUS147AQShared.h"

// maximum record buffer size
#define kMaxRecBufferSize	(UInt32)(kSR * 5.0)

@interface MUS147Voice_Sample_Mem : MUS147Voice_Sample {

	Float64	readPos;

	UInt32	writePos;

	Float64	sampleMemory[kMaxRecBufferSize];
}

-(void)writeToSampleMemory:(Float64*)buffer :(UInt32)num_samples;

@end

//
//  MUS147Effect_Delay.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/4/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Effect_Delay.h"

@implementation MUS147Effect_Delay

-(id)init
{
    self = [super init];
    
    delayTime = 1.0;
    delaySamples = delayTime * kSR;
    
    delayAmp = 0.5;
    
    writePos = 0;
    readPos = kMaxDelaySamples - delaySamples;
    
    return self;
}

-(void)processAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
    for (UInt32 i = 0; i < num_samples; i++)
        buffer[i] += delayAmp * delayAudioBuffer[(readPos+i)%kMaxDelaySamples];
    
    readPos += num_samples;
    readPos %= kMaxDelaySamples;
    
    for (UInt32 i = 0; i < num_samples; i++)
        delayAudioBuffer[(writePos+i)%kMaxDelaySamples] = buffer[i];
    
    writePos += num_samples;
    writePos %= kMaxDelaySamples;
}

@end

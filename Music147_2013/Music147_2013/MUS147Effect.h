//
//  MUS147Effect.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/3/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MUS147AQPlayer.h"

#define kMaxDelayTime   5.0
#define kMaxDelaySamples    (UInt32)(kSR * kMaxDelayTime)

@interface MUS147Effect : NSObject {
    Float64 delayAudioBuffer[kMaxDelaySamples];
    
    Float64 delayTime;
    UInt32 delaySamples;
    
    Float64 delayAmp;

    UInt32 writePos;
    UInt32 readPos;
}

-(void)processAudioBuffer:(Float64*)buffer :(UInt32)num_samples;

@end

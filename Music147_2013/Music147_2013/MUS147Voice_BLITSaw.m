//
//  MUS147Voice_BLITSaw.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/5/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Voice_BLITSaw.h"

#import "MUS147AQPlayer.h"

@implementation MUS147Voice_BLITSaw

-(id)init
{
    self = [super init];
    
    [self setFreq:220.];
    state_ = -0.5 * a_;

    return self;
}

-(void)setFreq:(Float64)_freq
{
    [super setFreq:_freq];

    a_ = m_ / p_;
    C2_ = 1. / p_;
}

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
    // https://ccrma.stanford.edu/software/stk/classstk_1_1BlitSaw.html
    // http://www.music.mcgill.ca/~gary/courses/2013/307/week5/bandlimited.html#SECTION00027000000000000000

    for (UInt32 i = 0; i < num_samples; i++)
    {
        Float64 s = 0.;
        
        Float64 denominator = sin( phase_ );
        if ( fabs(denominator) <= 1e-12 ) {
            s = a_;
        } else {
            s =  sin( m_ * phase_ );
            s /= p_ * denominator;
        }
        s += state_ - C2_;
        state_ = s * 0.995;

        // update the envelope by one sample
        [env update:1];
        
        buffer[i] += amp * env.output * s;

        phase_ += rate_;
        if ( phase_ >= M_PI ) phase_ -= M_PI;
    }
}

@end

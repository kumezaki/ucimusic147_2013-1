//
//  MUS147Voice_BLIT.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/3/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Voice_BLIT.h"

#import "MUS147AQPlayer.h"

@implementation MUS147Voice_BLIT

-(id)init
{
    self = [super init];
    
    [self setFreq:220.];
    
    return self;
}

-(void)setFreq:(Float64)_freq
{
    freq = _freq;
    p_ = kSR / freq;
    rate_ = M_PI / p_;
    UInt32 maxHarmonics = (UInt32) floor( 0.5 * p_ );
    m_ = 2 * maxHarmonics + 1;
}

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
#if 1
    // https://ccrma.stanford.edu/software/stk/classstk_1_1Blit.html
    // http://www.music.mcgill.ca/~gary/courses/2013/307/week5/bandlimited.html#SECTION00027000000000000000

    for (UInt32 i = 0; i < num_samples; i++)
    {
        Float64 s = 0.;

        Float64 denominator = sin( phase_ );
        if ( fabs(denominator) <= 1e-12 ) {
            s = 1.0;
        } else {
            s =  sin( m_ * phase_ );
            s /= m_ * denominator;
        }
        buffer[i] += amp * s;
        phase_ += rate_;
        if ( phase_ >= M_PI ) phase_ -= M_PI;
    }
#else
    // http://sampledharmonies.blogspot.com/2011/12/all-aboard-bandlimited-impulse-train.html

    Float64 harmonics = 0.5 * kSR / freq;
    SInt32 n = floor(harmonics);
    Float64 mu = harmonics - n;

    // compute normalized angular frequency
    Float64 deltaNormPhase = freq / kSR;

    // iterate through each element in the buffer
    for (UInt32 i = 0; i < num_samples; i++)
    {
        Float64 x = normPhase * M_PI;
        Float64 y = 0.;
        Float64 s = sin(x);
        if (fabs(s)<1e-12)
            y = n*(n-1)*s;
        else {
            y = sin(n*x)*sin((1-n)*x)/s;
            y += mu * sin(n*x);
        }
        buffer[i] += amp * y / n;

        // advance the phase position
        normPhase += deltaNormPhase;
    }
#endif
}

@end

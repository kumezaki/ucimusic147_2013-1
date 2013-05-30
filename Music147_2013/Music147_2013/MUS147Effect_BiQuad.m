//
//  MUS147Effect_BiQuad.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/19/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

/* Simple implementation of Biquad filters -- Tom St Denis
 *
 * Based on the work
 
 Cookbook formulae for audio EQ biquad filter coefficients
 ---------------------------------------------------------
 by Robert Bristow-Johnson, pbjrbj@viconet.com  a.k.a. robert@audioheads.com
 
 * Available on the web at
 
 http://www.smartelectronix.com/musicdsp/text/filters005.txt
 
 * Enjoy.
 *
 * This work is hereby placed in the public domain for all purposes, whether
 * commercial, free [as in speech] or educational, etc.  Use the code and please
 * give me credit if you wish.
 *
 * Tom St Denis -- http://tomstdenis.home.dhs.org
 */

#import "MUS147Effect_BiQuad.h"

@implementation MUS147Effect_BiQuad

-(id)init
{
    self = [super init];
    
    b = malloc(sizeof(biquad));
    
    /* zero initial samples */
    b->x1 = b->x2 = 0;
    b->y1 = b->y2 = 0;
    
    return self;
}

/* Below this would be biquad.c */
/* Computes a BiQuad filter on a sample */
-(smp_type) biQuad:(smp_type)sample
{
    smp_type result;
    
    /* compute result */
    result = b->a0 * sample + b->a1 * b->x1 + b->a2 * b->x2 -
    b->a3 * b->y1 - b->a4 * b->y2;
    
    /* shift x1 to x2, sample to x1 */
    b->x2 = b->x1;
    b->x1 = sample;
    
    /* shift y1 to y2, result to y1 */
    b->y2 = b->y1;
    b->y1 = result;
    
    return result;
}

-(void) biQuad_set:(int)type :(Float64)dbGain :(Float64)freq :(Float64)srate :(Float64)bandwidth
{
    if (freq <= 0.) return;
    
    Float64 A, omega, sn, cs, alpha, beta;
    Float64 a0, a1, a2, b0, b1, b2;
    
    /* setup variables */
    A = pow(10, dbGain /40);
    omega = 2 * M_PI * freq /srate;
    sn = sin(omega);
    cs = cos(omega);
    alpha = sn * sinh(M_LN2 /2 * bandwidth * omega /sn);
    beta = sqrt(A + A);
    
    switch (type) {
        case LPF:
            b0 = (1 - cs) /2;
            b1 = 1 - cs;
            b2 = (1 - cs) /2;
            a0 = 1 + alpha;
            a1 = -2 * cs;
            a2 = 1 - alpha;
            break;
        case HPF:
            b0 = (1 + cs) /2;
            b1 = -(1 + cs);
            b2 = (1 + cs) /2;
            a0 = 1 + alpha;
            a1 = -2 * cs;
            a2 = 1 - alpha;
            break;
        case BPF:
            b0 = alpha;
            b1 = 0;
            b2 = -alpha;
            a0 = 1 + alpha;
            a1 = -2 * cs;
            a2 = 1 - alpha;
            break;
        case NOTCH:
            b0 = 1;
            b1 = -2 * cs;
            b2 = 1;
            a0 = 1 + alpha;
            a1 = -2 * cs;
            a2 = 1 - alpha;
            break;
        case PEQ:
            b0 = 1 + (alpha * A);
            b1 = -2 * cs;
            b2 = 1 - (alpha * A);
            a0 = 1 + (alpha /A);
            a1 = -2 * cs;
            a2 = 1 - (alpha /A);
            break;
        case LSH:
            b0 = A * ((A + 1) - (A - 1) * cs + beta * sn);
            b1 = 2 * A * ((A - 1) - (A + 1) * cs);
            b2 = A * ((A + 1) - (A - 1) * cs - beta * sn);
            a0 = (A + 1) + (A - 1) * cs + beta * sn;
            a1 = -2 * ((A - 1) + (A + 1) * cs);
            a2 = (A + 1) + (A - 1) * cs - beta * sn;
            break;
        case HSH:
            b0 = A * ((A + 1) + (A - 1) * cs + beta * sn);
            b1 = -2 * A * ((A - 1) + (A + 1) * cs);
            b2 = A * ((A + 1) + (A - 1) * cs - beta * sn);
            a0 = (A + 1) - (A - 1) * cs + beta * sn;
            a1 = 2 * ((A - 1) - (A + 1) * cs);
            a2 = (A + 1) - (A - 1) * cs - beta * sn;
            break;
        default:
            free(b);
            b = NULL;
            return;
    }
    
    /* precompute the coefficients */
    b->a0 = b0 /a0;
    b->a1 = b1 /a0;
    b->a2 = b2 /a0;
    b->a3 = a1 /a0;
    b->a4 = a2 /a0;
}

-(void)processAudioBuffer:(Float64*)buffer :(UInt32)num_samples;
{
    if (b != NULL)
        for (UInt32 i = 0; i < num_samples; i++)
            buffer[i] = [self biQuad:buffer[i]];
}

@end

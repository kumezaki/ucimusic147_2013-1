//
//  MUS147Event_Note.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Event_Note.h"

#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

@implementation MUS147Event_Note

@synthesize noteNum;
@synthesize amp;

-(void)doOn
{
    [super doOn];
    
    voice.amp = amp;
    voice.freq = [MUS147Event_Note noteNumToFreq:noteNum];
}

-(void)doOff
{
    voice.amp = 0.0;
    
    [super doOff];
}

+(Float64)noteNumToFreq:(Float64)note_num
{
    return pow(2.,((Float64)note_num-69)/12.)*440.;
}

@end

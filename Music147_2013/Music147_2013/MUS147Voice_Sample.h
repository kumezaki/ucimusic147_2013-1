//
//  MUS147Voice_Sample.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/22/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "MUS147Voice.h"

@interface MUS147Voice_Sample : MUS147Voice

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples;

@end

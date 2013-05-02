//
//  MUS147Voice.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/26/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUS147Voice : NSObject {

    Float64 normPhase;
    Float64 freq;
    Float64 amp;
    
    Float64 speed;
}

@property (readwrite) Float64 freq;
@property (readwrite) Float64 amp;
@property (readwrite) Float64 speed;

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples;

@end

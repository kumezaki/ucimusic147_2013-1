//
//  MUS147Event_Note.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Event.h"

@interface MUS147Event_Note : MUS147Event {
    SInt16 noteNum;
    Float64 amp;
}

@property (readwrite) SInt16 noteNum;
@property (readwrite) Float64 amp;

+(Float64)noteNumToFreq:(Float64)note_num;

@end

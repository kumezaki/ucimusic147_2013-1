//
//  MUS147Voice_Sample_SF.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/18/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Voice_Sample.h"

// the maximum number of samples we can read at one time
#define kMaxIOBufferSamples	1024

@interface MUS147Voice_Sample_SF : MUS147Voice_Sample {
    // a kind of system pointer to the audio file
    AudioFileID		fileID;

    // the buffer which will contain data read from the audio file
    SInt16			fileBuffer[kMaxIOBufferSamples];

    // the index where the next read in the file will happen
    Float64			filePos;
}

@end

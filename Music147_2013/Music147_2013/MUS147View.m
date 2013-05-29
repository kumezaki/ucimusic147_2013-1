//
//  MUS147View.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/3/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147View.h"

#import "MUS147Event_Touch.h"

#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

@implementation MUS147View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for (UInt8 i = 0; i < kMaxNumTouches; i++)
    {
        if (touch[i] == nil) continue; /* guard */
        
        // Drawing code
        UIColor *uciBlueColor = [UIColor colorWithRed:0./255. green:34./255. blue:68./255. alpha:1.];
        UIColor *uciGoldColor = [UIColor colorWithRed:255./255. green:222./255. blue:108./255. alpha:1.];

        CGPoint pt = [touch[i] locationInView:self];

        Float64 w = 30.;
        Float64 h = w;

        [uciGoldColor set];
        UIRectFill(CGRectMake(pt.x-w/2, pt.y-h/2, w, h));

        [uciBlueColor set];
        UIRectFrame(CGRectMake(pt.x-w/2, pt.y-h/2, w, h));
    }
}

-(void)doTouchesOn:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        SInt8 t_pos = [self getTouchPos:t];
        if (t_pos < 0)
        {
            t_pos = [self addTouch:t];
            if (t_pos < 0)
            {
                NSLog(@"could not add touch");
                continue;
            }
            else
                voice[t_pos] = [aqp getSynthVoice];
        }

        MUS147Voice* v = voice[t_pos];

        CGPoint pt = [t locationInView:self];
        Float64 x = pt.x/self.bounds.size.width;
        Float64 y = pt.y/self.bounds.size.height;
        
        if (v != nil)
        {
            v.amp = [MUS147Event_Touch yToAmp:y];
            v.freq = [MUS147Event_Touch xToFreq:x];
            if (!v.isOn)
                [v on];
        }
        
        if (aqp.sequencer.recording)
            [aqp.sequencer addTouchEvent:x :y :YES];

        touch[0] = t;
    }
    [self setNeedsDisplay];
}

-(void)doTouchesOff:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        SInt8 t_pos = [self removeTouch:t];
        if (t_pos < 0)
        {
            NSLog(@"could not remove touch");
            continue;
        }

        MUS147Voice* v = voice[t_pos];

        if (v != nil)
        {
//          v.amp = 0.;
            if (v.isOn)
                [v off];
        }
        
        if (aqp.sequencer.recording)
            [aqp.sequencer addTouchEvent:0. :0. :NO];

        touch[t_pos] = nil;
    }
    [self setNeedsDisplay];
}

-(SInt8)getTouchPos:(UITouch*)t
{
    for (UInt8 i = 0; i < kMaxNumTouches; i++)
        if (t == touch[i]) return i;
    return -1;
}

-(SInt8)addTouch:(UITouch*)t
{
    for (UInt8 i = 0; i < kMaxNumTouches; i++)
        if (touch[i] == nil)
        {
            touch[i] = t;
            return i;
        }
    return -1;
}

-(SInt8)removeTouch:(UITouch*)t
{
    for (UInt8 i = 0; i < kMaxNumTouches; i++)
        if (t == touch[i])
        {
            touch[i] = nil;
            return i;
        }
    return -1;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouchesOn:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouchesOn:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouchesOff:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouchesOff:touches withEvent:event];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    NSLog(@"%f %f %f",acceleration.x,acceleration.y,acceleration.z);
}

@end

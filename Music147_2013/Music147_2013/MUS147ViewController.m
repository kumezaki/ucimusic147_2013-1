//
//  MUS147ViewController.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/5/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147ViewController.h"

#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

#import "MUS147AQRecorder.h"
extern MUS147AQRecorder* aqr;

#import "MUS147Effect_BiQuad.h"

@interface MUS147ViewController ()

@end

@implementation MUS147ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setSpeed0:(id)sender
{
    [aqp getVoice:0].speed = speed0Slider.value * 2.;
}

-(IBAction)setAmp0:(id)sender
{
    [aqp getVoice:0].amp = amp0Slider.value;
}

-(IBAction)setSpeed1:(id)sender
{
    [aqp getVoice:1].speed = speed1Slider.value * 2.;
}

-(IBAction)setCutoff:(id)sender
{
    MUS147Effect_BiQuad* bq = [aqp getBiQuad];
    [bq biQuad_set:LPF:0.:(cutoffSlider.value * 10000.):kSR:1.0];
}

-(IBAction)sampleRecStart:(id)sender
{
    [aqr start];
}

-(IBAction)sampleRecStop:(id)sender
{
    [aqr stop];
}

-(IBAction)setAmp1:(id)sender
{
    [aqp getVoice:1].amp = amp1Slider.value;
}

-(IBAction)seqPlay:(id)sender
{
    [aqp.sequencer play];
}

-(IBAction)seqStop:(id)sender
{
    [aqp.sequencer stop];
}

-(IBAction)seqRewind:(id)sender
{
    [aqp.sequencer rewind];
}

-(IBAction)seqRec:(id)sender
{
    [aqp.sequencer record];
}

-(IBAction)seqWave:(id)sender
{
    aqp.synthVoiceType = waveSegmentedControl.selectedSegmentIndex;
}

@end

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

-(IBAction)setFreq0:(id)sender
{
//    [aqp getVoice:0].freq = freq0Slider.value * 1000.;
    [aqp getVoice:0].speed = freq0Slider.value * 2.;
}

-(IBAction)setAmp0:(id)sender
{
    [aqp getVoice:0].amp = amp0Slider.value;
}

-(IBAction)setFreq1:(id)sender
{
//    [aqp getVoice:1].freq = freq1Slider.value * 1000.;
    [aqp getVoice:1].speed = freq1Slider.value * 2.;
}

-(IBAction)setAmp1:(id)sender
{
    [aqp getVoice:1].amp = amp1Slider.value;
}

@end

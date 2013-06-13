//
//  MUS147ViewController.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/5/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "MUS147View.h"

@interface MUS147ViewController : UIViewController <CLLocationManagerDelegate> {
    
    // member variables here
    IBOutlet UISlider* delaySlider;
    IBOutlet UISlider* cutoffSlider;
    IBOutlet UISegmentedControl* waveSegmentedControl;
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
    IBOutlet UIButton *button4;
    IBOutlet UIButton *button5;
    IBOutlet UIButton *button6;
    IBOutlet UIButton *button7;
    IBOutlet UIButton *button8;
    IBOutlet UIButton *button9;
    IBOutlet UIButton *button10;
    IBOutlet UIButton *button11;
    IBOutlet UIButton *button12;
    IBOutlet UIButton *button13;
    IBOutlet UIButton *button14;
    IBOutlet UIButton *button15;
    IBOutlet UIButton *button16;
    IBOutlet UISlider *beatSlider;
    IBOutlet UISwitch *beatSwitch;
    IBOutlet UISegmentedControl *delaySegment;
}

// methods here

-(IBAction)playButton1:(id)sender;
-(IBAction)playButton2:(id)sender;
-(IBAction)playButton3:(id)sender;
-(IBAction)playButton4:(id)sender;
-(IBAction)playButton5:(id)sender;
-(IBAction)playButton6:(id)sender;
-(IBAction)playButton7:(id)sender;
-(IBAction)playButton8:(id)sender;
-(IBAction)playButton9:(id)sender;
-(IBAction)playButton10:(id)sender;
-(IBAction)playButton11:(id)sender;
-(IBAction)playButton12:(id)sender;
-(IBAction)playButton13:(id)sender;
-(IBAction)playButton14:(id)sender;
-(IBAction)playButton15:(id)sender;
-(IBAction)playButton16:(id)sender;

-(IBAction)stopButton1:(id)sender;
-(IBAction)stopButton2:(id)sender;
-(IBAction)stopButton3:(id)sender;
-(IBAction)stopButton4:(id)sender;
-(IBAction)stopButton5:(id)sender;
-(IBAction)stopButton6:(id)sender;
-(IBAction)stopButton7:(id)sender;
-(IBAction)stopButton8:(id)sender;
-(IBAction)stopButton9:(id)sender;
-(IBAction)stopButton10:(id)sender;
-(IBAction)stopButton11:(id)sender;
-(IBAction)stopButton12:(id)sender;
-(IBAction)stopButton13:(id)sender;
-(IBAction)stopButton14:(id)sender;
-(IBAction)stopButton15:(id)sender;
-(IBAction)stopButton16:(id)sender;

-(IBAction)startBeat:(id)sender;
-(IBAction)stopBeat:(id)sender;
-(IBAction)setBeat:(id)sender;

-(IBAction)setDelay:(id)sender;
-(IBAction)setCutoff:(id)sender;

-(IBAction)sampleRecStart:(id)sender;
-(IBAction)sampleRecStop:(id)sender;

-(IBAction)seqPlay:(id)sender;
-(IBAction)seqStop:(id)sender;
-(IBAction)seqRewind:(id)sender;
-(IBAction)seqRec:(id)sender;

-(IBAction)seqWave:(id)sender;

-(IBAction)getCurrentLocation:(id)sender;

@end

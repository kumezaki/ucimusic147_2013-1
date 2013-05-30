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

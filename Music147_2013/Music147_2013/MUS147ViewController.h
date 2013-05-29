//
//  MUS147ViewController.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/5/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface MUS147ViewController : UIViewController <CLLocationManagerDelegate> {

    // member variables here
    IBOutlet UISlider* speed0Slider;
    IBOutlet UISlider* amp0Slider;
    IBOutlet UISlider* speed1Slider;
    IBOutlet UISlider* amp1Slider;
    IBOutlet UISlider* cutoffSlider;
    IBOutlet UISegmentedControl* waveSegmentedControl;
}

// methods here
-(IBAction)setSpeed0:(id)sender;
-(IBAction)setAmp0:(id)sender;
-(IBAction)setSpeed1:(id)sender;
-(IBAction)setAmp1:(id)sender;
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

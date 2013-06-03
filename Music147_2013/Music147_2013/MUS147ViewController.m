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

@implementation MUS147ViewController {
    CLLocationManager *locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playButton1:(id)sender
{
    [aqp getVoice:0].playing = YES;
}

-(IBAction)stopButton1:(id)sender
{
    [aqp getVoice:0].playing = NO;
}

-(IBAction)playButton2:(id)sender
{
    [aqp getVoice:1].playing = YES;
}

-(IBAction)stopButton2:(id)sender
{
    [aqp getVoice:1].playing = NO;
}

-(IBAction)playButton3:(id)sender
{
    [aqp getVoice:2].playing = YES;
}

-(IBAction)stopButton3:(id)sender
{
    [aqp getVoice:2].playing = NO;
}

-(IBAction)playButton4:(id)sender
{
    [aqp getVoice:3].playing = YES;
}

-(IBAction)stopButton4:(id)sender
{
    [aqp getVoice:3].playing = NO;
}

-(IBAction)playButton5:(id)sender
{
    [aqp getVoice:4].playing = YES;
}

-(IBAction)stopButton5:(id)sender
{
    [aqp getVoice:4].playing = NO;
}

-(IBAction)playButton6:(id)sender
{
    [aqp getVoice:5].playing = YES;
}

-(IBAction)stopButton6:(id)sender
{
    [aqp getVoice:5].playing = NO;
}

-(IBAction)playButton7:(id)sender
{
    [aqp getVoice:6].playing = YES;
}

-(IBAction)stopButton7:(id)sender
{
    [aqp getVoice:6].playing = NO;
}

-(IBAction)playButton8:(id)sender
{
    [aqp getVoice:7].playing = YES;
}

-(IBAction)stopButton8:(id)sender
{
    [aqp getVoice:7].playing = NO;
}

-(IBAction)playButton9:(id)sender
{
    [aqp getVoice:8].playing = YES;
}

-(IBAction)stopButton9:(id)sender
{
    [aqp getVoice:8].playing = NO;
}

-(IBAction)playButton10:(id)sender
{
    [aqp getVoice:9].playing = YES;
}

-(IBAction)stopButton10:(id)sender
{
    [aqp getVoice:9].playing = NO;
}

-(IBAction)playButton11:(id)sender
{
    [aqp getVoice:10].playing = YES;
}

-(IBAction)stopButton11:(id)sender
{
    [aqp getVoice:10].playing = NO;
}

-(IBAction)playButton12:(id)sender
{
    [aqp getVoice:11].playing = YES;
}

-(IBAction)stopButton12:(id)sender
{
    [aqp getVoice:11].playing = NO;
}

-(IBAction)playButton13:(id)sender
{
    [aqp getVoice:12].playing = YES;
}

-(IBAction)stopButton13:(id)sender
{
    [aqp getVoice:12].playing = NO;
}

-(IBAction)playButton14:(id)sender
{
    [aqp getVoice:13].playing = YES;
}

-(IBAction)stopButton14:(id)sender
{
    [aqp getVoice:13].playing = NO;
}

-(IBAction)playButton15:(id)sender
{
    [aqp getVoice:14].playing = YES;
}

-(IBAction)stopButton15:(id)sender
{
    [aqp getVoice:14].playing = NO;
}

-(IBAction)playButton16:(id)sender
{
    [aqp getVoice:15].playing = YES;
}

-(IBAction)stopButton16:(id)sender
{
    [aqp getVoice:15].playing = NO;
}

-(IBAction)playBeat:(id)sender
{
    if(beatSwitch.isOn)
        [aqp getBeat].playing = YES;
    else    
        [aqp getBeat].playing = NO;
}

-(IBAction)setBeat:(id)sender
{
    [aqp getBeat].speed = 2*(beatSlider.value) + .5;
}

-(IBAction)setCutoff:(id)sender
{
    MUS147Effect_BiQuad* bq = [aqp getBiQuad];
    [bq biQuad_set:LPF:-3.:(cutoffSlider.value * kSR / 2. - 1000.):kSR:0.25];
}

-(IBAction)setDelay:(id)sender
{
    [aqp setDelay:delaySlider.value];
    NSLog(@"%f", delaySlider.value);
}

-(IBAction)sampleRecStart:(id)sender
{
    [aqr start];
}

-(IBAction)sampleRecStop:(id)sender
{
    [aqr stop];
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

-(IBAction)getCurrentLocation:(id)sender {

    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSLog(@"%.8f", currentLocation.coordinate.longitude);
        NSLog(@"%.8f", currentLocation.coordinate.latitude);
    }

     [locationManager stopUpdatingLocation];
}

@end

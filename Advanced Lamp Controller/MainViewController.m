//
//  MainViewController.m
//  Advanced Lamp Controller
//
//  Created by Cemil Purut on 12/28/13.
//  Copyright (c) 2013 Modern Enlarger Lamps. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface MainViewController ()

@end

@implementation MainViewController


@synthesize fStopSettingsButton;
@synthesize preferenceSettingsButton;
@synthesize connectButton;
@synthesize exposeButton;
@synthesize focusButton;
@synthesize redButton;
@synthesize resetButton;
@synthesize timeUpButton;
@synthesize timeDownButton;
@synthesize ContrastUpButton;
@synthesize ContrastDownButton;
@synthesize timeUp;
@synthesize timeDown;
@synthesize backgroundRectangle1;
@synthesize backgroundRectangle2;
//@synthesize backgroundRectangle3;
@synthesize logoView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //BLEShield Stuff
    bleShield = [[BLE alloc] init];
    [bleShield controlSetup];
    bleShield.delegate = self;
    
    // Initialize variables
    timeInSeconds = 0;
    contrastInUnits = 0;
    redOnOff = 0;
    focusOnOff = 0;
    exposeButtonOnOff = NO;
    countToTen = 0;
    timeInSecondsString = [NSMutableString stringWithFormat:@"0000"];
    
    // Initialize User Preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"NO" forKey:@"metronome"];
    [prefs setObject:@"NO" forKey:@"precisionContrast"];
    [prefs setObject:@"NO" forKey:@"precisionTiming"];
    [prefs setObject:@"NO" forKey:@"delayStartOn"];
    [prefs setObject:@"LO" forKey:@"redDimmer"];
    [prefs setObject:@"NO" forKey:@"preflash"];
    [prefs setObject:@"HI" forKey:@"brightness"];
    [prefs setObject:@"OFF" forKey:@"externalControl"];
    [prefs setObject:@"OFF" forKey:@"footSwitchControl"];
    
    // Set up Tink audio sound
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Tink.aiff", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
	audioTinkPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioTinkPlayer.numberOfLoops = 0;
    
    
    //Set up Beep audio sound
    NSURL *url2 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Beep.aiff", [[NSBundle mainBundle] resourcePath]]];
    NSError *error2;
	audioBeepPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:&error2];
	audioBeepPlayer.numberOfLoops = 0;
    
    
    //Create custom buttons
    exposeButton.layer.borderColor = [UIColor redColor].CGColor;
    [[exposeButton layer] setCornerRadius:14.0f];
    [[exposeButton layer] setBorderWidth:8.0f];
    [exposeButton setBackgroundColor:[UIColor blackColor]];
    [exposeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [exposeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    focusButton.layer.borderColor = [UIColor redColor].CGColor;
    [[focusButton layer] setCornerRadius:8.0f];
    [[focusButton layer] setBorderWidth:3.0f];
    [focusButton setBackgroundColor:[UIColor blackColor]];
    [focusButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [focusButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    resetButton.layer.borderColor = [UIColor redColor].CGColor;
    [[resetButton layer] setCornerRadius:8.0f];
    [[resetButton layer] setBorderWidth:3.0f];
    [resetButton setBackgroundColor:[UIColor blackColor]];
    [resetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    redButton.layer.borderColor = [UIColor redColor].CGColor;
    [[redButton layer] setCornerRadius:8.0f];
    [[redButton layer] setBorderWidth:3.0f];
    [redButton setBackgroundColor:[UIColor blackColor]];
    [redButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [redButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    timeUpButton.layer.borderColor = [UIColor redColor].CGColor;
    [[timeUpButton layer] setCornerRadius:8.0f];
    [[timeUpButton layer] setBorderWidth:3.0f];
    [timeUpButton setBackgroundColor:[UIColor blackColor]];
    [timeUpButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [timeUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    timeDownButton.layer.borderColor = [UIColor redColor].CGColor;
    [[timeDownButton layer] setCornerRadius:8.0f];
    [[timeDownButton layer] setBorderWidth:3.0f];
    [timeDownButton setBackgroundColor:[UIColor blackColor]];
    [timeDownButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [timeDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    ContrastUpButton.layer.borderColor = [UIColor redColor].CGColor;
    [[ContrastUpButton layer] setCornerRadius:8.0f];
    [[ContrastUpButton layer] setBorderWidth:3.0f];
    [ContrastUpButton setBackgroundColor:[UIColor blackColor]];
    [ContrastUpButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ContrastUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    ContrastDownButton.layer.borderColor = [UIColor redColor].CGColor;
    [[ContrastDownButton layer] setCornerRadius:8.0f];
    [[ContrastDownButton layer] setBorderWidth:3.0f];
    [ContrastDownButton setBackgroundColor:[UIColor blackColor]];
    [ContrastDownButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ContrastDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    preferenceSettingsButton.layer.borderColor = [UIColor redColor].CGColor;
    [[preferenceSettingsButton layer] setCornerRadius:8.0f];
    [[preferenceSettingsButton layer] setBorderWidth:3.0f];
    [preferenceSettingsButton setBackgroundColor:[UIColor blackColor]];
    [preferenceSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [preferenceSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    connectButton.layer.borderColor = [UIColor redColor].CGColor;
    [[connectButton layer] setCornerRadius:8.0f];
    [[connectButton layer] setBorderWidth:3.0f];
    [connectButton setBackgroundColor:[UIColor blackColor]];
    [connectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    backgroundRectangle1.layer.borderColor = [UIColor redColor].CGColor;
    [[backgroundRectangle1 layer] setCornerRadius:8.0f];
    [[backgroundRectangle1 layer] setBorderWidth:3.0f];
    
    backgroundRectangle2.layer.borderColor = [UIColor redColor].CGColor;
    [[backgroundRectangle2 layer] setCornerRadius:8.0f];
    [[backgroundRectangle2 layer] setBorderWidth:3.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions



#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - fStop View

- (IBAction)fStopSettingsButton:(id)sender
{
    
    
    fStopViewController *controller = [[fStopViewController alloc] initWithNibName:@"fStopViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)fStopViewControllerDidFinish:(fStopViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[audioBeepPlayer play];
}


@end

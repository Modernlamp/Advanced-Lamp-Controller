//
//  FlipsideViewController.m
//  Advanced Lamp Controller
//
//  Created by Cemil Purut on 12/28/13.
//  Copyright (c) 2013 Modern Enlarger Lamps. All rights reserved.
//

#import "FlipsideViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FlipsideViewController ()

@end

@implementation FlipsideViewController


@synthesize doneButton;
@synthesize metronomeSwitch;
@synthesize precisionTimingSwitch;
@synthesize precisionContrastSwitch;
@synthesize delayStartSwitch;
@synthesize backgroundRectangle;
@synthesize brightnessSwitch;
@synthesize preflashSwitch;
@synthesize externalControlSwitch;
@synthesize footSwitchSwitch;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set switches to proper position based on user preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *precisionTiming = [prefs stringForKey:@"precisionTiming"];
    if ([precisionTiming isEqual: @"YES"])
        [precisionTimingSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    else [precisionTimingSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    NSString *precionContrast = [prefs stringForKey:@"precisionContrast"];
    if ([precionContrast isEqual: @"YES"])
        [precisionContrastSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    else [precisionContrastSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    NSString *metronomeOn = [prefs stringForKey:@"metronome"];
    if ([metronomeOn isEqual: @"YES"])
        [metronomeSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    else [metronomeSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    NSString *delayStartOn = [prefs stringForKey:@"delayStart"];
    if ([delayStartOn isEqual: @"YES"])
        [delayStartSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    else [delayStartSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    NSString *preflash = [prefs stringForKey:@"preflash"];
    if ([preflash isEqual: @"YES"])
        [preflashSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    else [preflashSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    NSString *brightness = [prefs stringForKey:@"brightness"];
    if ([brightness isEqual: @"HI"])
        [brightnessSwitch setTitle:[NSString stringWithFormat: @"           Hi"] forState:UIControlStateNormal];
    else [brightnessSwitch setTitle:[NSString stringWithFormat: @"  Lo"] forState:UIControlStateNormal];
    
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    if ([externalControl isEqual: @"ON"])
        [externalControlSwitch setTitle:[NSString stringWithFormat: @"           On"] forState:UIControlStateNormal];
    else [externalControlSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    NSString *footSwitch = [prefs stringForKey:@"footSwitch"];
    if ([footSwitch isEqual: @"ON"])
        [footSwitchSwitch setTitle:[NSString stringWithFormat: @"           On"] forState:UIControlStateNormal];
    else [footSwitchSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    
    
    //define custom buttons
    doneButton.layer.borderColor = [UIColor redColor].CGColor;
    [[doneButton layer] setCornerRadius:8.0f];
    [[doneButton layer] setBorderWidth:3.0f];
    [doneButton setBackgroundColor:[UIColor blackColor]];
    [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    metronomeSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[metronomeSwitch layer] setCornerRadius:8.0f];
    [[metronomeSwitch layer] setBorderWidth:3.0f];
    [metronomeSwitch setBackgroundColor:[UIColor blackColor]];
    [metronomeSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [metronomeSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    precisionTimingSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[precisionTimingSwitch layer] setCornerRadius:8.0f];
    [[precisionTimingSwitch layer] setBorderWidth:3.0f];
    [precisionTimingSwitch setBackgroundColor:[UIColor blackColor]];
    [precisionTimingSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [precisionTimingSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    precisionContrastSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[precisionContrastSwitch layer] setCornerRadius:8.0f];
    [[precisionContrastSwitch layer] setBorderWidth:3.0f];
    [precisionContrastSwitch setBackgroundColor:[UIColor blackColor]];
    [precisionContrastSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [precisionContrastSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    delayStartSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[delayStartSwitch layer] setCornerRadius:8.0f];
    [[delayStartSwitch layer] setBorderWidth:3.0f];
    [delayStartSwitch setBackgroundColor:[UIColor blackColor]];
    [delayStartSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [delayStartSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    brightnessSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[brightnessSwitch layer] setCornerRadius:8.0f];
    [[brightnessSwitch layer] setBorderWidth:3.0f];
    [brightnessSwitch setBackgroundColor:[UIColor blackColor]];
    [brightnessSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [brightnessSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    preflashSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[preflashSwitch layer] setCornerRadius:8.0f];
    [[preflashSwitch layer] setBorderWidth:3.0f];
    [preflashSwitch setBackgroundColor:[UIColor blackColor]];
    [preflashSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [preflashSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    externalControlSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[externalControlSwitch layer] setCornerRadius:8.0f];
    [[externalControlSwitch layer] setBorderWidth:3.0f];
    [externalControlSwitch setBackgroundColor:[UIColor blackColor]];
    [externalControlSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [externalControlSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    footSwitchSwitch.layer.borderColor = [UIColor redColor].CGColor;
    [[footSwitchSwitch layer] setCornerRadius:8.0f];
    [[footSwitchSwitch layer] setBorderWidth:3.0f];
    [footSwitchSwitch setBackgroundColor:[UIColor blackColor]];
    [footSwitchSwitch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [footSwitchSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    backgroundRectangle.layer.borderColor = [UIColor redColor].CGColor;
    [[backgroundRectangle layer] setCornerRadius:8.0f];
    [[backgroundRectangle layer] setBorderWidth:3.0f];
    [backgroundRectangle setBackgroundColor:[UIColor blackColor]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)metronomeSwitch:(id)sender{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *metronomeOn = [prefs stringForKey:@"metronome"];
    
    
    if ([metronomeOn isEqual: @"YES"]){
        [prefs setObject:@"NO" forKey:@"metronome"];
        [metronomeSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
    else{
        [prefs setObject:@"YES" forKey:@"metronome"];
        [metronomeSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
        
    }
    
}


- (IBAction)precisionContrastSwitch:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *precisionContrast = [prefs stringForKey:@"precisionContrast"];
    
    if ([precisionContrast isEqual: @"NO"]){
        [prefs setObject:@"YES" forKey:@"precisionContrast"];
        [precisionContrastSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    }
    else{
        [prefs setObject:@"NO" forKey:@"precisionContrast"];
        [precisionContrastSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)precisionTimingSwitch:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *precisionTiming = [prefs stringForKey:@"precisionTiming"];
    
    if ([precisionTiming isEqual: @"NO"]){
        [prefs setObject:@"YES" forKey:@"precisionTiming"];
        [precisionTimingSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    }
    else{
        [prefs setObject:@"NO" forKey:@"precisionTiming"];
        [precisionTimingSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
    
    //NSLog(@"tenthSeconds = %@",[prefs stringForKey:@"precisionTiming"]);
    
}


- (IBAction)delayStartSwitch:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *delayStartOn = [prefs stringForKey:@"delayStart"];
    
    if ([delayStartOn isEqual: @"NO"]){
        [prefs setObject:@"YES" forKey:@"delayStart"];
        [delayStartSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    }
    else{
        [prefs setObject:@"NO" forKey:@"delayStart"];
        [delayStartSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
}


- (IBAction)preflashSwitch:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *preflash = [prefs stringForKey:@"preflash"];
    
    if ([preflash isEqual: @"NO"]){
        [prefs setObject:@"YES" forKey:@"preflash"];
        [preflashSwitch setTitle:[NSString stringWithFormat: @"          On"] forState:UIControlStateNormal];
    }
    else{
        [prefs setObject:@"NO" forKey:@"preflash"];
        [preflashSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
}


- (IBAction)brightnessSwitch:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *brightness = [prefs stringForKey:@"brightness"];
    
    if ([brightness isEqual: @"LO"]){
        [prefs setObject:@"HI" forKey:@"brightness"];
        [brightnessSwitch setTitle:[NSString stringWithFormat: @"           Hi"] forState:UIControlStateNormal];
    }
    else{
        [prefs setObject:@"LO" forKey:@"brightness"];
        [brightnessSwitch setTitle:[NSString stringWithFormat: @"  Lo"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)externalControlSwitch:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){
        [prefs setObject:@"ON" forKey:@"externalControl"];
        [externalControlSwitch setTitle:[NSString stringWithFormat: @"           On"] forState:UIControlStateNormal];
        [prefs setObject:@"OFF" forKey:@"footSwitch"];
        [footSwitchSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        [prefs setObject:@"NO" forKey:@"delayStart"];
        [delayStartSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
    else{
        [prefs setObject:@"OFF" forKey:@"externalControl"];
        [externalControlSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)footSwitchSwitch:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *footSwitch = [prefs stringForKey:@"footSwitch"];
    
    if ([footSwitch isEqual: @"OFF"]){
        [prefs setObject:@"ON" forKey:@"footSwitch"];
        [footSwitchSwitch setTitle:[NSString stringWithFormat: @"           On"] forState:UIControlStateNormal];
        [prefs setObject:@"OFF" forKey:@"externalControl"];
        [externalControlSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        [prefs setObject:@"NO" forKey:@"delayStart"];
        [delayStartSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
    else{
        [prefs setObject:@"OFF" forKey:@"footSwitch"];
        [footSwitchSwitch setTitle:[NSString stringWithFormat: @"  Off"] forState:UIControlStateNormal];
        
    }
}



- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end

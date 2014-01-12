//
//  MainViewController.m
//  Advanced Lamp Controller
//
//  Created by Cemil Purut on 12/28/13.
//  Copyright (c) 2013 Modern Enlarger Lamps. All rights reserved.
//

#import "alc_MainViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface MainViewController ()

@end

@implementation MainViewController


@synthesize fStopSettingsButton;
@synthesize preferenceSettingsButton;
@synthesize connectButton;
@synthesize exposeButton;
@synthesize focusButton;
@synthesize positionButton;
@synthesize resetButton;
@synthesize timeUpButton;
@synthesize timeDownButton;
@synthesize ContrastUpButton;
@synthesize ContrastDownButton;
@synthesize backgroundRectangle1;
@synthesize backgroundRectangle2;
@synthesize logoView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //BLEShield Stuff
    bleShield = [[BLE alloc] init];
    [bleShield controlSetup];
    bleShield.delegate = self;
    
    // Initialize variables
    contrastValueTimesTen = 25;
    timeInSeconds = 0;
    contrastInUnits = 0;
    redOnOff = 0;
    focusOnOff = 0;
    exposeButtonIsOn = NO;
    countToTen = 0;
    timeInSecondsString = [NSMutableString stringWithFormat:@"0000"];
    thinBorderWidth=2.0;
    thickBorderWidth=8.0;
    
    
    // Initialize User Preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"NO" forKey:@"metronome"];
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
    [[exposeButton layer] setCornerRadius:12.0f];
    [[exposeButton layer] setBorderWidth:6.0f];
    [exposeButton setBackgroundColor:[UIColor blackColor]];
    [exposeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [exposeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    focusButton.layer.borderColor = [UIColor redColor].CGColor;
    [[focusButton layer] setCornerRadius:8.0f];
    [[focusButton layer] setBorderWidth:thinBorderWidth];
    [focusButton setBackgroundColor:[UIColor blackColor]];
    [focusButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [focusButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    resetButton.layer.borderColor = [UIColor redColor].CGColor;
    [[resetButton layer] setCornerRadius:8.0f];
    [[resetButton layer] setBorderWidth:thinBorderWidth];
    [resetButton setBackgroundColor:[UIColor blackColor]];
    [resetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    positionButton.layer.borderColor = [UIColor redColor].CGColor;
    [[positionButton layer] setCornerRadius:8.0f];
    [[positionButton layer] setBorderWidth:thinBorderWidth];
    [positionButton setBackgroundColor:[UIColor blackColor]];
    [positionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [positionButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    timeUpButton.layer.borderColor = [UIColor redColor].CGColor;
    [[timeUpButton layer] setCornerRadius:8.0f];
    [[timeUpButton layer] setBorderWidth:thinBorderWidth];
    [timeUpButton setBackgroundColor:[UIColor blackColor]];
    [timeUpButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [timeUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    timeDownButton.layer.borderColor = [UIColor redColor].CGColor;
    [[timeDownButton layer] setCornerRadius:8.0f];
    [[timeDownButton layer] setBorderWidth:thinBorderWidth];
    [timeDownButton setBackgroundColor:[UIColor blackColor]];
    [timeDownButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [timeDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    ContrastUpButton.layer.borderColor = [UIColor redColor].CGColor;
    [[ContrastUpButton layer] setCornerRadius:8.0f];
    [[ContrastUpButton layer] setBorderWidth:thinBorderWidth];
    [ContrastUpButton setBackgroundColor:[UIColor blackColor]];
    [ContrastUpButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ContrastUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    ContrastDownButton.layer.borderColor = [UIColor redColor].CGColor;
    [[ContrastDownButton layer] setCornerRadius:8.0f];
    [[ContrastDownButton layer] setBorderWidth:thinBorderWidth];
    [ContrastDownButton setBackgroundColor:[UIColor blackColor]];
    [ContrastDownButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ContrastDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    preferenceSettingsButton.layer.borderColor = [UIColor redColor].CGColor;
    [[preferenceSettingsButton layer] setCornerRadius:8.0f];
    [[preferenceSettingsButton layer] setBorderWidth:thinBorderWidth];
    [preferenceSettingsButton setBackgroundColor:[UIColor blackColor]];
    [preferenceSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [preferenceSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    connectButton.layer.borderColor = [UIColor redColor].CGColor;
    [[connectButton layer] setCornerRadius:8.0f];
    [[connectButton layer] setBorderWidth:thinBorderWidth];
    [connectButton setBackgroundColor:[UIColor blackColor]];
    [connectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    backgroundRectangle1.layer.borderColor = [UIColor redColor].CGColor;
    [[backgroundRectangle1 layer] setCornerRadius:8.0f];
    [[backgroundRectangle1 layer] setBorderWidth:thinBorderWidth];
    
    backgroundRectangle2.layer.borderColor = [UIColor redColor].CGColor;
    [[backgroundRectangle2 layer] setCornerRadius:8.0f];
    [[backgroundRectangle2 layer] setBorderWidth:thinBorderWidth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Actions

- (IBAction)exposeButtonPressed:(id)sender{  // This action is taken when the START button is pressed
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *metronomeOn = [prefs stringForKey:@"metronome"];
    NSString *delayStartOn = [prefs stringForKey:@"delayStart"];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){
        
        if (exposeButtonIsOn == NO){
            exposeButtonIsOn = YES;
            
            //turn off the POSITION and FOCUS buttons
            redOnOff = 0;
            [[positionButton layer] setBorderWidth:thinBorderWidth];
            focusOnOff = 0;
            [[focusButton layer] setBorderWidth:thinBorderWidth];
            
            if ([delayStartOn isEqual: @"YES"]){
                holdTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(bleShieldSendData) userInfo:nil repeats:NO];
                [self bleShieldSendFiveSecRed];}
            else{
                [self bleShieldSendData];}
        }
        else{
            [holdTimer invalidate];
            [self bleShieldSendNull];
            
            exposeButtonIsOn = NO;
            [exposeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
            [exposeButton setBackgroundColor:[UIColor blackColor]];
            if ([metronomeOn isEqual: @"YES"]) [audioBeepPlayer play];
            
            //turn off the POSITION and FOCUS buttons
            redOnOff = 0;
            [[positionButton layer] setBorderWidth:thinBorderWidth];
            focusOnOff = 0;
            [[focusButton layer] setBorderWidth:thinBorderWidth];
            
        }
    }
}


-(void)bleShieldSendData{
    
    NSString *s;
    NSData *d;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *brightness = [prefs stringForKey:@"brightness"];
    NSString *preflash = [prefs stringForKey:@"preflash"];
 
    timeCountDown = timeInTenthSeconds;
    countToTen = 10;
    [self timerTenthTick:nil];

    if ([brightness isEqual: @"HI"]){brightnessMultiplier = 51;}
    else {brightnessMultiplier = 12;}
    
    if ([preflash isEqual: @"YES"]){brightnessMultiplier = 2;}
    
    // Calculate the timeInSecondsString properly    
    if (timeInTenthSeconds < 10) timeInSecondsString = [NSMutableString stringWithFormat: @"000%i", timeInTenthSeconds];
    if (timeInTenthSeconds >=10 && timeInSeconds <100) timeInSecondsString = [NSMutableString stringWithFormat: @"00%i", timeInTenthSeconds];
    if (timeInTenthSeconds >=100 && timeInTenthSeconds <1000) timeInSecondsString = [NSMutableString stringWithFormat: @"0%i", timeInTenthSeconds];
    if (timeInTenthSeconds >=1000) timeInSecondsString = [NSMutableString stringWithFormat: @"%i", timeInTenthSeconds];
    
    // Calculate the Green LED Brightness and format the greenBrightness string properly
    greenBrightness = floor(((5-((float)contrastValueTimesTen)/10)*brightnessMultiplier) + .5);
    if (greenBrightness<10)greenBrightnessString = [NSMutableString stringWithFormat:@"00%i", greenBrightness];
    if (greenBrightness>=10 && greenBrightness<100) greenBrightnessString = [NSMutableString stringWithFormat:@"0%i", greenBrightness];
    if (greenBrightness>=100 && greenBrightness<1000) greenBrightnessString = [NSMutableString stringWithFormat:@"%i", greenBrightness];
    
    
    // Calculate the Blue LED Brightness and format the blueBrightness string properly
    blueBrightness = floor(((((float)contrastValueTimesTen)/10)*brightnessMultiplier) + .5);
    if (blueBrightness<10)blueBrightnessString = [NSMutableString stringWithFormat:@"00%i", blueBrightness];
    if (blueBrightness>=10 && blueBrightness<100) blueBrightnessString = [NSMutableString stringWithFormat:@"0%i", blueBrightness];
    if (blueBrightness>=100 && blueBrightness<1000) blueBrightnessString = [NSMutableString stringWithFormat:@"%i", blueBrightness];
    
    
    s = [NSString stringWithFormat:@"000%@000%@%@\r\n",timeInSecondsString, greenBrightnessString, blueBrightnessString];
    d = [s dataUsingEncoding:NSUTF8StringEncoding];
    [bleShield write:d];
    
}

-(void)bleShieldSendFiveSecRed{
    
    NSString *s;
    NSData *d;
    
    timeCountDown = 50;
    countToTen = 10;
    [self timerTenthTick:nil];
    
    s = [NSString stringWithFormat:@"0000050127000000\r\n"];
    d = [s dataUsingEncoding:NSUTF8StringEncoding];
    [bleShield write:d];
}


-(void)bleShieldSendNull{
    
    NSString *s;
    NSData *d;
    
    s = [NSString stringWithFormat:@"0000000000000000\r\n"];
    d = [s dataUsingEncoding:NSUTF8StringEncoding];
    [bleShield write:d];
    
}

- (void)timerTenthTick:(id)sender{/* This is where the countdown occurs.  You arrive here when a data packet is received from the Arduino. These data packets arrive every 0.1s as countdown is in progress. The arrival of the data packet alone triggers this call; the value of the data itself is not used.*/
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *metronomeOn = [prefs stringForKey:@"metronome"];
    NSString *precisionTiming = [prefs stringForKey:@"precisionTiming"];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    
    if ([externalControl isEqual: @"OFF"]){
        // Reset the START button when the countdown reaches 0.
        if (timeCountDown <= 0){
            exposeButtonIsOn = NO;
            countToTen=0;
            [exposeButton setBackgroundColor:[UIColor blackColor]];
            [exposeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
            if (([metronomeOn isEqual: @"YES"]) && (redOnOff == 0) && (focusOnOff == 0))[audioBeepPlayer play];
            
            //turn off the POSITION and FOCUS buttons
            redOnOff = 0;
            [[positionButton layer] setBorderWidth:thinBorderWidth];
            focusOnOff = 0;
            [[focusButton layer] setBorderWidth:thinBorderWidth];
            
        }
        
        // Otherwise display the countdown time on the START buttton
        else{
            if (exposeButtonIsOn == YES){
                if((timeInTenthSeconds > 999) || ([precisionTiming isEqual: @"NO"]))[exposeButton setTitle:[NSString stringWithFormat: @"%i", (timeCountDown+9)/10] forState:UIControlStateNormal];
                else[exposeButton setTitle:[NSString stringWithFormat: @"%i.%i", timeCountDown/10, timeCountDown%10] forState:UIControlStateNormal];
                
                if (([metronomeOn isEqual: @"YES"]) && (countToTen == 10) && (redOnOff == 0) && (focusOnOff == 0)){
                    [audioTinkPlayer play];
                    countToTen = 0;
                }
                timeCountDown=timeCountDown-1;
                countToTen = countToTen+1;
            }
        }
    }
}

- (IBAction)contrastChangeUpStart:(id)sender {//This action is taken when the Up contrast button is PRESSED.
    holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(zipContrastUp) userInfo:nil repeats:NO];
    [self contrastUp];
}

- (void)zipContrastUp{
    holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.18 target:self selector:@selector(contrastUp) userInfo:nil repeats:YES];
    [holdTimer fire];
}

- (void)contrastUp{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    contrastValueTimesTen = contrastValueTimesTen + 1;
    if (contrastValueTimesTen > 50) contrastValueTimesTen = 50;
    if (contrastValueTimesTen % 10 == 0)[contrastField setText:[NSString stringWithFormat: @"%1.0f", (float)contrastValueTimesTen/10]];
    else [contrastField setText:[NSString stringWithFormat: @"%1.1f", (float)contrastValueTimesTen/10]];
    
    if([externalControl isEqual:@"ON"]) [self bleShieldSendData];
}

- (IBAction)contrastChangeDownStart:(id)sender {//This action is taken when the Up contrast button is PRESSED.
    holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(zipContrastDown) userInfo:nil repeats:NO];
    [self contrastDown];
}

- (void)zipContrastDown{
    holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.18 target:self selector:@selector(contrastDown) userInfo:nil repeats:YES];
    [holdTimer fire];
}

- (void)contrastDown{ // This action occurs when the Down CONTRAST button is pressed
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    contrastValueTimesTen = contrastValueTimesTen - 1;
    if (contrastValueTimesTen < 0) contrastValueTimesTen = 0;
    if (contrastValueTimesTen % 10 == 0)[contrastField setText:[NSString stringWithFormat: @"%1.0f", (float)contrastValueTimesTen/10]];
    else [contrastField setText:[NSString stringWithFormat: @"%1.1f", (float)contrastValueTimesTen/10]];
    
    if([externalControl isEqual:@"ON"])[self bleShieldSendData];
}


- (IBAction)timeChangeUpStart:(id)sender {//This action is taken when the Up seconds button is PRESSED.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){ // Disabled when under External Control.
        holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(zipTimeUp) userInfo:nil repeats:NO];
        [self timeUp];
    }
}

- (void)zipTimeUp{
    holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(timeUp) userInfo:nil repeats:YES];
    [holdTimer fire];
}

- (void) timeUp{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *precisionTiming = [prefs stringForKey:@"precisionTiming"];
    
    if ([precisionTiming isEqual: @"YES"] && timeInTenthSeconds <=999){
        timeInTenthSeconds=timeInTenthSeconds+1;
        if (timeInTenthSeconds >9999) timeInTenthSeconds = 9999;
        [timeField setText:[NSString stringWithFormat: @"%i.%i", timeInTenthSeconds/10, timeInTenthSeconds % 10]];
    }
    else{
        timeInTenthSeconds=timeInTenthSeconds+10;
        if (timeInTenthSeconds >9999) timeInTenthSeconds = 9999;
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds/10]];
    }
}

- (IBAction)timeChangeDownStart:(id)sender {// This action is taken when the Down seconds button is PRESSED.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){ // Disabled when under External Control.
        holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(zipTimeDown) userInfo:nil repeats:NO];
        [self timeDown];
    }
}

- (void)zipTimeDown{
    holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
    [holdTimer fire];
}

- (void) timeDown{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *precisionTiming = [prefs stringForKey:@"precisionTiming"];
    
    if ([precisionTiming isEqual: @"YES"] && timeInTenthSeconds <=1000){
        timeInTenthSeconds=timeInTenthSeconds-1;
        if (timeInTenthSeconds < 0) timeInTenthSeconds = 0;
        [timeField setText:[NSString stringWithFormat: @"%i.%i", timeInTenthSeconds/10, timeInTenthSeconds % 10]];
    }
    else{
        timeInTenthSeconds=timeInTenthSeconds-10;
        if (timeInTenthSeconds < 0) timeInTenthSeconds = 0;
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds/10]];
    }
}

- (IBAction)zipChangeStop:(id)sender { // This action is taken when either the UP or Down seconds buttons are RELEASED.
    [holdTimer invalidate];
    [holdTimer invalidate];

}

- (IBAction)positionButtonPressed:(id)sender {  //This action occurs when the POSITION button is pressed. For safety, action is taken only when an exposure is not in progress.
    
    NSString *s;
    NSData *d;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){ //disable the position button when under external control
        if (redOnOff == 0){
            
            if (exposeButtonIsOn == NO){ // Check that an exposure is not in progress
                redOnOff = 1;
                [[positionButton layer] setBorderWidth:thickBorderWidth];
               
                // Set up the countdown timer and the time display
                exposeButtonIsOn = YES;
                timeCountDown = 3600;
                countToTen = 10;
                [self timerTenthTick:nil];
                
                //turn off the FOCUS button
                focusOnOff = 0;
                [[focusButton layer] setBorderWidth:thinBorderWidth];
                
                // Send Arduino command to turn on the red LED only for 6 minutes (3600 tenths of a second).
                s = [NSString stringWithFormat:@"0003600255000000\r\n"];
                d = [s dataUsingEncoding:NSUTF8StringEncoding];
                [bleShield write:d];
            }
        }
        else{
            // Reset the FOCUS button
            redOnOff = 0;
            [[positionButton layer] setBorderWidth:thinBorderWidth];
           
            // Send the Arduino the command to turn everything off
            [self bleShieldSendNull];
            
            //  Reset the START button
            exposeButtonIsOn = NO;
            [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
            
        }
    }
}

- (IBAction)focusButtonPressed:(id)sender { //This action occurs when the FOCUS button is pressed.  For safety, action is taken only when an exposure is not in progress.
    
    NSString *s;
    NSData *d;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){//disable the focus button when under external control
        if (focusOnOff == 0){
            if (exposeButtonIsOn == NO){ // Check that an exposure is not in progress
                
                focusOnOff = 1;
                [[focusButton layer] setBorderWidth:thickBorderWidth];
                
                // Set up the countdown timer and the time display
                exposeButtonIsOn = YES;
                timeCountDown = 3600;
                countToTen = 10;
                [self timerTenthTick:nil];
                
                //turn off the POSITION button
                redOnOff = 0;
                [[positionButton layer] setBorderWidth:thinBorderWidth];
                
                // Send Arduino command to turn on blue and green LEDs for 6 minutes (3600 tenths of a second).
                s = [NSString stringWithFormat:@"0003600000255255\r\n"];
                d = [s dataUsingEncoding:NSUTF8StringEncoding];
                [bleShield write:d];
            }
        }
        else{
            focusOnOff = 0;
            [[focusButton layer] setBorderWidth:thinBorderWidth];
            
            // Send the Arduino the command to turn everything off
            [self bleShieldSendNull];
        
            //  Reset the START button
            exposeButtonIsOn = NO;
            [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
        }
    }
}

- (IBAction)resetButtonPressed:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *metronomeOn = [prefs stringForKey:@"metronome"];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    
    if ([externalControl isEqual: @"OFF"]){
        // Set Contrast, Time, and Blue brightness to 0, green brightness to 255
        contrastValueTimesTen = 25;
        [contrastField setText:[NSString stringWithFormat: @"2.5"]];
        timeInTenthSeconds = 0;
        timeCountDown = 0;
        timeInSecondsString = [NSMutableString stringWithFormat: @"0000"];
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds]];
        greenBrightness = 255;
        blueBrightness = 0;
        
        // Reset START button (exposeButton)
        exposeButtonIsOn = NO;
        [exposeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
        [exposeButton setBackgroundColor:[UIColor blackColor]];
        if ([metronomeOn isEqual: @"YES"]) [audioBeepPlayer play];
        
        // Reset FOCUS button (focusButton)
        focusOnOff = 0;
        [[focusButton layer] setBorderWidth:thinBorderWidth];
        
        //Reset POSITION button (redButton)
        redOnOff = 0;
        [[positionButton layer] setBorderWidth:thinBorderWidth];
        
        [holdTimer invalidate];
        [holdTimer invalidate];

        
        [self bleShieldSendNull];
    }
}


- (IBAction)connectButtonPressed:(id)sender {
    
    if (bleShield.activePeripheral)
        if(bleShield.activePeripheral.isConnected){
            [self resetButtonPressed:Nil];
            [[bleShield CM] cancelPeripheralConnection:[bleShield activePeripheral]];
            return;
        }
    
    if (bleShield.peripherals) bleShield.peripherals = nil;
    
    [bleShield findBLEPeripherals:3];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [self.spinner startAnimating];
}


// Called when scan period is over to connect to the first found peripheral
-(void) connectionTimer:(NSTimer *)timer{
    if(bleShield.peripherals.count > 0)[bleShield connectPeripheral:[bleShield.peripherals objectAtIndex:0]];
    else[self.spinner stopAnimating];
}


- (void) bleDidDisconnect{
    [connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    UIImage *img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"default" ofType:@"png"]];
    [logoView setImage:img];
    
    //Send the OFF external control code upon disconnecting
    NSString *s;
    NSData *d;
    s = [NSString stringWithFormat:@"0050000000000000\r\n"];
    d = [s dataUsingEncoding:NSUTF8StringEncoding];
    [bleShield write:d];
}


-(void) bleDidConnect{
    
    NSString *s;
    NSData *d;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    NSString *footSwitch = [prefs stringForKey:@"footSwitch"];
    NSString *brightness = [prefs stringForKey:@"brightness"];
    NSString *preflash = [prefs stringForKey:@"preflash"];
    
    
    [self.spinner stopAnimating];
    [connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];

    [audioTinkPlayer play];
    UIImage *img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ModernEnlargerLogo" ofType:@"png"]];
    [logoView setImage:img];
    
    //Send the external control code immediately upon connecting
    if ([externalControl isEqual: @"ON"]){
        
        
        // Set Contrast, Time, and Blue brightness to 0, green brightness to 255
        contrastInUnits = 0;
        [contrastField setText:[NSString stringWithFormat: @"%1.0f", contrastInUnits]];
        timeInTenthSeconds = 0;
        timeCountDown = 0;
        timeInSecondsString = [NSMutableString stringWithFormat: @"0000"];
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds]];
        greenBrightness = 255;
        blueBrightness = 0;
        
        if ([brightness isEqual: @"HI"])s = [NSString stringWithFormat:@"0070000000255000\r\n"];
        else s = [NSString stringWithFormat:@"0070000000060000\r\n"];
        if ([preflash isEqual: @"YES"])s = [NSString stringWithFormat:@"0070000000010000\r\n"];
        d = [s dataUsingEncoding:NSUTF8StringEncoding];
        [bleShield write:d];
        
        [exposeButton setTitle:@"External" forState:UIControlStateNormal];

    }
    else if ([footSwitch isEqual: @"ON"]){
        timeInTenthSeconds = 0;
        timeCountDown = 0;
        timeInSecondsString = [NSMutableString stringWithFormat: @"0000"];
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds]];
        s = [NSString stringWithFormat:@"0060000000000000\r\n"];
        [bleShield write:d];
    }
    else{
        
        s = [NSString stringWithFormat:@"0050000000000000\r\n"];
        d = [s dataUsingEncoding:NSUTF8StringEncoding];
        [bleShield write:d];
    }
}


-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
    //NSData *d = [NSData dataWithBytes:data length:length];
    //NSString *s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    [self timerTenthTick:nil];
}


-(void) bleDidUpdateRSSI:(NSNumber *)rssi
{
    //self.labelRSSI.text = rssi.stringValue;
}



#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *precisionTiming = [prefs stringForKey:@"precisionTiming"];
    NSString *externalControl = [prefs stringForKey:@"externalControl"];
    NSString *footSwitch = [prefs stringForKey:@"footSwitch"];

    //send the external control code
    NSString *s;
    NSData *d;
    if ([externalControl isEqual: @"ON"]){
        
        // Send Contrast and Time=0
        timeInTenthSeconds = 0;
        timeCountDown = 0;
        timeInSecondsString = [NSMutableString stringWithFormat: @"0000"];
        
        s = [NSString stringWithFormat:@"0070000000000000\r\n"];
        d = [s dataUsingEncoding:NSUTF8StringEncoding];
        [bleShield write:d];

        [self bleShieldSendData];
        
        [exposeButton setTitle:@"External" forState:UIControlStateNormal];
        [[focusButton layer] setBorderWidth:thinBorderWidth];
        [[positionButton layer] setBorderWidth:thinBorderWidth];
        
    }
    else if ([footSwitch isEqual: @"ON"]){
        s = [NSString stringWithFormat:@"0060000000000000\r\n"];
        d = [s dataUsingEncoding:NSUTF8StringEncoding];
        [bleShield write:d];
        timeInTenthSeconds = 0;
        timeCountDown = 0;
        timeInSecondsString = [NSMutableString stringWithFormat: @"0000"];
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds]];
        [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
        
    }
    else{
        s = [NSString stringWithFormat:@"0050000000000000\r\n"];
        d = [s dataUsingEncoding:NSUTF8StringEncoding];
        [bleShield write:d];
        [exposeButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    //format the timefield correctly when precisionTiming is changed
    if (([precisionTiming isEqual: @"YES"]) && (timeInTenthSeconds <999))
        [timeField setText:[NSString stringWithFormat: @"%i.%i", timeInTenthSeconds/10, timeInTenthSeconds % 10]];
    else{
        timeInTenthSeconds = timeInTenthSeconds/10;
        timeInTenthSeconds = timeInTenthSeconds*10;
        [timeField setText:[NSString stringWithFormat: @"%i", timeInTenthSeconds/10]];
    }
    
    //set the timeInSecondsString properly to reflect the updated timeInTenthSeconds
    if (timeInTenthSeconds < 10) timeInSecondsString = [NSMutableString stringWithFormat: @"000%i", timeInTenthSeconds];
    if (timeInTenthSeconds >=10 && timeInSeconds <100) timeInSecondsString = [NSMutableString stringWithFormat: @"00%i", timeInTenthSeconds];
    if (timeInTenthSeconds >=100 && timeInTenthSeconds <1000) timeInSecondsString = [NSMutableString stringWithFormat: @"0%i", timeInTenthSeconds];
    if (timeInTenthSeconds >=1000) timeInSecondsString = [NSMutableString stringWithFormat: @"%i", timeInTenthSeconds];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showFlipSide"]) {
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

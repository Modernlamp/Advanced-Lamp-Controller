//
//  MainViewController.h
//  Advanced Lamp Controller
//
//  Created by Cemil Purut on 12/28/13.
//  Copyright (c) 2013 Modern Enlarger Lamps. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "fStopViewController.h"
#import "BLE.h"



@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, fStopViewControllerDelegate, BLEDelegate, AVAudioPlayerDelegate>
{
    float contrastInUnits;
    float timeInSeconds;
    float thinBorderWidth;
    float thickBorderWidth;
    int contrastValueTimesTen;
    int timeInTenthSeconds;
    int integerContrastInUnits;
    
    int redOnOff;
    int countToTen;
    int focusOnOff;
    int timeCountDown;
    int brightnessMultiplier;
    
    bool exposeButtonIsOn;
    id holdTimer;
    int blueBrightness;
    int greenBrightness;
    bool timeInTenthsYesNo;
    
    NSMutableString *timeInSecondsString;
    NSMutableString *greenBrightnessString;
    NSMutableString *blueBrightnessString;
    
    AVAudioPlayer *audioTinkPlayer;
    AVAudioPlayer *audioBeepPlayer;
    BLE *bleShield;
    
    IBOutlet UILabel *timeField;
    IBOutlet UILabel *contrastField;
}



@property (weak, nonatomic) IBOutlet UIButton *fStopSettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *preferenceSettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *positionButton;
@property (weak, nonatomic) IBOutlet UIButton *exposeButton;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *timeUpButton;
@property (weak, nonatomic) IBOutlet UIButton *timeDownButton;
@property (weak, nonatomic) IBOutlet UIButton *ContrastUpButton;
@property (weak, nonatomic) IBOutlet UIButton *ContrastDownButton;
@property (weak, nonatomic) IBOutlet UIButton *backgroundRectangle1;
@property (weak, nonatomic) IBOutlet UIButton *backgroundRectangle2;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;




@end


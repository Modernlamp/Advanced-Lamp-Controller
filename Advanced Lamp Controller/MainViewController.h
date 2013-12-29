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

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, fStopViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *fStopSettingsButton;


@end


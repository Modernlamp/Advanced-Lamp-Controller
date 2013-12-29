//
//  FlipsideViewController.h
//  Advanced Lamp Controller
//
//  Created by Cemil Purut on 12/28/13.
//  Copyright (c) 2013 Modern Enlarger Lamps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *metronomeSwitch;
@property (weak, nonatomic) IBOutlet UIButton *precisionContrastSwitch;
@property (weak, nonatomic) IBOutlet UIButton *precisionTimingSwitch;
@property (weak, nonatomic) IBOutlet UIButton *delayStartSwitch;
@property (weak, nonatomic) IBOutlet UIButton *preflashSwitch;
@property (weak, nonatomic) IBOutlet UIButton *brightnessSwitch;
@property (weak, nonatomic) IBOutlet UIButton *backgroundRectangle;
@property (weak, nonatomic) IBOutlet UIButton *externalControlSwitch;
@property (weak, nonatomic) IBOutlet UIButton *footSwitchSwitch;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


//- (IBAction)done:(id)sender;

@end

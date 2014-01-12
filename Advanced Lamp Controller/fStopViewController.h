//
//  fStopViewController.h
//  Advanced Lamp Controller
//
//  Created by Cemil Purut on 12/28/13.
//  Copyright (c) 2013 Modern Enlarger Lamps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class fStopViewController;

@protocol fStopViewControllerDelegate
- (void)fStopViewControllerDidFinish:(fStopViewController *)controller;
@end


@interface fStopViewController : UIViewController

@property (weak, nonatomic) id <fStopViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end


//This View Controller will be activated in a future update
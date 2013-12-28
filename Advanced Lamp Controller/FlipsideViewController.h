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

- (IBAction)done:(id)sender;

@end

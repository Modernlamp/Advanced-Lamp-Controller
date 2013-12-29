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



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

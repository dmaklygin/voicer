//
//  dmViewController.m
//  voice
//
//  Created by Dmitry Maklygin on 19.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "dmViewController.h"

@interface dmViewController ()

@end

@implementation dmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.recordButton setTitle:@"Started..." forState:UIControlStateHighlighted];
    [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDown:(id)sender {
    
}

- (IBAction)touchUp:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Record" message:@"Записано" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
@end

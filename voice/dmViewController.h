//
//  dmViewController.h
//  voice
//
//  Created by Dmitry Maklygin on 19.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)touchDown:(id)sender;
- (IBAction)touchUp:(id)sender;

@end

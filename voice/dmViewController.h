//
//  dmViewController.h
//  voice
//
//  Created by Dmitry Maklygin on 19.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "dmAPIClient.h"
#import "MZFayeClient.h"

@interface dmViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate, MZFayeClientDelegate>
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *playLocalButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UILabel *soundLabel;

@property (nonatomic, strong) MZFayeClient *fayeClient;

- (IBAction)touchDown:(id)sender;
- (IBAction)touchUp:(id)sender;
- (IBAction)playLocal:(id)sender;
- (IBAction)donwload:(id)sender;

@end

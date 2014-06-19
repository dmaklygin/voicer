//
//  dmViewController.m
//  voice
//
//  Created by Dmitry Maklygin on 19.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "dmViewController.h"

@interface dmViewController ()
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation dmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.recordButton setTitle:@"Started..." forState:UIControlStateHighlighted];
    [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    self.recorder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDown:(id)sender {
    
//    if (self.player.playing) {
//        [self.player stop];
//    }
    
    if (self.recorder.recording) {
        [self.recorder stop];
    } else {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        [self.recorder record];
        NSLog(@"recording...");
    }
}

- (IBAction)touchUp:(id)sender {
    
    if (self.recorder.recording) {
        [self.recorder stop];
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:NO error:nil];
        
        NSLog(@"stop recording...");
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Record" message:@"Записано" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)playLocal:(id)sender {
    
    if (self.player.playing) {
        [self.player stop];
    } else {
        [self.player play];
    }
}

- (AVAudioRecorder *)recorder
{
    if (_recorder) {
        return _recorder;
    }
    
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"myAudio.m4a", nil];
    NSURL *fileUrl = [NSURL fileURLWithPathComponents:pathComponents];
    
    
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithDictionary:@{}];
    [settings setObject:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [settings setObject:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    
    NSError *error;
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:fileUrl settings:settings error:&error];
    if (error) {
        NSLog(@"Recorder error, %@, %@", error, [error userInfo]);
        abort();
    }
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    
    return _recorder;
}

- (AVAudioPlayer *)player
{
    if (_player) {
        return _player;
    }
    
    NSError *error;
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:&error];
    if (error) {
        NSLog(@"error = %@, %@", error, [error userInfo]);
        abort();
    }
    
    _player.delegate = self;
    
    return _player;
}

@end

//
//  dmRecordViewController.m
//  voice
//
//  Created by Dmitry Maklygin on 19.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//
#import "dmRecordViewController.h"

@interface dmRecordViewController ()
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVPlayer *remotePlayer;
@end

@implementation dmRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.recordButton setTitle:@"Started..." forState:UIControlStateHighlighted];
    [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    
//    self.fayeClient = [[MZFayeClient alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:3002/faye"]];
    self.fayeClient = [[MZFayeClient alloc] initWithURL:[NSURL URLWithString:@"ws://voicer-server.herokuapp.com/faye"]];
    
    [self.fayeClient subscribeToChannel:@"/audio" usingBlock:^(NSDictionary *message) {
        NSString *fileName = [message valueForKeyPath:@"fileName"];
        [self playRemoteAudio:fileName];
        NSLog(@"Server %@",message);
    }];
    self.fayeClient.delegate = self;
    [self.fayeClient connect];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [self preferredStatusBarUpdateAnimation];
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
        
        [[dmAPIClient sharedClient] sendAudio:self.recorder.url withCompletionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error to send audio: %@", error);
                abort();
            }
            NSLog(@"response = %@", response);
        }];
        
        NSLog(@"stop recording...");
    }
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Record" message:@"Записано" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alertView show];
}

- (IBAction)playLocal:(id)sender {
    
    if (self.player.playing) {
        [self.player stop];
    } else {
        [self.player play];
    }
}

- (IBAction)donwload:(id)sender {
    
    [[dmAPIClient sharedClient] getAudio:^(NSURLSessionDataTask *task, id responseObject) {
//        if (error) {
//            NSLog(@"Donwload Error: %@, %@", error, [error userInfo]);
//            abort();
//        }
        if (![responseObject valueForKeyPath:@"success"]) {
            NSLog(@"ResponseObject Error:");
            abort();
        }
        
        [self playRemoteAudio:[responseObject valueForKeyPath:@"fileName"]];
        
        NSLog(@"responseObject = %@", responseObject);
        
//        self.soundLabel.text = [response suggestedFilename];
    }];
    
}

- (IBAction)onMenuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)playRemoteAudio:(NSString *)fileName
{
    NSString *audioPath = [NSMutableString stringWithFormat:@"%@/%@", [dmAPIClient sharedClient].urlString, fileName];
    
//    if (self.player.playing) {
//        [self.player stop];
//    }
    
    self.remotePlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioPath]];
    [self.remotePlayer play];
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


- (void)fayeClient:(MZFayeClient *)client didConnectToURL:(NSURL *)url
{
    NSLog(@"didConnectToURL");
}

- (void)fayeClient:(MZFayeClient *)client didDisconnectWithError:(NSError *)error
{
    NSLog(@"didDisconnectWithError: %@,%@", error, [error userInfo]);
}


- (void)fayeClient:(MZFayeClient *)client didSubscribeToChannel:(NSString *)channel
{
    NSLog(@"didSubscribeToChannel = %@", channel);
}

- (void)fayeClient:(MZFayeClient *)client didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError = %@, %@", error, [error userInfo]);
}

- (void)fayeClient:(MZFayeClient *)client didReceiveMessage:(NSDictionary *)messageData fromChannel:(NSString *)channel
{
    NSLog(@"didReceiveMessage = %@", messageData);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

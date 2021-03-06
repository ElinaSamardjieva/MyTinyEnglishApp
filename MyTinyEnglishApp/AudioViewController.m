//
//  AudioViewController.m
//  MyTinyEnglishApp
//
//  Created by Elina on 2/2/16.
//  Copyright © 2016 Elina. All rights reserved.
//

#import "AudioViewController.h"

@interface AudioViewController () {
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}
@end

@implementation AudioViewController

@synthesize recordingProgress, recordingNotificatorLabel, charmyKitty, blinkStatus, timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self animateImage];
    
    //Siri
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    //Recording Audio
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"MyAudioMemo.m4a", nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];

    recorder = [[AVAudioRecorder alloc]initWithURL:outputFileURL settings: recordSetting error:NULL];
    recorder.delegate = self;
    [recorder prepareToRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)playSpeech:(id)sender {
    [self.textToSpeak resignFirstResponder];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.textToSpeak.text];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"uk"];
    [self.synthesizer speakUtterance:utterance];
}

- (IBAction)recordAudio:(id)sender {
    recordingProgress.hidden = false;
  
    timer = [NSTimer
                      scheduledTimerWithTimeInterval:(NSTimeInterval)(0.7)
                      target:self
                      selector:@selector(blink)
                      userInfo:nil
                      repeats:TRUE];
    
    
    if(!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        [recorder record];
    }
    
}

- (IBAction)stopRecordingAudio:(id)sender {
    recordingProgress.hidden = true;
    [timer invalidate];
    recordingNotificatorLabel.backgroundColor = [UIColor whiteColor];
    
    [recorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
}

- (IBAction)playRecordingAudio:(id)sender {
    if(!recorder.recording) {
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self]; //TODO: Do I need this?
        [player play];
    }
}

-(void)blink{
    if(blinkStatus == NO){
        recordingNotificatorLabel.backgroundColor = [UIColor whiteColor];
        blinkStatus = YES;
    }else {
        recordingNotificatorLabel.backgroundColor = [UIColor redColor];
        blinkStatus = NO;
    }
}

-(void)animateImage{
    [UIView animateWithDuration:1.0
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [charmyKitty setFrame:CGRectMake(-100, 0, charmyKitty.frame.size.width, charmyKitty.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                     }];

}

@end

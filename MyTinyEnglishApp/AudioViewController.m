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

@synthesize recordingProgress, yourLabel;
BOOL blinkStatus = NO;
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    recorder.meteringEnabled = "YES";
    [recorder prepareToRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//Siri
- (IBAction)playPauseButtonPressed:(UIButton *)sender {
    [self.textToSpeak resignFirstResponder];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.textToSpeak.text];
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate; //Speak slowly
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"uk"];
    [self.synthesizer speakUtterance:utterance];
}

//Audio recorder
- (IBAction)recordAudio:(id)sender {
    recordingProgress.hidden = false;
  
    //Blinking
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
    yourLabel.backgroundColor = [UIColor whiteColor];
    
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
        yourLabel.backgroundColor = [UIColor whiteColor];
        blinkStatus = YES;
    }else {
        yourLabel.backgroundColor = [UIColor redColor];
        blinkStatus = NO;
    }
}

@end

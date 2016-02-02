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

@synthesize recordingProgress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Siri
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    //Recording Audio


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)playPauseButtonPressed:(UIButton *)sender {
    [self.textToSpeak resignFirstResponder];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.textToSpeak.text];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-au"];
    [self.synthesizer speakUtterance:utterance];
}


- (IBAction)recordAudio:(id)sender {
    recordingProgress.hidden = false;
}

- (IBAction)stopRecordingAudio:(id)sender {
    recordingProgress.hidden = true;
}
@end

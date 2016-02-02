//
//  AudioViewController.m
//  MyTinyEnglishApp
//
//  Created by Elina on 2/2/16.
//  Copyright © 2016 Elina. All rights reserved.
//

#import "AudioViewController.h"

@interface AudioViewController ()

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playPauseButtonPressed:(UIButton *)sender {
    [self.textToSpeak resignFirstResponder];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.textToSpeak.text];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-au"];
    [self.synthesizer speakUtterance:utterance];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

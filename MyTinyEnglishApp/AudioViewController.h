//
//  AudioViewController.h
//  MyTinyEnglishApp
//
//  Created by Elina on 2/2/16.
//  Copyright © 2016 Elina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *charmyKitty;
@property (weak, nonatomic) NSTimer *timer;
@property BOOL blinkStatus;

- (IBAction)playSpeech:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textToSpeak;

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@property (weak, nonatomic) IBOutlet UILabel *recordingProgress;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UILabel *recordingNotificatorLabel;

- (IBAction)recordAudio:(id)sender;
- (IBAction)stopRecordingAudio:(id)sender;
- (IBAction)playRecordingAudio:(id)sender;

@end

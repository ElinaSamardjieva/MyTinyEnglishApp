//
//  AudioViewController.h
//  MyTinyEnglishApp
//
//  Created by Elina on 2/2/16.
//  Copyright © 2016 Elina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textToSpeak;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;


//Recording audio

@property (weak, nonatomic) IBOutlet UILabel *recordingProgress;

- (IBAction)recordAudio:(id)sender;
- (IBAction)stopRecordingAudio:(id)sender;


@end

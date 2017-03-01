//
//  MWPTViewController.h
//  MW
//
//  Created by Emil Izgin on 25/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#include "MWProgress1ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MWPTViewController : UIViewController {

    NSTimer *exTimer;
}

@property (strong, nonatomic) IBOutlet UILabel *firstLabel;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *counter1Label;
@property (strong, nonatomic) IBOutlet UILabel *counter2Label;

//@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UILabel *willWhistleLabel;
@property (weak, nonatomic) NSTimer *exTimer;

@property (strong, nonatomic) ExerciseTypes *exe;
@property (strong, nonatomic) AVAudioPlayer *avap;

@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;

@end

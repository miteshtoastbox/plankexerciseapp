//
//  MusicViewController.h
//  Music
//
//  Created by Mitesh Chohan on 12/03/2014.
//  Copyright (c) 2014 Mitesh Chohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicViewController : UIViewController <MPMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;


- (IBAction)volumeChanged:(id)sender;
- (IBAction)showMediaPicker:(id)sender;
- (IBAction)previousSong:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)nextSong:(id)sender;

@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;

- (void) registerMediaPlayerNotifications;

@end

MPMusicPlayerController *musicPlayer;


//
//  MusicViewController.m
//  Music
//
//  Created by Mitesh Chohan on 12/03/2014.
//  Copyright (c) 2014 Mitesh Chohan. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController
@synthesize musicPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:NO];
    
	// Do any additional setup after loading the view, typically from a nib.
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [_volumeSlider setValue:[musicPlayer volume]];
    
    [self registerMediaPlayerNotifications];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}

- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_NowPlayingItemChanged:)
                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_VolumeChanged:)
                               name: MPMusicPlayerControllerVolumeDidChangeNotification
                             object: musicPlayer];
    
    [musicPlayer beginGeneratingPlaybackNotifications];
}

- (void) handle_NowPlayingItemChanged: (id) notification
{
    MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
    UIImage *artworkImage = [UIImage imageNamed:@"noArtworkImage.png"];
    MPMediaItemArtwork *artwork = [currentItem valueForProperty: MPMediaItemPropertyArtwork];
    
    if (artwork) {
        artworkImage = [artwork imageWithSize: CGSizeMake (200, 200)];
    }
    
    [_artworkImageView setImage:artworkImage];
    
    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
    if (titleString) {
        _titleLabel.text = [NSString stringWithFormat:@"Title: %@",titleString];
    } else {
        _titleLabel.text = @"Title: Unknown title";
    }
    
    NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
    if (artistString) {
        _artistLabel.text = [NSString stringWithFormat:@"Artist: %@",artistString];
    } else {
        _artistLabel.text = @"Artist: Unknown artist";
    }
    
    NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    if (albumString) {
        _albumLabel.text = [NSString stringWithFormat:@"Album: %@",albumString];
    } else {
        _albumLabel.text = @"Album: Unknown album";
    }
    
}

- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    /*
    if (playbackState == MPMusicPlaybackStatePaused) {
        [_playPauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
        [_playPauseButton setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
        
    } else if (playbackState == MPMusicPlaybackStateStopped) {
        
        [_playPauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        [musicPlayer stop];
        
    }
     */
    
}

- (void) handle_VolumeChanged: (id) notification
{
    [_volumeSlider setValue:[musicPlayer volume]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)volumeChanged:(id)sender {
    [musicPlayer setVolume:[_volumeSlider value]];
}

/*
- (IBAction)showMediaPicker:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
    
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    mediaPicker.prompt = @"Select songs to play";
    
    [self presentModalViewController:mediaPicker animated:YES];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    if (mediaItemCollection) {
        
        [musicPlayer setQueueWithItemCollection: mediaItemCollection];
        [musicPlayer play];
    }
    
    [self dismissModalViewControllerAnimated: YES];
}
*/

- (IBAction)showMediaPicker:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
    
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    mediaPicker.prompt = @"Select songs to play";
    
    [self presentViewController:mediaPicker animated:YES completion:nil];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    if (mediaItemCollection) {
        
        // ------ Sergey Code ------
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray *newCopy = [[NSMutableArray alloc] init];
        for (MPMediaItem *item in mediaItemCollection.items) {
            if (![newCopy containsObject:(MPMediaItem *)item])
            {
                //KUNAL KSHATRIYA: oDesk.com////////////////////////////////
                //We are saving persistantID instead of url in the preferences.
                //These preferences will be used to extract MPMediaItems required for MPMusicPlayerController
                [newCopy addObject:[item valueForProperty:MPMediaItemPropertyPersistentID]];
                ////////////////////////////////////////////////////////////
            }
        }
        
        [prefs setObject:[NSArray arrayWithArray:newCopy] forKey:SELECTED_FILES];
        [prefs synchronize];
        // ------ end ------
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissModalViewControllerAnimated: YES];
}


- (IBAction)previousSong:(id)sender {
    [musicPlayer skipToPreviousItem];
}

- (IBAction)playPause:(id)sender {
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [musicPlayer stop];
        
    } else {
        [musicPlayer play];
        
    }
}

- (IBAction)nextSong:(id)sender {
    [musicPlayer skipToNextItem];
}

@end

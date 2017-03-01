//
//  MWExcerciseViewController.m
//  MW
//
//  Created by Emil Izgin on 11/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWExcerciseViewController.h"
#import "Globals.h"
#import "MWExercisesState.h"

@interface MWExcerciseViewController ()



@end

@implementation MWExcerciseViewController {
    MWBeforeExercisesState* _beforeState;
    MWFirstExerciseState* _firstExState;
    MWSecondExerciseState* _secondExState;
    MWThirdExerciseState* _thirdExState;
    MWFourthExerciseState* _fourthExState;
    MWFifthExerciseState* _fifthExState;
    MWSixthExerciseState* _sixthExState;
    MWFirstRestState* _firstRestState;
    MWSecondRestState* _secondRestState;
    MWThirdRestState* _thirdRestState;
    MWFourthRestState* _fourthRestState;
    MWFifthRestState* _fifthRestState;
    MWFinishedState* _finishedState;
    
    NSArray *states;
    
    NSTimeInterval exTimeInterval;
    NSTimeInterval restTimeInterval;
    NSTimeInterval stopExTime;
    NSTimeInterval stopRestTime;

    int indexInStates;
    bool gestureWasRecognized;
}

@synthesize delegate;
@synthesize musicPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipe];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [self.view addGestureRecognizer:tap];

    
    indexInStates = 2; // starting with 2; 0 and 1 read specifically

    NSString* exHoursStr = [[Globals getInstance] exHoursSet];
    NSString* exMinutesStr = [[Globals getInstance] exMinutesSet];
    NSString* exSecondsStr = [[Globals getInstance] exSecondsSet];
    NSString* restHoursStr = [[Globals getInstance] restHoursSet];
    NSString* restMinutesStr = [[Globals getInstance] restMinutesSet];
    NSString* restSecondsStr = [[Globals getInstance] restSecondsSet];
    exTimeInterval = [self getSecondsFromHoursString:exHoursStr andMinString:exMinutesStr andSecString:exSecondsStr];
    restTimeInterval = [self getSecondsFromHoursString:restHoursStr andMinString:restMinutesStr andSecString:restSecondsStr];

    // sequence and order of the states which needed
    _beforeState = [[MWBeforeExercisesState alloc] init];
    _firstExState = [[MWFirstExerciseState alloc] init];
    _firstRestState = [[MWFirstRestState alloc] init];
    _secondExState = [[MWSecondExerciseState alloc] init];
    _secondRestState = [[MWSecondRestState alloc] init];
    _thirdExState = [[MWThirdExerciseState alloc] init];
    _thirdRestState = [[MWThirdRestState alloc] init];
    _fourthExState = [[MWFourthExerciseState alloc] init];
    _fourthRestState = [[MWFourthRestState alloc] init];
    _fifthExState = [[MWFifthExerciseState alloc] init];
    _fifthRestState = [[MWFifthRestState alloc] init];
    //_sixthExState = [[MWSixthExerciseState alloc] init];
    _finishedState = [[MWFinishedState alloc] init];
    
    states = [[NSArray alloc] initWithObjects:_beforeState, _firstExState, _firstRestState, _secondExState, _secondRestState, _thirdExState, _thirdRestState, _fourthExState, _fourthRestState, _fifthExState, _fifthRestState, _sixthExState, _finishedState, nil];
    
    for (id s in states) {
        [s setDelegate:self];
    }
    [[states objectAtIndex:0] instate:self];  // specifically set the first state - beginning
}

-(void)gestureRecognized:(UIGestureRecognizer*)gesture {
    if (gestureWasRecognized == NO) {
        gestureWasRecognized = YES;
        [self startTimer];
    }
}

-(void)startTimer {
    [[states objectAtIndex:1] instate:self];   // specifically set the second state - actual exercise
}

-(NSTimeInterval)exTimeSet {
    return exTimeInterval;
}

-(NSTimeInterval)restTimeSet {
    return restTimeInterval;
}

-(void)showCounterValue:(double)counterValue {
    NSString *str = [NSString stringWithFormat:@"%f", counterValue];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    int mss = [[[arr objectAtIndex:1] substringToIndex:2] intValue];
//    NSLog(@"%f", counterValue);
    int intCounterValue = (int)counterValue;
    int hours = intCounterValue / 3600;
    int remainder = intCounterValue % 3600;
    int minutes = remainder / 60;
    int seconds = remainder % 60;
    NSString* value = [NSString stringWithFormat:@"%02d:%02d:%02d:%02d",hours, minutes, seconds, mss];
    [self.counterLabel setText:value];
}

-(void)startExTimer {
//    @synchronized(self) {
        self.exTimer =       [
                             NSTimer
                             scheduledTimerWithTimeInterval:0.01
                             target:self
                             selector:@selector(initiateEx:)
                             userInfo:nil
                             repeats:YES
                             ];
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
    musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    
    // ------ Sergey Code ------
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    
    NSArray * array = [prefs objectForKey:SELECTED_FILES];
    // ------ end ------
    
    //KUNAL KSHATRIYA: oDesk.com////////////////////////////////
    //We are extracting the list of songs in the form of MPMediaItems in the following loop
    if(array != nil && [array count] != 0)
    {
        NSMutableArray *arraySongs = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (int i = 0; i < [array count]; i++) {
            MPMediaQuery *songQuery = [MPMediaQuery songsQuery];
            
            [songQuery addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:[array objectAtIndex:i] forProperty:MPMediaItemPropertyPersistentID]];
            
            NSArray *songs = [songQuery items];
            [arraySongs addObjectsFromArray: songs];
        }
        
        MPMediaItemCollection *currentQueue = [[MPMediaItemCollection alloc] initWithItems:arraySongs];
        [musicPlayer setQueueWithItemCollection:currentQueue];
    }
    //KUNAL/////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    
    
    //[_volumeSlider setValue:[musicPlayer volume]];
    
    [self registerMediaPlayerNotifications];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    // play on screen touch
    [musicPlayer play];

}

- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [musicPlayer beginGeneratingPlaybackNotifications];
}

-(void)startRestTimer {
//    @synchronized(self) {
    self.restTimer =     [
                          NSTimer scheduledTimerWithTimeInterval:0.01
                          target:self
                          selector:@selector(initiateRest:)
                          userInfo:nil
                          repeats:YES
                          ];
//    }
}


-(void)initiateEx:(NSTimer*)timer {
    NSTimeInterval intervalSet = [self exTimeSet];
    NSTimeInterval currentT = [self currentTime];
    if (stopExTime == 0) {
        stopExTime = currentT + intervalSet;
    }
    if (currentT < stopExTime) {
        [self showCounterValue: (currentT - stopExTime + intervalSet)];
    } else {
        [self showCounterValue: intervalSet]; // cleaning potential fractions
//        NSLog(@"%@", @"Ex timer to be invalidated.");
        [timer invalidate];
        timer = nil;
//        NSLog(@"%@", @"Ex timer nilled.");
        stopExTime = 0;
        [self initiateNext];
    }
}

-(void)initiateRest:(NSTimer*)timer {
    NSTimeInterval intervalSet = [self restTimeSet];
    NSTimeInterval currentT = [self currentTime];
//    NSLog(@"%@", @"in initiateRest()");

    if (stopRestTime == 0) {
        stopRestTime = currentT + intervalSet;
    }
    if (currentT < stopRestTime) {
        [self showCounterValue: (currentT - stopRestTime + intervalSet)];
    } else {
        [self showCounterValue: intervalSet]; // cleaning potential fractions
        [timer invalidate];
        timer = nil;
        stopRestTime = 0;
        [self initiateNext];
    }
}

// proceed to the next state
-(void)initiateNext {
    if ([states count] > indexInStates) {
        [states[indexInStates] instate:self];
        indexInStates++;
    }
    else{
        [musicPlayer stop];
        
        //KUNAL KSHATRIYA: oDesk.com////////////////////////////////
        MPMediaPropertyPredicate *predicate =
        [MPMediaPropertyPredicate predicateWithValue: @"#$Non_Existant_Song_Name#$%"
                                         forProperty: MPMediaItemPropertyTitle];
        MPMediaQuery *query = [[MPMediaQuery alloc] init];
        [query addFilterPredicate: predicate];
        [musicPlayer setQueueWithQuery:query];
        musicPlayer.nowPlayingItem = nil;
        [musicPlayer stop];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:nil forKey:SELECTED_FILES];
        [prefs synchronize];
        //KUNAL/////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)viewDidDisappear:(BOOL)animated {
    [self.exTimer invalidate];
    [self.restTimer invalidate];
    self.exTimer = nil;
    self.restTimer = nil;
}


- (NSTimeInterval)getSecondsFromHoursString:(NSString*)hoursString andMinString:(NSString*)minString andSecString:(NSString*)secString {

    NSTimeInterval ti = 360*[self getNumeric:hoursString] + 60*[self getNumeric:minString] + [self getNumeric:secString];
    return ti;
}

-(NSInteger)getNumeric:(NSString*)alphanumeric {
    NSArray *components=[alphanumeric componentsSeparatedByString:@" "];
    NSString *str;
    NSInteger result;
    if ([components count]>=2) {
        str = [components objectAtIndex:0];
        result = [str intValue];
        return result;
    } else {
        return 0;
    }
}
    
-(NSTimeInterval)currentTime {
    return [[NSDate date] timeIntervalSince1970];
}

    
@end

//
//  MWPTViewController.m
//  MW
//
//  Created by Emil Izgin on 25/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWPTViewController.h"

@interface MWPTViewController () {

    int stage;   // 0 - target time not set, timer not started;  1 - target time not set, timer started;  2 - target time set, timer not started;  3 - target time set, timer started;
}

@end

@implementation MWPTViewController {

    NSTimeInterval exTimeInterval;
    NSTimeInterval startedExStage0Time;
    NSTimeInterval targetTime;
    NSTimeInterval stopExTime;

    bool gestureWasRecognized;
    bool firstTime;      // exercise done first time or not
}

@synthesize avap;
@synthesize musicPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [self.view addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [self.view addGestureRecognizer:swipe];
    
    
    
    UILabel *lab1 = (UILabel *)[self.view viewWithTag:1];
    UILabel *lab2 = (UILabel *)[self.view viewWithTag:2];
    UILabel *lab3 = (UILabel *)[self.view viewWithTag:3];
    UILabel *lab6 = (UILabel *)[self.view viewWithTag:6];

    if (_exe.exerciseTargetTime > 0) {
        stage = 2;
        [lab2 setText: [self convertTo00000000: _exe.exerciseTargetTime]];
        firstTime = NO;
    } else {
        [lab1 setHidden:YES];
        [lab3 setHidden:YES];
        
        //[lab6 setHidden:YES];
        lab6.text = @"Touch the screen to start. Touch screen again when finished so I can capture your fitness level.";
        firstTime = YES;
    }
    UIImageView *im = (UIImageView *)[self.view viewWithTag:4];
    UIImage *image = [UIImage imageNamed: _exe.exerciseImagePath];
    [im setImage:image];

    //UILabel *lab = (UILabel *)[self.view viewWithTag:5];
    //[lab setText: [_exe.exerciseInstruction stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];

}

-(void)gestureRecognized:(UIGestureRecognizer*)gesture {
    
    switch (stage) {
        case 0:
            [self playSound];
            [self startExStage0Timer];
            break;
        case 1: {
            [self.exTimer invalidate];
            self.exTimer = nil;
            [self playSound];
            DataAccess *db = [[DataAccess alloc] init];
            bool targetTimeSaved = [db saveTargetTime:targetTime onPrimaryKey:_exe.pKExerciseTypeID];
            if (targetTimeSaved) {
                bool exerciseTimeSaved = [db recordExTime:targetTime forExerciseType:_exe at:[NSDate dateWithTimeIntervalSince1970:[self currentTime]]];
            }
            _exe.exerciseTargetTime = targetTime;     // will be sent further
            stage = 2;
            [self performSegueWithIdentifier: @"ToProgress1Segue" sender: self];
            }
            break;
        case 2:
            [self playSound];
            [self startExStage0Timer];
            break;
        default:
            break;
    }
}


-(void)startTimer {

}

-(NSTimeInterval)exTimeSet {
    return exTimeInterval;
}

-(void)showCounterValue:(double)counterValue {
    NSString *value;
    value = [self convertTo00000000:counterValue];
    [self.counter1Label setText:value];
}

- (NSString *)convertTo00000000:(double)counterValue {
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
    return value;
}

// Show the target time label value
-(void)showCounter1Value:(double)counterValue {
    NSString *value;
    value = [self convertTo00000000:counterValue];
    [self.counter1Label setText:value];
    targetTime = counterValue; // target time would be set correctly finally only after touch gesture and timer invalidation
}

-(void)showCounter2Value:(double)counterValue {
    NSString *value;
    value = [self convertTo00000000:counterValue];
    [self.counter2Label setText:value];
    targetTime = counterValue; // target time would be set correctly finally only after touch gesture and timer invalidation
}

-(void)startExStage0Timer {
    self.exTimer =       [
                          NSTimer
                          scheduledTimerWithTimeInterval:0.01
                          target:self
                          selector:@selector(initiateExStage0:)
                          userInfo:nil
                          repeats:YES
                          ];
    
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

// Task initiated by the timer
-(void)initiateExStage0:(NSTimer*)timer {
    
    NSTimeInterval currentT = [self currentTime];
    NSTimeInterval intervalSet = _exe.exerciseTargetTime;
    
    switch (stage) {
        case 0:
            stage = 1;
            startedExStage0Time = currentT;
            [self showCounter1Value: (currentT - startedExStage0Time)];
            break;
        case 1:
            [self showCounter1Value: (currentT - startedExStage0Time)];
            break;
        case 2:
            stage = 3;
            if (stopExTime == 0) {
                stopExTime = currentT + intervalSet;
            }
            break;
        default:
            if (currentT < stopExTime) {
                [self showCounter2Value: (currentT - stopExTime + intervalSet)];
            } else {
                [self showCounter2Value: intervalSet]; // cleaning potential fractions
                [timer invalidate];
                timer = nil;
                //        NSLog(@"%@", @"Ex timer nilled.");
                stopExTime = 0;
                [self playSound];
                DataAccess *db = [[DataAccess alloc] init];
                bool exTimeSaved = [db recordExTime:intervalSet forExerciseType:_exe at:[NSDate dateWithTimeIntervalSince1970:currentT]];
                if (!exTimeSaved) {
                }
                [self performSegueWithIdentifier: @"ToProgress1Segue" sender: self];
            }
            break;
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [self.exTimer invalidate];
    self.exTimer = nil;
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

-(void) playSound {
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"sound3" ofType:@"mp3"];
    NSURL* audioURL = [NSURL fileURLWithPath:audioPath];
    NSError* aError = nil;
    avap = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&aError];  // avap must be declared in .h as a property for ARC to handle it properly
    [avap play];

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
    
    
    MWProgress1ViewController *pController = [segue destinationViewController];
    pController.exe = _exe;
    pController.firstTime = firstTime;

}

@end

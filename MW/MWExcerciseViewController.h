//
//  MWExcerciseViewController.h
//  MW
//
//  Created by Emil Izgin on 11/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MWExercisesState.h"
#import "MWBeforeExercisesState.h"
#import "MWFirstExerciseState.h"
#import "MWSecondExerciseState.h"
#import "MWThirdExerciseState.h"
#import "MWFourthExerciseState.h"
#import "MWFifthExerciseState.h"
#import "MWSixthExerciseState.h"
#import "MWFirstRestState.h"
#import "MWSecondRestState.h"
#import "MWThirdRestState.h"
#import "MWFourthRestState.h"
#import "MWFifthRestState.h"
#import "MWFinishedState.h"

#import "MWExceDelegate.h"

#import <MediaPlayer/MediaPlayer.h>


@class MWExcerciseViewController;
@class MWBeforeExercisesState;
@class MWFirstExerciseState;

@interface MWExcerciseViewController : UIViewController {
    
    NSTimer *exTimer;
    NSTimer *restTimer;
}

@property (nonatomic, weak) id <MWExceDelegate> delegate; //define MyClassDelegate as delegate

@property (strong, nonatomic) IBOutlet UIImageView *largeImageView;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutlet UIImageView *smallImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstLowerLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLowerLabel;
@property (weak, nonatomic) NSTimer *exTimer;
@property (weak, nonatomic) NSTimer *restTimer;

-(void)initiateNext;
-(void)gestureRecognized:(UIGestureRecognizer*)gesture;

-(NSInteger)getNumeric:(NSString*)alphanumeric;
-(void)showCounterValue:(double)counterValue;
-(NSTimeInterval)exTimeSet;
-(NSTimeInterval)restTimeSet;
-(NSTimeInterval)currentTime;
-(void)startExTimer;
-(void)startRestTimer;

@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;

@end

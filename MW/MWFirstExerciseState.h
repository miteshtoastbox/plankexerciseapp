//
//  MWFirstExerciseState.h
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWExercisesState.h"
#import "MWExcerciseViewController.h"
#import "MWExceDelegate.h"

@interface MWFirstExerciseState : NSObject <MWExercisesState, MWExceDelegate> {
    id <MWExceDelegate> _delegate;
}
@property (strong, nonatomic) AVAudioPlayer *avap;


-(id)delegate;
-(void)setDelegate:(id)delegate;

@end

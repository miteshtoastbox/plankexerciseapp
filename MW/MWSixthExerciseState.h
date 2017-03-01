//
//  MWSixthExerciseState.h
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWExercisesState.h"
#import "MWExcerciseViewController.h"
#import "MWExceDelegate.h"

@interface MWSixthExerciseState : NSObject <MWExercisesState, MWExceDelegate> {
    id <MWExceDelegate> _delegate;
}
@property (strong, nonatomic) AVAudioPlayer *avap;

-(void)setDelegate:(id)delegate;

@end

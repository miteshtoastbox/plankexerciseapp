//
//  MWBeforeExercisesState.h
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWExercisesState.h"
#import "MWExcerciseViewController.h"
#import "MWExceDelegate.h"

@interface MWBeforeExercisesState : NSObject <MWExercisesState, MWExceDelegate> {
    id <MWExceDelegate> _delegate;
}

-(void)setDelegate:(id)delegate;

@end

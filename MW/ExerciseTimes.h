//
//  ExerciseTimes.h
//  MW
//
//  Created by Emil Izgin on 23/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExerciseTimes : NSObject

@property (nonatomic,assign) double pKExerciseTimeID;
@property (nonatomic,assign) double fKExerciseTypeID;
@property (nonatomic,strong) NSDate *exerciseDate;
@property (nonatomic,assign) double exerciseTime;

@end

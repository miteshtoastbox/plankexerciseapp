//
//  ExerciseTypes.h
//  MW
//
//  Created by Emil Izgin on 23/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExerciseTypes : NSObject

@property (nonatomic,assign) int pKExerciseTypeID;
@property (nonatomic,strong) NSString *exerciseName;
@property (nonatomic,strong) NSString *exerciseMode;
@property (nonatomic,strong) NSString *exerciseImagePath;
@property (nonatomic,strong) NSString *exerciseInstruction;
@property (nonatomic,assign) double exerciseTargetTime;

@end

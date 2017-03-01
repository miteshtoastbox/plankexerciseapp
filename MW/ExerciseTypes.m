
//
//  ExerciseTypes.m
//  MW
//
//  Created by Emil Izgin on 23/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "ExerciseTypes.h"

@implementation ExerciseTypes

@synthesize pKExerciseTypeID;
@synthesize exerciseName;
@synthesize exerciseMode;
@synthesize exerciseImagePath;
@synthesize exerciseInstruction;
@synthesize exerciseTargetTime;

//-(int) getPKExerciseTypeID {
//    return pKExerciseTypeID;
//}
-(NSString *) getExerciseName {
    return exerciseName;
}
-(NSString *) getExerciseMode {
    return exerciseMode;
}
-(NSString *) getExerciseImagePath {
    return exerciseImagePath;
}
-(NSString *) getExerciseInstruction {
    return exerciseInstruction;
}
-(double) getExerciseTargetTime {
    return exerciseTargetTime;
}
@end

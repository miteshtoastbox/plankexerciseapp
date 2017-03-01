//
//  ExerciseTimes.m
//  MW
//
//  Created by Emil Izgin on 23/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "ExerciseTimes.h"

@implementation ExerciseTimes

@synthesize pKExerciseTimeID;
@synthesize fKExerciseTypeID;
@synthesize exerciseDate;
@synthesize exerciseTime;


-(double) getPKExerciseTimeID {
    return pKExerciseTimeID;
}
-(int) getFKExerciseTypeID {
    return fKExerciseTypeID;
}
-(NSDate *) getExerciseDate {
    return exerciseDate;
}
-(double) getExerciseTime {
    return exerciseTime;
}

@end

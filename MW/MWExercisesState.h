//
//  MWExercisesState.h
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@protocol MWExercisesState <NSObject>
    
    -(void)drawLargeImage;
    -(void)drawFirstLabel;
    -(void)drawSecondLabel;
    -(void)drawSmallImage;
    -(void)playSound;


@end

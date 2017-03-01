//
//  MWFirstExerciseState.m
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWFirstExerciseState.h"

@implementation MWFirstExerciseState {
    
    UIViewController* controllerSent;

}
@synthesize avap;

-(id)delegate {
    return self.delegate;
}

- (void) setDelegate:(id)delegate {
    _delegate = delegate;
}

// actions 
-(void)instate:(UIViewController*) sender {
    
    controllerSent = sender;
    [self drawLargeImage];
    [self drawFirstLabel];
    [self drawSecondLabel];
    [self drawSmallImage];
    [self playSound];

//    NSTimeInterval intervalSet = [_delegate exTimeSet];
//    NSTimeInterval stopTime = [self currentTime] + intervalSet;
//    while ([self currentTime] < stopTime) {
//        [NSThread sleepForTimeInterval:2.0];

        [_delegate startExTimer];
//        NSLog(@"%f", stopTime - [self currentTime]);
//        [NSThread sleepForTimeInterval:5.0];

//    }
//    [_delegate showCounterValue: exTimeSet];
}

-(void)drawLargeImage {
    UIImageView *im = (UIImageView *)[controllerSent.view viewWithTag:1];
    UIImage *image = [UIImage imageNamed: @"frontplank.gif"];
    [im setImage:image];
}

-(void)drawFirstLabel {
    UILabel *lab = (UILabel *)[controllerSent.view viewWithTag:3];
    [lab setText:@""];
}

-(void)drawSecondLabel {
    UILabel *lab = (UILabel *)[controllerSent.view viewWithTag:4];
    [lab setText:@""];
}

-(void)drawSmallImage {
    
}

-(void)playSound {
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"sound3" ofType:@"mp3"];
    NSURL* audioURL = [NSURL fileURLWithPath:audioPath];
    NSError* aError = nil;
    avap = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&aError];
    [avap play];
}

-(NSTimeInterval)currentTime {
    return [[NSDate date] timeIntervalSince1970];
}

@end

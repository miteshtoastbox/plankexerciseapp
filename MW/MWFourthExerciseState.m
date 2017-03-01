//
//  MWFourthExerciseState.m
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWFourthExerciseState.h"

@implementation MWFourthExerciseState {
    
    UIViewController* controllerSent;

}

- (void) setDelegate:(id)delegate {
    _delegate = delegate;
}

-(void)instate:(UIViewController*) sender {
    
    controllerSent = sender;
    [self drawLargeImage];
    [self drawFirstLabel];
    [self drawSecondLabel];
    [self drawSmallImage];
    [self playSound];
    [_delegate startExTimer];
}

-(void)drawLargeImage {
    UIImageView *im = (UIImageView *)[controllerSent.view viewWithTag:1];
    UIImage *image = [UIImage imageNamed: @"FrontPlankLegLift.jpg"];
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
    UIImageView *im = (UIImageView *)[controllerSent.view viewWithTag:5];
    UIImage *image = [UIImage imageNamed: @""];
    [im setImage:image];
}

-(void)playSound {
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"sound3" ofType:@"mp3"];
    NSURL* audioURL = [NSURL fileURLWithPath:audioPath];
    NSError* aError = nil;
    _avap = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&aError];
    [_avap play];
}

@end

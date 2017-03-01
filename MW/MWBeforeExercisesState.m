//
//  MWBeforeExercisesState.m
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWBeforeExercisesState.h"

@implementation MWBeforeExercisesState {
    
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
}

-(void)drawLargeImage {
    UIImageView *im = (UIImageView *)[controllerSent.view viewWithTag:1];
    UIImage *image = [UIImage imageNamed: @""];
    //im.frame = CGRectMake(100, 100, 100,80);
    //im.contentMode = UIViewContentModeScaleAspectFill;
    [im setImage:image];
}

-(void)drawFirstLabel {
    UILabel *l = (UILabel *)[controllerSent.view viewWithTag:3];
    [l setText:@"Start With Front Plank"];
}

-(void)drawSecondLabel {
}

-(void)drawSmallImage {
}

-(void)playSound {
    
}

@end

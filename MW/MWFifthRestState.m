//
//  MWFifthRestState.m
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWFifthRestState.h"

@implementation MWFifthRestState {
    
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
    [_delegate startRestTimer];

}

-(void)drawLargeImage {
    UIImageView *im = (UIImageView *)[controllerSent.view viewWithTag:1];
    UIImage *image = [UIImage imageNamed: @""];
    
    //im.frame = CGRectMake(80, 70, 96,250);
    im.contentMode = UIViewContentModeScaleAspectFill;
    [im setImage:image];
}

-(void)drawFirstLabel {
    
    UILabel *labt = (UILabel *)[controllerSent.view viewWithTag:2];
    //labt.frame = CGRectMake(100, 400, 120,100);

    UILabel *lab = (UILabel *)[controllerSent.view viewWithTag:3];
    //lab.frame = CGRectMake(190, 350, 200,100);
    [lab setText:@"-- Rest & Finish --"];
}

-(void)drawSecondLabel {
    
}

-(void)drawSmallImage {
    
}

-(void)playSound {
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"sound3" ofType:@"mp3"];
    NSURL* audioURL = [NSURL fileURLWithPath:audioPath];
    NSError* aError = nil;
    _avap = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&aError];
    [_avap play];
}

@end

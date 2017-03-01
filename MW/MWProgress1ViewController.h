//
//  MWProgress1ViewController.h
//  MW
//
//  Created by Emil Izgin on 29/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseTypes.h"
#import "MWPTAdjustViewController.h"
#import "MWPTFirstTime.h"

@interface MWProgress1ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) IBOutlet UILabel *percentLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) ExerciseTypes *exe;
@property (assign, nonatomic) bool firstTime;

- (void)startCount;

@end

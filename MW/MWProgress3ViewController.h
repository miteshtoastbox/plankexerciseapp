//
//  MWProgress3ViewController.h
//  MW
//
//  Created by Emil Izgin on 08/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseTypes.h"
#import "MWPersonalBestWithChartsViewController.h"

@interface MWProgress3ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) IBOutlet UILabel *percentLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) ExerciseTypes *exe;
@property (assign, nonatomic) double bestTime;
@property (assign, nonatomic) double xTime;

- (void)startCount;

@end

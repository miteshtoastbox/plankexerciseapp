//
//  MWPTAdjustViewController.h
//  MW
//
//  Created by Emil Izgin on 26/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseTypes.h"
#import "MWHomeViewController.h"
#import "DataAccess.h"
#include <math.h>

@interface MWPTAdjustViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *justLikeALabel;
@property (strong, nonatomic) IBOutlet UIButton *easyButton;
@property (strong, nonatomic) IBOutlet UIButton *struggledButton;
@property (strong, nonatomic) IBOutlet UIButton *justRightButton;

@property (strong, nonatomic) ExerciseTypes *exe;
@property (assign, nonatomic) bool firstTime;


- (IBAction)proAction:(id)sender;
- (IBAction)veryEasyAction:(id)sender;
- (IBAction)easyAction:(id)sender;
- (IBAction)canDoBetterAction:(id)sender;
- (IBAction)justRightAction:(id)sender;
- (IBAction)struggledAction:(id)sender;




@end

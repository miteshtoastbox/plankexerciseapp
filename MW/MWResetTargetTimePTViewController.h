//
//  MWResetTargetTimePTViewController.h
//  MW
//
//  Created by Emil Izgin on 07/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"

@interface MWResetTargetTimePTViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *listData;
@property (strong, nonatomic) ExerciseTypes *exe;
@property (strong, nonatomic) IBOutlet UIButton *cellImageButton;

-(void) populateCells;
- (IBAction)exerciseImageButtonPressed:(id)sender;

@end

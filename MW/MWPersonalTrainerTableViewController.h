//
//  MWPersonalTrainerTableViewController.h
//  MW
//
//  Created by Emil Izgin on 23/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import <Parse/Parse.h>

#import "MWPTInstrViewController.h"

#import "MWTimeHistoryTableViewController.h"
#import "MWResetTargetTimePTViewController.h"
#import "InApp.h"
#import "MBProgressHUD.h"

@interface MWPersonalTrainerTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *listData;
@property (strong, nonatomic) ExerciseTypes *exeDTO;
@property (strong, nonatomic) IBOutlet UIButton *cellImageButton;

-(void) populateCells;
- (IBAction)cellButtonPressed:(id)sender;
-(void) launchAlert;

@end

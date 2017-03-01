//
//  MWPersonalBestViewController.h
//  MW
//
//  Created by Emil Izgin on 07/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import "MWPBInstrViewController.h"
#import "MWTimeHistoryTableViewController.h"
#import "MWResetTargetTimePTViewController.h"

@interface MWPersonalBestViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *listData;
@property (strong, nonatomic) ExerciseTypes *exeDTO;
@property (strong, nonatomic) IBOutlet UIButton *cellImageButton;

-(void) populateCells;
- (IBAction)cellButtonPressed:(id)sender;

@end

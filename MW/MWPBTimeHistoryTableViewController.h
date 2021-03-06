//
//  MWPBTimeHistoryTableViewController.h
//  MW
//
//  Created by Emil Izgin on 09/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@interface MWPBTimeHistoryTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *listData;
@property (strong, nonatomic) ExerciseTypes *exeDTO;
@property (strong, nonatomic) IBOutlet UIButton *cellImageButton;

-(void) populateCells;
- (IBAction)cellButtonPressed:(id)sender;
- (IBAction)selectExercise:(id)sender;

@end

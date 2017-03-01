//
//  MWPersonalBestWithChartsViewController.h
//  MW
//
//  Created by Emil Izgin on 08/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@interface MWPersonalBestWithChartsViewController : UIViewController

@property (strong, nonatomic) ExerciseTypes *exe;
@property (assign, nonatomic) double bestTime;
@property (assign, nonatomic) double xTime;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *homeButton;

- (IBAction)homeButtonPressed:(id)sender;

@end

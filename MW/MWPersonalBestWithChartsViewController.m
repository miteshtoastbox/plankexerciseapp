//
//  MWPersonalBestWithChartsViewController.m
//  MW
//
//  Created by Emil Izgin on 08/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWPersonalBestWithChartsViewController.h"

@interface MWPersonalBestWithChartsViewController ()

@end

@implementation MWPersonalBestWithChartsViewController {
    
    DataAccess *db;
    NSMutableArray *chartXLabels;
    NSMutableArray *chartDataArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    chartXLabels = [[NSMutableArray alloc] init];
    chartDataArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    db = [[DataAccess alloc] init];
    UILabel *lab1 = (UILabel *)[self.view viewWithTag:2];
    UILabel *labTime = (UILabel *)[self.view viewWithTag:3];
    UILabel *labWas = (UILabel *)[self.view viewWithTag:4];
    UILabel *labTimeRed = (UILabel *)[self.view viewWithTag:5];
    UILabel *labBest = (UILabel *)[self.view viewWithTag:6];
    UILabel *labTimeGreen = (UILabel *)[self.view viewWithTag:7];
    
    UIImageView *im = (UIImageView *)[self.view viewWithTag:1];
    UIImage *image = [UIImage imageNamed: _exe.exerciseImagePath];
    [im setImage:image];
    
    if (_bestTime >= _xTime) {
        [lab1 setHidden:YES];
        [labTime setHidden:YES];
        [labWas setHidden:NO];
        [labTimeRed setHidden:NO];
        [labBest setHidden:NO];
        [labTimeGreen setHidden:NO];
        [labTimeRed setText: [self convertTo000000: _xTime]];
        [labTimeGreen setText: [self convertTo000000: _bestTime]];
    } else {
        bool success = [db saveBestTime:_xTime onPrimaryKey:_exe.pKExerciseTypeID];
//        if (success) {
//            success = [db recordExTime:_xTime forExerciseType:_exe at:[NSDate dateWithTimeIntervalSince1970:[self currentTime]]];
//        }
        [lab1 setHidden:NO];
        [labTime setHidden:NO];
        [labWas setHidden:YES];
        [labTimeRed setHidden:YES];
        [labBest setHidden:YES];
        [labTimeGreen setHidden:YES];
        [labTime setText: [self convertTo000000: _xTime]];
    }
    bool someDataAtLeast2 = [self fillChartDataArrays: _exe];
    if (someDataAtLeast2) {
        [self drawChart];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [chartXLabels removeAllObjects];
    [chartDataArray removeAllObjects];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)convertTo000000:(double)value {

    int intCounterValue = (int)value;
    int hours = intCounterValue / 3600;
    int remainder = intCounterValue % 3600;
    int minutes = remainder / 60;
    int seconds = remainder % 60;
    NSString* valueS = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    return valueS;
}


-(bool)fillChartDataArrays: (ExerciseTypes*)xType {
    
    NSMutableArray* chartData = [db getChartData: xType.pKExerciseTypeID];
    if ([chartData count] > 1) {
        double exTime = 0.0;
        int xTime = 0;
        NSDate *xDate;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSString* ukDateString;
        [dateFormat setDateFormat:@"dd/MM"];
        int limit = ([chartData count] < 7) ? [chartData count] : 7;
        limit = [chartData count];
        int firstValueToDraw = ([chartData count] < 7) ? 0 : [chartData count] - 7;
        for (int i=firstValueToDraw; i<limit; i++) {
            exTime = [[chartData objectAtIndex:i] exerciseTime];
            xTime = (int)exTime;
            xDate = [[chartData objectAtIndex:i] exerciseDate];
            ukDateString = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:xDate]];
            [chartXLabels addObject: ukDateString];
            [chartDataArray addObject: [NSString stringWithFormat:@"%d", xTime]];
        }
        return YES;
    } else {
        return NO;
    }
}


-(void)drawChart {
    
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
    lineChartLabel.text = @"Line Chart";
    lineChartLabel.textColor = PNFreshGreen;
    lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    lineChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 225.0, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:chartXLabels];
    
    // Line Chart
    NSArray * data01Array = chartDataArray;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    lineChart.delegate = self;
    
    //    [destViewController.view addSubview:lineChartLabel]; // Uncomment for the green label above the chart
    [self.view addSubview:lineChart];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.navigationController setNavigationBarHidden:NO];
}


- (IBAction)homeButtonPressed:(id)sender {
    [self performSegueWithIdentifier: @"BackToHomeFromPBWithChartsSegue" sender: self];
}

-(NSTimeInterval)currentTime {
    return [[NSDate date] timeIntervalSince1970];
}


@end

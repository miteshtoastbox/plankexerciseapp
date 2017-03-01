//
//  MWTimeHistoryTableViewController.m
//  MW
//
//  Created by Emil Izgin on 31/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWTimeHistoryTableViewController.h"

@interface MWTimeHistoryTableViewController ()

@end

@implementation MWTimeHistoryTableViewController {
    
    DataAccess *db;
    NSMutableArray *chartXLabels;
    NSMutableArray *chartDataArray;
    UIViewController * destViewController;
    double bestTime;
}

@synthesize listData;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    chartXLabels = [[NSMutableArray alloc] init];
    chartDataArray = [[NSMutableArray alloc] init];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0625 green:0.17578125 blue:0.18359375 alpha:1.0];
    [self populateCells];
}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidUnload
{
    self.listData = nil;
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [chartXLabels removeAllObjects];
    [chartDataArray removeAllObjects];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Specific

-(void) populateCells {
    self.listData = [[NSMutableArray alloc] init];
    db = [[DataAccess alloc] init];
    self.listData = [db getExTypesPT];
}

- (IBAction)cellButtonPressed:(id)sender {
    
}

- (IBAction)selectExercise:(id)sender {
    
    UIButton *butt = (UIButton*)sender;
    _exeDTO = [self.listData objectAtIndex:butt.tag];
    bool someDataAtLeast2 = [self fillChartDataArrays: _exeDTO];
    bestTime = [db getBestTimePT: _exeDTO.pKExerciseTypeID];

    UILabel *lab = (UILabel *)[destViewController.view viewWithTag:1];
    [lab setText: [self convertTo000000: bestTime]];

    UILabel *bestLab = (UILabel *)[destViewController.view viewWithTag:3];
    if (bestTime == 0) {
        [bestLab setText: @"You have no saved times."];
        [lab setHidden:YES];
    }

    UIImageView *im = (UIImageView *)[destViewController.view viewWithTag:2];
    UIImage *image = [UIImage imageNamed: _exeDTO.exerciseImagePath];
    [im setImage:image];

    if (someDataAtLeast2) {
        [self drawChart];
    }
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



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"Image";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    NSUInteger row = [indexPath row];
    ExerciseTypes *exType = [self.listData objectAtIndex:row];
    if ([identifier isEqualToString:@"Image"]) {
        UIImage *image = [UIImage imageNamed: exType.exerciseImagePath];
        UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
        [btn setImage:image forState:UIControlStateNormal];
        btn.tag = indexPath.row;
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:(CGFloat) 19];
    [cell.textLabel sizeToFit];
    return cell;
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    int row = [indexPath row];
//    _exeDTO = [self.listData objectAtIndex:row];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self performSegueWithIdentifier: @"ToPTChartSegue" sender: self];
//}


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
    [destViewController.view addSubview:lineChart];
    
    destViewController.title = @"History";
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    destViewController = [segue destinationViewController];
}

@end

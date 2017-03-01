//
//  MWPersonalBestViewController.m
//  MW
//
//  Created by Emil Izgin on 07/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWPersonalBestViewController.h"

@interface MWPersonalBestViewController ()

@end

@implementation MWPersonalBestViewController {

    bool timeHistoryCellSelected;
    bool resetTimeTargetsCellSelected;
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
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0625 green:0.17578125 blue:0.18359375 alpha:1.0];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:NO];
    [self populateCells];
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
    DataAccess *db = [[DataAccess alloc] init];
    self.listData = [db getExTypesPB];
    [self.listData addObject: ([[NSObject alloc] init])];  // blank element defines a non-exercise cell
    [self.listData addObject: ([[NSObject alloc] init])];  // blank element defines anoter non-exercise cell
}

- (IBAction)cellButtonPressed:(id)sender {
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier;
    if (indexPath.row == ([self.listData count] - 2)) {
        identifier = @"Simple1";
    } else if (indexPath.row == ([self.listData count] - 1)) {
        identifier = @"Simple2";
    } else {
        identifier = @"Image";
    }
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
    
    if (indexPath.row < ([self.listData count] - 2)) {
        return 130;
    } else {
        return 44;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int row = [indexPath row];
    _exeDTO = [self.listData objectAtIndex:row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (row == ([self.listData count] - 2)) {
        timeHistoryCellSelected = YES;
        [self performSegueWithIdentifier: @"ToHTBSegue" sender: self];
    }
    if (row == ([self.listData count] - 1)) {
        resetTimeTargetsCellSelected = YES;
        [self performSegueWithIdentifier: @"ToResetPBTimeSegue" sender: self];
    }
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[UIButton class]]) {
        MWPBInstrViewController *pBVController = [segue destinationViewController];
        UIButton *butt = (UIButton*)sender;
        _exeDTO = [self.listData objectAtIndex:butt.tag];
        pBVController.exe = _exeDTO;
    } else {
        if (timeHistoryCellSelected) {
//            MWPBTimeHistoryTableViewController *tHistoryController = [segue destinationViewController];
        }
        if (resetTimeTargetsCellSelected) {
//            MWPBResetTargetTimePTViewController *resetPBController = [segue destinationViewController];
        }
    }
}

@end

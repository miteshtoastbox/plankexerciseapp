//
//  MWResetPBTimeViewController.m
//  MW
//
//  Created by Emil Izgin on 08/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWResetPBTimeViewController.h"

@interface MWResetPBTimeViewController ()

@end

@implementation MWResetPBTimeViewController

@synthesize listData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self populateCells];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    self.listData = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    identifier = @"Image";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    NSUInteger row = [indexPath row];
    ExerciseTypes *exType = [self.listData objectAtIndex:row];
    UIImage *image = [UIImage imageNamed: exType.exerciseImagePath];
    UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
    [btn setImage:image forState:UIControlStateNormal];
    btn.tag = indexPath.row;
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

#pragma mark - Specific

-(void) populateCells {
    self.listData = [[NSMutableArray alloc] init];
    DataAccess *db = [[DataAccess alloc] init];
    self.listData = [db getExTypesPB];
}


- (IBAction)exerciseImageButtonPressed:(id)sender {
    
    UIButton *butt = (UIButton*)sender;
    _exe = [self.listData objectAtIndex:butt.tag];
    DataAccess *db = [[DataAccess alloc] init];
    bool success = [db clearBestTime: _exe.pKExerciseTypeID];
    success = [db clearTimes: _exe.pKExerciseTypeID];
    if (success) {
        NSString *alertText = @"The time has been reset.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end

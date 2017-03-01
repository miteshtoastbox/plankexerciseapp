//
//  MWPersonalTrainerTableViewController.m
//  MW
//
//  Created by Emil Izgin on 23/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWPersonalTrainerTableViewController.h"


//#define TIME_HISTORY_CELL 999

@interface MWPersonalTrainerTableViewController (){
    InApp * _inapp;
    MBProgressHUD *hud;
}
@end

@implementation MWPersonalTrainerTableViewController {
    
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
    _inapp = [InApp sharedInstance];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0625 green:0.17578125 blue:0.18359375 alpha:1.0];
    
    //Purchase Fail
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noSuccess) name:INAPP_FAIL object:nil];
    
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
    self.listData = [db getExTypesPT];
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
    
    // Check NSUserDefaults UpgradedToPlankPro Flag if user has paid for upgrade. If so then let them through.
    NSString *udUpgradedToPlankPro = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"upgradedToPlankPro"];

    // temp flag
    udUpgradedToPlankPro=@"yes";
    
    if ([identifier isEqualToString:@"Image"]) {
        
        /* if not paid (Check NSUserDefaults UpgradedToPlankPro Flag) and is a locked exercise then show padlock version of image */
        if(([exType.exerciseName isEqualToString: @"Left Side Plank"]) && (![udUpgradedToPlankPro isEqualToString:@"yes"]))
        {
            UIImage *image = [UIImage imageNamed: @"LKleftSidePlank.jpg"];
            UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = indexPath.row;
        }
        else if(([exType.exerciseName isEqualToString: @"Right Side Plank"]) && (![udUpgradedToPlankPro isEqualToString:@"yes"]))
        {
            UIImage *image = [UIImage imageNamed: @"LKrightSidePlank.jpg"];
            UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = indexPath.row;
        }
        else if(([exType.exerciseName isEqualToString: @"Front Plank Arm Lift"]) && (![udUpgradedToPlankPro isEqualToString:@"yes"]))
        {
            UIImage *image = [UIImage imageNamed: @"LKfrontPlankArmLift.jpg"];
            UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = indexPath.row;
        }
        else if(([exType.exerciseName isEqualToString: @"Front Plank Leg Lift"]) && (![udUpgradedToPlankPro isEqualToString:@"yes"]))
        {
            UIImage *image = [UIImage imageNamed: @"LKfrontPlankLegLift.jpg"];
            UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = indexPath.row;
        }
        else
        {
            UIImage *image = [UIImage imageNamed: exType.exerciseImagePath];
            UIButton *btn = (UIButton*) [cell.contentView viewWithTag:1];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = indexPath.row;
        }
        
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
        [self performSegueWithIdentifier: @"ToHTSegue" sender: self];
    }
    if (row == ([self.listData count] - 1)) {
        resetTimeTargetsCellSelected = YES;
        [self performSegueWithIdentifier: @"ToResetTargetTimePTSegue" sender: self];
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    DataAccess *db = [[DataAccess alloc] init];
    // Get LegacyPaidUser flag. If flag is 1 then let them through as they are legacy user and have already paid in full ($1.99)
    int isLegacyPaidUser = [db CheckIfLegacyPaidUser];
    db = nil;
    
    // Check NSUserDefaults UpgradedToPlankPro Flag if user has paid for upgrade. If so then let them through.
    NSString *udUpgradedToPlankPro = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"upgradedToPlankPro"];
    
    udUpgradedToPlankPro=@"yes";
    UIButton *butt = (UIButton*)sender;
    _exeDTO = [self.listData objectAtIndex:butt.tag];
    if([_exeDTO.exerciseName isEqualToString: @"Front Plank"]){
        // Front Plank Free by default.
        return YES;
    }
    else
    {
        if(isLegacyPaidUser == TRUE)
        {
            return YES;
        }
        
        if ([udUpgradedToPlankPro isEqualToString:@"yes"]) {
            return YES;
        }
        else
        {
            // upgrade to full version
            [self launchAlert];
            return NO;
        }
    }
}


- (void) launchAlert
{
    // show price in alert view message
    NSDecimalNumber *decNum=[[NSDecimalNumber alloc] initWithDecimal:*(_inapp.strProdPrice)];
    decNum =_inapp.strProdPrice;
    NSString *outputString = [decNum stringValue];
    /*****************/
    
    // create a simple alert with an OK and cancel button
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Premium Feature available in the full version. Would you like to upgrade?"
                          message:outputString
                          delegate:self
                          cancelButtonTitle:@"Yes"
                          otherButtonTitles:@"No", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    // Parse
    PFObject *objUpgradeApp = [PFObject objectWithClassName:@"UpgradeApp"];
    if (buttonIndex == 0) {
        //NSLog(@"yes pressed");
        // upgrade to full version
        objUpgradeApp[@"upgrade"] = @"YES-PTList";
        [objUpgradeApp saveInBackground];
        
        hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 320, 460) ];
        hud.labelText = @"Please Wait...";
        [self.view addSubview:hud];
        [hud show:YES];
        
        [_inapp purchaseNow];
    } else {
        objUpgradeApp[@"upgrade"] = @"NO-PTLIST";
        [objUpgradeApp saveInBackground];

        //NSLog(@"no pressed");
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[UIButton class]]) {
        MWPTInstrViewController *vc = [segue destinationViewController];
        UIButton *butt = (UIButton*)sender;
        _exeDTO = [self.listData objectAtIndex:butt.tag];
        vc.exe = _exeDTO;
    } else {
        if (timeHistoryCellSelected) {
            MWTimeHistoryTableViewController *tHistoryController = [segue destinationViewController];
        }
        if (resetTimeTargetsCellSelected) {
            MWResetTargetTimePTViewController *resetPTController = [segue destinationViewController];
        }
    }
}

// Purchase success Part
- (void) noSuccess  {
    NSLog(@"noSuccess");
    [hud hide:YES];
    [hud removeFromSuperViewOnHide];
}

@end

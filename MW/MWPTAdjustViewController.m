//
//  MWPTAdjustViewController.m
//  MW
//
//  Created by Emil Izgin on 26/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWPTAdjustViewController.h"

@interface MWPTAdjustViewController ()

@end

@implementation MWPTAdjustViewController

UIScrollView *scrollview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)easyAction:(id)sender {
    [self performSegueWithIdentifier: @"ToProgress2Segue" sender: self];
    double currentTargetTime = _exe.exerciseTargetTime;
    double correctedTargetTime = currentTargetTime;     // init
    correctedTargetTime = currentTargetTime + 3.0;
    DataAccess *db = [[DataAccess alloc] init];
    bool targetTimeCorrected = [db saveTargetTime:correctedTargetTime onPrimaryKey:_exe.pKExerciseTypeID];
    if (targetTimeCorrected) {
        NSString *alertText = @"Your Target Time will be +3  next time.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Target Time Increase"
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)canDoBetterAction:(id)sender {
    [self performSegueWithIdentifier: @"ToProgress2Segue" sender: self];
    double currentTargetTime = _exe.exerciseTargetTime;
    double correctedTargetTime = currentTargetTime;     // init
    correctedTargetTime = currentTargetTime + 1.0;
    DataAccess *db = [[DataAccess alloc] init];
    bool targetTimeCorrected = [db saveTargetTime:correctedTargetTime onPrimaryKey:_exe.pKExerciseTypeID];
    if (targetTimeCorrected) {
        NSString *alertText = @"Your Target Time will be +1  next time.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Target Time Increase"
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (IBAction)justRightAction:(id)sender {
    [self performSegueWithIdentifier: @"ToProgress2Segue" sender: self];
    NSString *alertText = @"Your Target Time will stay the same.";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Target Time"
                          message:alertText
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil];
    [alert show];
}



- (IBAction)struggledAction:(id)sender {  
    [self performSegueWithIdentifier: @"ToProgress2Segue" sender: self];
    double currentTargetTime = _exe.exerciseTargetTime;
    double correctedTargetTime = currentTargetTime;     // init
    if (currentTargetTime > 1) {
        correctedTargetTime = currentTargetTime - 1.0;
    }
    DataAccess *db = [[DataAccess alloc] init];
    bool targetTimeCorrected = [db saveTargetTime:correctedTargetTime onPrimaryKey:_exe.pKExerciseTypeID];
    if (targetTimeCorrected) {
        NSString *alertText = @"Your Target Time will be -1 next time.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Target Time Decrease"
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)proAction:(id)sender {
    [self performSegueWithIdentifier: @"ToProgress2Segue" sender: self];
    double currentTargetTime = _exe.exerciseTargetTime;
    double correctedTargetTime = currentTargetTime;     // init
    correctedTargetTime = currentTargetTime + 10.0;
    DataAccess *db = [[DataAccess alloc] init];
    bool targetTimeCorrected = [db saveTargetTime:correctedTargetTime onPrimaryKey:_exe.pKExerciseTypeID];
    if (targetTimeCorrected) {
        NSString *alertText = @"Your Target Time will be +10  next time.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Target Time Increase"
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)veryEasyAction:(id)sender {
    [self performSegueWithIdentifier: @"ToProgress2Segue" sender: self];
    double currentTargetTime = _exe.exerciseTargetTime;
    double correctedTargetTime = currentTargetTime;     // init
    correctedTargetTime = currentTargetTime + 5.0;
    DataAccess *db = [[DataAccess alloc] init];
    bool targetTimeCorrected = [db saveTargetTime:correctedTargetTime onPrimaryKey:_exe.pKExerciseTypeID];
    if (targetTimeCorrected) {
        NSString *alertText = @"Your Target Time will be +5  next time.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Target Time Increase"
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end

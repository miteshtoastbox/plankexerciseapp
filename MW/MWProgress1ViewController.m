//
//  MWProgress1ViewController.m
//  MW
//
//  Created by Emil Izgin on 29/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWProgress1ViewController.h"

@interface MWProgress1ViewController ()

@end



@implementation MWProgress1ViewController

@synthesize progressLabel;
@synthesize percentLabel;
@synthesize progress;
@synthesize timer;

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
    [self.navigationController setNavigationBarHidden:YES];

    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.center = self.view.center;
    [self.view addSubview:self.progress];
    [self startCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.navigationController setNavigationBarHidden:NO];
    
    // First Time
    MWPTFirstTime *MWPTFirstTime = [segue destinationViewController];
    MWPTFirstTime.exe = self.exe;
    
    // After First time
    MWPTAdjustViewController *adjustViewController = [segue destinationViewController];
    adjustViewController.exe = self.exe;
    adjustViewController.firstTime = self.firstTime;
}

- (void)startCount {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer {
    static int count =0; count++;
    if (count <=10) {
        self.percentLabel.text = [NSString stringWithFormat:@"%d %%",count*10];
        self.progress.progress = (float)count/10.0f;
    } else {
        [self.timer invalidate];
        self.timer = nil;
        count = 0;
        
        if (self.firstTime) {
            [self performSegueWithIdentifier: @"ToPTFirstTime" sender: self];
        }
        else{
            [self performSegueWithIdentifier: @"ToPTAdjustSegue" sender: self];
        }
        
    }
}

@end

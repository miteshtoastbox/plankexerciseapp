//
//  MWProgress3ViewController.m
//  MW
//
//  Created by Emil Izgin on 08/02/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWProgress3ViewController.h"

@interface MWProgress3ViewController ()

@end

@implementation MWProgress3ViewController

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
    MWPersonalBestWithChartsViewController *pBestViewController = [segue destinationViewController];
    pBestViewController.exe = self.exe;
    pBestViewController.bestTime = self.bestTime;
    pBestViewController.xTime = self.xTime;
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
        [self performSegueWithIdentifier: @"ToPBWithChartSegue" sender: self];
    }
}

@end

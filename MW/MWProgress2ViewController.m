//
//  MWProgress2ViewController.m
//  MW
//
//  Created by Emil Izgin on 30/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWProgress2ViewController.h"

@interface MWProgress2ViewController ()

@end

@implementation MWProgress2ViewController


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
        [self performSegueWithIdentifier: @"BackToHomeFromAdjust1Segue" sender: self];
    }
}

@end

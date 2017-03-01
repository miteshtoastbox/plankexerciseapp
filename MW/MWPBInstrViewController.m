//
//  MWPBInstrViewController.m
//  MW
//
//  Created by Mitesh Chohan on 14/03/2014.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWPBInstrViewController.h"

@interface MWPBInstrViewController ()

@end

@implementation MWPBInstrViewController

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
    [self addScrollView];
}

-(void)addScrollView{
    
    // add ScrollView
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,580)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,960);//You Can Edit this with your requirement
    
    
    // add image
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:_exe.exerciseImagePath]];
    
    if([_exe.exerciseName isEqualToString:@"Front Plank"])
    {
        iv.frame=CGRectMake(100, 80, 100,80);
    }
    if(
       [_exe.exerciseName isEqualToString:@"Left Side Plank"]
       || [_exe.exerciseName isEqualToString:@"Right Side Plank"])
    {
        iv.frame=CGRectMake(100, 70, 100,100);
    }
    if(
       [_exe.exerciseName isEqualToString:@"Front Plank Leg Lift"]
       || [_exe.exerciseName isEqualToString:@"Front Plank Arm Lift"])
    {
        iv.frame=CGRectMake(100, 100, 100,90);
    }
    
    iv.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv];
    
    // add label Ex. Instructions
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 200.0f, 250.0f, 500.0f)];
    myLabel.numberOfLines = 0;
    
    [myLabel setText: [_exe.exerciseInstruction stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];
    
    // NSTextAlignmentJustified only available >= ios7
    if (IS_DEVICE_RUNNING_IOS_7_AND_ABOVE())
    {
        myLabel.textAlignment = NSTextAlignmentJustified;
    }
    
    myLabel.sizeToFit;
    [scrollview addSubview:myLabel];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MWPBViewController *vc = [segue destinationViewController];
    vc.exe = _exe;
}

@end

//
//  MWComboInfoViewController.m
//  MW
//
//  Created by Mitesh Chohan on 10/03/2014.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWComboInfoViewController.h"

@interface MWComboInfoViewController ()

@end

@implementation MWComboInfoViewController

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
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:NO];
    [self addscroll];
}

-(void) addscroll
{
    // add ScrollView
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,580)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,1400);//You Can Edit this with your requirement
    
    // add label Ex. Instructions
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 100.0f, 250.0f, 500.0f)];
    myLabel.numberOfLines = 0;
    
    [myLabel setText: [@"Combine all your plank exercises into a single-powerful workout with rest periods in the order shown below." stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];
    
    // NSTextAlignmentJustified only available >= ios7
    if (IS_DEVICE_RUNNING_IOS_7_AND_ABOVE())
    {
        myLabel.textAlignment = NSTextAlignmentJustified;
    }
    myLabel.sizeToFit;
    [scrollview addSubview:myLabel];
    
    
    // START
    UILabel *lblStart = [[UILabel alloc] initWithFrame:CGRectMake(140.0f, 200.0f, 250.0f, 500.0f)];
    lblStart.numberOfLines = 0;
    [lblStart setText: [@"START" stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];
    // NSTextAlignmentJustified only available >= ios7
    if (IS_DEVICE_RUNNING_IOS_7_AND_ABOVE())
    {
        lblStart.textAlignment = NSTextAlignmentJustified;
    }
    lblStart.sizeToFit;
    [scrollview addSubview:lblStart];
    
    
    // front plank image
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frontplank.gif"]];
    iv.frame=CGRectMake(100, 230, 100,80);
    iv.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv];
    
    // arrow
    UIImageView *iv2 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.jpg"]];
    iv2.frame=CGRectMake(150, 300, 40,88);
    iv2.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv2];
    
    // left plank image
    UIImageView *iv3 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftsideplank.gif"]];
    iv3.frame=CGRectMake(100, 370, 100,120);
    iv3.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv3];
    
    // arrow
    UIImageView *iv4 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.jpg"]];
    iv4.frame=CGRectMake(150, 510, 40,88);
    iv4.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv4];

    
    // right plank image
    UIImageView *iv5 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightsideplank.gif"]];
    iv5.frame=CGRectMake(100, 600, 100,120);
    iv5.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv5];
    
    // arrow
    UIImageView *iv6 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.jpg"]];
    iv6.frame=CGRectMake(150, 730, 40,88);
    iv6.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv6];

    // front plank leg lift
    UIImageView *iv7 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FrontPlankLegLift.jpg"]];
    iv7.frame=CGRectMake(100, 820, 90,100);
    iv7.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv7];
    
    // arrow
    UIImageView *iv8 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.jpg"]];
    iv8.frame=CGRectMake(150, 930, 40,88);
    iv8.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv8];

    // front plank arm lift
    UIImageView *iv9 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FrontPlankArmLift.jpg"]];
    iv9.frame=CGRectMake(110, 1030, 100,110);
    iv9.contentMode = UIViewContentModeScaleAspectFill;
    [scrollview addSubview:iv9];
    
    // START
    UILabel *lblFinish = [[UILabel alloc] initWithFrame:CGRectMake(140.0f, 1150, 250.0f, 500.0f)];
    lblFinish.numberOfLines = 0;
    [lblFinish setText: [@"FINISH" stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];
    // NSTextAlignmentJustified only available >= ios7
    if (IS_DEVICE_RUNNING_IOS_7_AND_ABOVE())
    {
        lblFinish.textAlignment = NSTextAlignmentJustified;
    }
    lblFinish.sizeToFit;
    [scrollview addSubview:lblFinish];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MWHomeViewController.m
//  MW
//
//  Created by Emil Izgin on 10/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWHomeViewController.h"
#import "Globals.h"


@interface MWHomeViewController (){
     InApp * _inapp;
    
    MBProgressHUD *hud;
}


@end

@implementation MWHomeViewController

int isLegacyPaidUser=0;
NSString *udUpgradedToPlankPro=@"";
bool bPremiumUser=false;


-(void) viewWillAppear:(BOOL)animated {
    
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationItem setHidesBackButton:YES];
    
 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Hmbg.png"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _inapp = [InApp sharedInstance];
    
    //Purchase Success
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneSuccess) name:INAPP_SUCCESS object:nil];
    
    //Purchase Fail
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noSuccess) name:INAPP_FAIL object:nil];
    
    // set PermiumUser flag
    bPremiumUser = [self isPremiumUser];
    //temp true
    bPremiumUser=true;
    
    if (bPremiumUser) {
        [_bttnMusic setImage:[UIImage imageNamed:@"quaver.png"] forState:UIControlStateNormal];
        [_bttnPB setImage:[UIImage imageNamed:@"bttnHmPB.png"] forState:UIControlStateNormal];
        [_bttnCombo setImage:[UIImage imageNamed:@"bttnCombo.png"] forState:UIControlStateNormal];
    }
    else{
        [_bttnMusic setImage:[UIImage imageNamed:@"quaverLK.png"] forState:UIControlStateNormal];
        [_bttnPB setImage:[UIImage imageNamed:@"bttnHmPBLk.png"] forState:UIControlStateNormal];
        [_bttnCombo setImage:[UIImage imageNamed:@"bttnComboLK.png"] forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    UIButton *butt = (UIButton*)sender;
    NSLog(@"bttn tag: %d", butt.tag);
    if(butt.tag==1 || bPremiumUser==TRUE)
    {
        return YES;
    }
    else
    {
        if(bPremiumUser){
            return YES;
        }
        else{
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
    PFObject *objPurchaseStatus = [PFObject objectWithClassName:@"PurchaseStatus"];

    
    PFObject *objUpgradeApp = [PFObject objectWithClassName:@"UpgradeApp"];
    if (buttonIndex == 0) {
        //NSLog(@"yes pressed");
        
        hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 320, 460) ];
        hud.labelText = @"Please Wait...";
        [self.view addSubview:hud];
        [hud show:YES];
        
        // upgrade to full version
        // ADD PARSE INAPP UNDER HERE [_inapp purchaseNow];
        [PFPurchase buyProduct:INAPP_PRODUCT_ID block:^(NSError *error) {
            if (!error) {
                // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                [self doneSuccess];
                objPurchaseStatus[@"status"] = @"Purchase is completed succesfully";
                [objPurchaseStatus saveInBackground];
            }
            else{
                [self noSuccess];
                objPurchaseStatus[@"status"] = @"Purchase failed";
                [objPurchaseStatus saveInBackground];

            }
        }];
        
        
        objUpgradeApp[@"upgrade"] = @"YES";
        [objUpgradeApp saveInBackground];
    } else {
        //NSLog(@"no pressed");
        
        objUpgradeApp[@"upgrade"] = @"NO";
        [objUpgradeApp saveInBackground];
        
    }
}


-(BOOL)isPremiumUser
{
    DataAccess *db = [[DataAccess alloc] init];
    // Get LegacyPaidUser flag. If flag is 1 then let them through as they are legacy user and have already paid in full ($1.99)
    
    isLegacyPaidUser = [db CheckIfLegacyPaidUser];
    db=NULL;
    
    // Check NSUserDefaults UpgradedToPlankPro Flag if user has paid for upgrade. If so then let them through.
    udUpgradedToPlankPro = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"upgradedToPlankPro"];
    
    if ([udUpgradedToPlankPro isEqualToString:@"yes"]) {
        return YES;
    }
    
    if (isLegacyPaidUser == 1) {
        return YES;
    }
    else
    {
        return NO;
    }
}

// Purchase success Part
- (void) doneSuccess  {
    
    NSString *valueToSave = @"yes";
    [[NSUserDefaults standardUserDefaults]
     setObject:valueToSave forKey:@"upgradedToPlankPro"];
    
    [hud hide:YES];
    [hud removeFromSuperViewOnHide];

    
    //    Please enter code you want
    BOOL isPurchased = [[NSUserDefaults standardUserDefaults] objectForKey:INAPP_PURCHASED];
    
    [_bttnMusic setImage:[UIImage imageNamed:@"quaver.png"] forState:UIControlStateNormal];
    [_bttnPB setImage:[UIImage imageNamed:@"bttnHmPB.png"] forState:UIControlStateNormal];
    [_bttnCombo setImage:[UIImage imageNamed:@"bttnCombo.png"] forState:UIControlStateNormal];
    //set local flag
    bPremiumUser=TRUE;
}

// Purchase success Part
- (void) noSuccess  {
    NSLog(@"noSuccess");
    [hud hide:YES];
    [hud removeFromSuperViewOnHide];
}


@end

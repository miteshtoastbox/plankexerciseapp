//
//  MWHomeViewController.h
//  MW
//
//  Created by Emil Izgin on 10/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InApp.h"
#import "DataAccess.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface MWHomeViewController : UIViewController
{
    NSString *integerString;
}

@property (weak, nonatomic) IBOutlet UIButton *bttnMusic;
@property (weak, nonatomic) IBOutlet UIButton *bttnPB;
@property (weak, nonatomic) IBOutlet UIButton *bttnCombo;

@end

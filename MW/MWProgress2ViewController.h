//
//  MWProgress2ViewController.h
//  MW
//
//  Created by Emil Izgin on 30/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWProgress2ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) IBOutlet UILabel *percentLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) IBOutlet UILabel *progressLabel;

-(void)startCount;

@end

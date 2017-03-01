//
//  MWViewController.h
//  MW
//
//  Created by Emil Izgin on 10/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *exTimeLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *exTimePicker;
//@property (strong, nonatomic) IBOutlet UILabel *restTimeLabel;
//@property (strong, nonatomic) IBOutlet UIPickerView *restTimePicker;
@property (strong, nonatomic) IBOutlet UIButton *goButton;
@property (strong, nonatomic) NSArray *secondsArray;
@property (strong, nonatomic) NSArray *minutesArray;
@property (strong, nonatomic) NSArray *hoursArray;

@property (strong, nonatomic) NSString *exHours;
@property (strong, nonatomic) NSString *exMinutes;
@property (strong, nonatomic) NSString *exSeconds;

//@property (strong, nonatomic) NSString *restHours;
//@property (strong, nonatomic) NSString *restMinutes;
//@property (strong, nonatomic) NSString *restSeconds;

- (IBAction)go:(id)sender;
- (BOOL)validateInput;

@end

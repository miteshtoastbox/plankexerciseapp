//
//  MWRestTimeViewController.m
//  MW
//
//  Created by Emil Izgin on 16/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWRestTimeViewController.h"
#import "Globals.h"

@interface MWRestTimeViewController ()

@end

@implementation MWRestTimeViewController

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
    
    
    self.secondsRestTimeArray  = [[NSMutableArray alloc] initWithObjects:@"0 secs",@"1 secs",@"2 secs",@"3 secs",@"4 secs",@"5 secs",@"6 secs",@"7 secs",@"8 secs",@"9 secs",@"10 secs",@"11 secs",@"12 secs",@"13 secs",@"14 secs",@"15 secs",@"16 secs",@"17 secs",@"18 secs",@"19 secs",@"20 secs",@"21 secs",@"22 secs",@"23 secs",@"24 secs",@"25 secs",@"26 secs",@"27 secs",@"28 secs",@"29 secs",@"30 secs",@"31 secs",@"32 secs",@"33 secs",@"34 secs",@"35 secs",@"36 secs",@"37 secs",@"38 secs",@"39 secs",@"40 secs",@"41 secs",@"42 secs",@"43 secs",@"44 secs",@"45 secs",@"46 secs",@"47 secs",@"48 secs",@"49 secs",@"50 secs",@"51 secs",@"52 secs",@"53 secs",@"54 secs",@"55 secs",@"56 secs",@"57 secs",@"58 secs",@"59 secs", nil];
    self.minutesRestTimeArray = [[NSMutableArray alloc] initWithObjects:@"0 mins",@"1 mins",@"2 mins",@"3 mins",@"4 mins",@"5 mins",@"6 mins",@"7 mins",@"8 mins",@"9 mins",@"10 mins",@"11 mins",@"12 mins",@"13 mins",@"14 mins",@"15 mins",@"16 mins",@"17 mins",@"18 mins",@"19 mins",@"20 mins",@"21 mins",@"22 mins",@"23 mins",@"24 mins",@"25 mins",@"26 mins",@"27 mins",@"28 mins",@"29 mins",@"30 mins",@"31 mins",@"32 mins",@"33 mins",@"34 mins",@"35 mins",@"36 mins",@"37 mins",@"38 mins",@"39 mins",@"40 mins",@"41 mins",@"42 mins",@"43 mins",@"44 mins",@"45 mins",@"46 mins",@"47 mins",@"48 mins",@"49 mins",@"50 mins",@"51 mins",@"52 mins",@"53 mins",@"54 mins",@"55 mins",@"56 mins",@"57 mins",@"58 mins",@"59 mins", nil];
    self.hoursRestTimeArray = [[NSMutableArray alloc] initWithObjects:@"0 hrs",@"1 hrs",@"2 hrs",@"3 hrs",@"4 hrs",@"5 hrs",@"6 hrs",@"7 hrs",@"8 hrs",@"9 hrs",@"10 hrs",@"11 hrs",@"12 hrs",@"13 hrs",@"14 hrs",@"15 hrs",@"16 hrs",@"17 hrs",@"18 hrs",@"19 hrs",@"20 hrs",@"21 hrs",@"22 hrs",@"23 hrs", nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 24;
    } else {
        return 60;  
    }
}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return [self.hoursRestTimeArray objectAtIndex:row];
        case 1:
            return [self.minutesRestTimeArray objectAtIndex:row];
        default:
            return [self.secondsRestTimeArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    if ([pickerView isEqual: _exTimePicker]) {
//        switch (component) {
//            case 0:
//                _exHours = [self pickerView:pickerView titleForRow:row forComponent:component];
//                break;
//            case 1:
//                _exMinutes = [self pickerView:pickerView titleForRow:row forComponent:component];
//                break;
//            default:
//                _exSeconds = [self pickerView:pickerView titleForRow:row forComponent:component];
//        }
//    } else {
        switch (component) {
            case 0:
                _restHours = [self pickerView:pickerView titleForRow:row forComponent:component];
                [[Globals getInstance] setRestHoursSet:_restHours];
                break;
            case 1:
                _restMinutes = [self pickerView:pickerView titleForRow:row forComponent:component];
                [[Globals getInstance] setRestMinutesSet:_restMinutes];
                break;
            default:
                _restSeconds = [self pickerView:pickerView titleForRow:row forComponent:component];
                [[Globals getInstance] setRestSecondsSet:_restSeconds];
        }
//    }
}

//- (IBAction)go:(id)sender {

    //    NSLog(@"%@", _exMinutes);
    //    if ([self validateInput] == NO) {
    //
    //    }
//}


- (BOOL)validateInput {
    
//    if (([self isEqualTo0OrNil: _exHours]) && ([self isEqualTo0OrNil: _exMinutes]) && ([self isEqualTo0OrNil: _exSeconds])) {
//        return NO;
//    } else {
        if (([self isEqualTo0OrNil: _restHours]) && ([self isEqualTo0OrNil: _restMinutes]) && ([self isEqualTo0OrNil: _restSeconds])) {
            return NO;
        }
//    }
    return YES;
}


- (bool) isEqualTo0OrNil:(NSString*)str {
    
    if ((str == nil) || ([str isEqualToString:@"0"])) {
        return YES;
    }
    return NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    return YES;
    return [self validateInput];
}

@end

//
//  MWPBInstrViewController.h
//  MW
//
//  Created by Mitesh Chohan on 14/03/2014.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#include "MWPBViewController.h"

@interface MWPBInstrViewController : UIViewController{

    UIScrollView *myScrollView;
    UIImage *imgView;
}
    @property (strong, nonatomic) ExerciseTypes *exe;

@end

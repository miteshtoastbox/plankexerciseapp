//
//  MWPTInstrViewController.h
//  MW
//
//  Created by Mitesh Chohan on 07/03/2014.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "ExerciseTypes.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#include "MWPTViewController.h"

@interface MWPTInstrViewController : UIViewController{

    UIScrollView *myScrollView;
    UIImage *imgView;
}


@property (strong, nonatomic) ExerciseTypes *exe;


@end


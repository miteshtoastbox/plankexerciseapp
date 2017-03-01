//
//  MWExceDelegate.h
//  MW
//
//  Created by Emil Izgin on 18/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MWExceDelegate <NSObject>

-(void) instate: (UIViewController *) sender;  
-(void) showCounterValue:(double)counterValue;
-(NSTimeInterval) exTimeSet;
-(NSTimeInterval) restTimeSet;
-(void)startExTimer;
-(void)startRestTimer;

@end


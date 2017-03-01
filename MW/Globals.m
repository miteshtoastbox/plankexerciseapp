//
//  Globals.m
//  MW
//
//  Created by Emil Izgin on 17/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "Globals.h"

@implementation Globals

@synthesize str;
@synthesize exHoursSet;
@synthesize exMinutesSet;
@synthesize exSecondsSet;
@synthesize restHoursSet;
@synthesize restMinutesSet;
@synthesize restSecondsSet;

static Globals *instance =nil;

+(Globals*) getInstance {
    
    @synchronized(self) {    // for possible future use
        if(instance==nil) {
            instance= [Globals new];
        }
    }
    return instance;
}

@end

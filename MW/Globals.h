//
//  Globals.h
//  MW
//
//  Created by Emil Izgin on 17/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject {
 
    NSString *str;

}

@property(nonatomic,strong) NSString *str;
@property(nonatomic,strong) NSString *exHoursSet;
@property(nonatomic,strong) NSString *exMinutesSet;
@property(nonatomic,strong) NSString *exSecondsSet;
@property(nonatomic,strong) NSString *restHoursSet;
@property(nonatomic,strong) NSString *restMinutesSet;
@property(nonatomic,strong) NSString *restSecondsSet;

+(Globals*)getInstance;

@end

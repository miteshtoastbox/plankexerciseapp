//
//  DataAccess.h
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Utility.h"

#import "ExerciseTypes.h"
#import "ExerciseTimes.h"



@interface DataAccess : NSObject



-(NSString*)getTownName: (int)townId;

-(ExerciseTypes *) getExTypes;
-(ExerciseTypes *) getExTypesPT;
-(ExerciseTypes *) getExTypesPB;

-(ExerciseTimes *) getExTimes;
-(NSMutableArray*) getChartData:(int)pKExerciseTypeID;
-(double) getBestTimePT:(int)pKExerciseTypeID;
-(double) getBestTimePB:(int)pKExerciseTypeID;

//-(Service *) getServices: (int) inTown withCrewsClause: (NSMutableString*) crewsClause withSortByClause: (NSMutableString*) sortByClause relativeToLocation: (CLLocation*)location;
//-(Service *) getFavouriteServices;
//
//-(StationExtended *) getStations: (NSMutableString*) crewsClause;
//-(Phone *) getPhoneNumbers: (int) svcId;
//
//-(NSMutableDictionary*) getAllServicesIds;

-(bool) saveTargetTime: (double)tT onPrimaryKey:(int)pK;
-(bool) saveBestTime: (double)tT onPrimaryKey:(int)pK;
-(bool) clearTimes: (int)fK;
-(bool) clearTargetTime: (int)pK;
-(bool) clearBestTime: (int)pK;

-(bool) recordExTime: (double)exT forExerciseType:(ExerciseTypes*)exType at:(NSDate*)exDoneTime;

- (void) tmpUpgradeAppFlagForInApp;
-(int) CheckIfLegacyPaidUser;
@end

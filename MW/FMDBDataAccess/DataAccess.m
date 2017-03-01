//
//  DataAccess.m
//
#import <Foundation/Foundation.h>
#import "FMDatabase.h" 
#import "FMResultSet.h" 
#import "Utility.h" 
#import "DataAccess.h"


@implementation DataAccess

-(NSMutableArray *) getExTypes {
    
    NSMutableArray *exTypes = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM ExerciseTypes"];
    
    while([results next]) {
        ExerciseTypes *xType = [[ExerciseTypes alloc] init];
        xType.pKExerciseTypeID = [results intForColumn:@"PKExerciseTypeID"];
        xType.exerciseMode = [results stringForColumn:@"ExerciseMode"];
        xType.exerciseImagePath = [results stringForColumn:@"ExerciseImagePath"];
        xType.exerciseInstruction = [results stringForColumn:@"ExerciseInstruction"];
        xType.exerciseName = [results stringForColumn:@"ExerciseName"];
        xType.exerciseTargetTime = [results doubleForColumn:@"TargetTime"];
        [exTypes addObject:xType];
    }
    [db close];
    return exTypes;
}

-(NSMutableArray *) getExTypesPB {
    
    NSMutableArray *exTypes = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM ExerciseTypes"];
    
    while([results next]) {
        ExerciseTypes *xType = [[ExerciseTypes alloc] init];
        NSString* mode = [results stringForColumn:@"ExerciseMode"];
        if ([mode isEqualToString:@"PB"]) {
            xType.pKExerciseTypeID = [results intForColumn:@"PKExerciseTypeID"];
            xType.exerciseMode = mode;
            xType.exerciseImagePath = [results stringForColumn:@"ExerciseImagePath"];
            xType.exerciseInstruction = [results stringForColumn:@"ExerciseInstruction"];
            xType.exerciseName = [results stringForColumn:@"ExerciseName"];
            xType.exerciseTargetTime = [results doubleForColumn:@"TargetTime"];
            [exTypes addObject:xType];
        }
    }
    [db close];
    return exTypes;
}

             
 -(NSMutableArray *) getExTypesPT {
     
     NSMutableArray *exTypes = [[NSMutableArray alloc] init];
     FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
     [db open];
     FMResultSet *results = [db executeQuery:@"SELECT * FROM ExerciseTypes"];
     
     while([results next]) {
         ExerciseTypes *xType = [[ExerciseTypes alloc] init];
         NSString* mode = [results stringForColumn:@"ExerciseMode"];
         if ([mode isEqualToString:@"PT"]) {
             xType.pKExerciseTypeID = [results intForColumn:@"PKExerciseTypeID"];
             xType.exerciseMode = mode;
             xType.exerciseImagePath = [results stringForColumn:@"ExerciseImagePath"];
             xType.exerciseInstruction = [results stringForColumn:@"ExerciseInstruction"];
             xType.exerciseName = [results stringForColumn:@"ExerciseName"];
             xType.exerciseTargetTime = [results doubleForColumn:@"TargetTime"];
             [exTypes addObject:xType];
         }
      }
      [db close];
      return exTypes;
}


-(bool) saveTargetTime: (double)tT onPrimaryKey:(int)pK {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE ExerciseTypes SET TargetTime = '%f' where PKExerciseTypeID = %d", tT, pK]];
    [db close];
    return success;
}


// Best times are saved in TargetTime field! It stores target and best times.
-(bool) saveBestTime: (double)tT onPrimaryKey:(int)pK {
    
    bool success = [self saveTargetTime:tT onPrimaryKey:pK];
    return success;
}

// delete all results for the exercise from ExerciseTimes
-(bool) clearTimes: (int)fK {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM ExerciseTimes where FKExerciseTypeID = %d", fK]];
    [db close];
    return success;
}


-(bool) clearTargetTime: (int)pK {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE ExerciseTypes SET TargetTime = '%f' where PKExerciseTypeID = %d", 0.0, pK]];
    [db close];
    return success;
}


// Best times are saved in TargetTime field! It stores target and best times.
-(bool) clearBestTime: (int)pK {
    
    BOOL success = [self clearTargetTime: pK];
    return success;
}


-(bool) recordExTime: (double)exT forExerciseType:(ExerciseTypes*)exType at:(NSDate*)exDoneTime {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    // Autoincrement emulation
    ExerciseTimes *xTime = [[ExerciseTimes alloc] init];
    xTime.pKExerciseTimeID = 0;
    FMResultSet *results = [db executeQuery:@"SELECT MAX(PKExerciseTimeID) FROM ExerciseTimes;"];
    while([results next]) {
        xTime.pKExerciseTimeID = [results doubleForColumn:@"MAX(PKExerciseTimeID)"];
    }

    int pKExerciseTypeID = exType.pKExerciseTypeID;
    double newPKETID = xTime.pKExerciseTimeID + 1;
    bool success = [db executeUpdate:@"INSERT INTO ExerciseTimes (PKExerciseTimeID, FKExerciseTypeID, ExerciseTimeSeconds) VALUES (?,?,?)", [NSNumber numberWithDouble:newPKETID], [NSNumber numberWithInt:pKExerciseTypeID], [NSNumber numberWithDouble:exT]];
    [db close];
    return success;
}


-(NSMutableArray *) getExTimes {    // returns array of ExerciseTimess
    
    NSMutableArray *exTimes = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM ExerciseTimes"];
    while([results next]) {
        ExerciseTimes *xTime = [[ExerciseTimes alloc] init];
        xTime.pKExerciseTimeID = [results doubleForColumn:@"PKExerciseTimeID"];
        xTime.fKExerciseTypeID = [results intForColumn:@"FKExerciseTypeID"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //this is the sqlite's format
        NSDate *date = [formatter dateFromString:@"  "];
        xTime.exerciseDate = [results dateForColumn:@"ExerciseDate"];
        
        xTime.exerciseTime = [results doubleForColumn:@"ExerciseTime"];
        [exTimes addObject:xTime];
    }
    [db close];
    return exTimes;
}


-(double) getBestTimePT:(int)pKExerciseTypeID {
    
    double best = 0.0;
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ExerciseTimes WHERE FKExerciseTypeID = '%d' ORDER BY ExerciseTimeSeconds DESC", pKExerciseTypeID]];
    while([results next]) {
        best = [results doubleForColumn:@"ExerciseTimeSeconds"];
        break;
    }
    [db close];
    return best;
}


// Get best time for PB from ExerciseTypes
-(double) getBestTimePB:(int)pKExerciseTypeID {
    
    double best = 0.0;
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ExerciseTypes WHERE PKExerciseTypeID = '%d' AND ExerciseMode='PB' ", pKExerciseTypeID]];
    while([results next]) {
        best = [results doubleForColumn:@"TargetTime"];
        break;
    }
    [db close];
    return best;
}


-(NSMutableArray*) getChartData:(int)pKExerciseTypeID {   // returns array of ExerciseTimess
    
    NSMutableArray *exTimes = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
//    NSDate *date;
    NSMutableString* st;
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ExerciseTimes WHERE FKExerciseTypeID = '%d' ORDER BY ExerciseDate ASC", pKExerciseTypeID]];
    while([results next]) {
        ExerciseTimes *xTime = [[ExerciseTimes alloc] init];
        xTime.pKExerciseTimeID = [results doubleForColumn:@"PKExerciseTimeID"];
        xTime.fKExerciseTypeID = [results intForColumn:@"FKExerciseTypeID"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //this is the sqlite's format
        st = [results stringForColumn:@"ExerciseDate"];

//        date = [results dateForColumn:@"ExerciseDate"];
        xTime.exerciseDate = [formatter dateFromString:st];
//        xTime.exerciseDate = [results dateForColumn:@"ExerciseDate"];
        
        xTime.exerciseTime = [results doubleForColumn:@"ExerciseTimeSeconds"];
        [exTimes addObject:xTime];
    }
    [db close];
    return exTimes;
}

/* 
MC: Upgrade/IN-App Purchase Code
*/

/* Update upgrade flag to 1 to signify the user has updated to Version 2. */
-(void) tmpUpgradeAppFlagForInApp {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    bool success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE tmpAppUpgrade SET upgrade = '%d'", 1]];
    [db close];
    if(success)
    {
        //NSLog(@"upgrade flag added");
    }
    else{
        //NSLog(@"ERROR ADDING upgrade flag added");
    }
}

// Return InAppUpgrade Flag. 1 = user upgraded
-(int) CheckIfLegacyPaidUser {
    
    int bUpgraded = 0;
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT upgrade FROM tmpAppUpgrade"]];
    while([results next]) {
        bUpgraded = [results doubleForColumn:@"upgrade"];
        break;
    }
    [db close];
    return bUpgraded;
}

/* MC : END Upgrade/IN-App Purchase Code ********************************************/

@end

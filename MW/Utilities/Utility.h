//
//  Utility.h
//
//

#import <Foundation/Foundation.h>
#import "MWAppDelegate.h"

@interface Utility : NSObject {
    
}

+(NSString *) getDatabasePath; 
+(void) showAlert:(NSString *) title message:(NSString *) msg; 

@end

//
//  Utility.m
//

#import "Utility.h"

@implementation Utility

+(NSString *) getDatabasePath
{
    NSString *databasePath = [(MWAppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath; 
}

+(void) showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

@end

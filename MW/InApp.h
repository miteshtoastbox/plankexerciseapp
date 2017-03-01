//
//  InApp.h
//  MW
//
//  Created by Mitesh Chohan on 29/03/2014.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <Parse/Parse.h>

@interface InApp : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate, SKRequestDelegate>

+ (InApp *) sharedInstance;
- (void) purchaseNow ;

- (void)getAvailableProducts;
- (BOOL)canMakePurchase;
- (void)purchaseProduct:(SKProduct*)product;
- (void)restorePurchase;


@property (nonatomic,assign) NSDecimal *strProdPrice;

@end


SKProductsRequest *productRequest;
NSArray *validProductsInStore;


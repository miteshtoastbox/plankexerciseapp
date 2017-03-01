//
//  InApp.m
//  MW
//
//  Created by Mitesh Chohan on 29/03/2014.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "InApp.h"

@implementation InApp

+ (InApp *) sharedInstance {
    
    static InApp * _inapp;
    
    if (!_inapp) {
        
        _inapp = [[InApp alloc] init];
        validProductsInStore = [[NSMutableArray alloc] init];
    }
    
    return _inapp;
}

- (id) init {
    
    self = [super init];
    if (self) {
        [self getAvailableProducts];
    }
    
    return self;
}

-(void)getAvailableProducts{
    NSSet *productIdentifiers = [NSSet
                                 setWithObjects:INAPP_PRODUCT_ID,nil];
    productRequest = [[SKProductsRequest alloc]
                      initWithProductIdentifiers:productIdentifiers];
    productRequest.delegate = self;
    [productRequest start];
}

- (BOOL)canMakePurchase
{
    return [SKPaymentQueue canMakePayments];
}

- (void) purchaseNow {

    if ( validProductsInStore.count > 0) {
        [self purchaseProduct:[validProductsInStore objectAtIndex:0]];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertView show];
        
        // Parse
        PFObject *objPurchaseStatus = [PFObject objectWithClassName:@"PurchaseStatus"];
        objPurchaseStatus[@"status"] = @"Purchases are disabled in your device (func:purchaseNow)";
        [objPurchaseStatus saveInBackground];
    }
}

- (void)purchaseProduct:(SKProduct*)product{
    if ([self canMakePurchase]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        
        // Parse
        PFObject *objPurchaseStatus = [PFObject objectWithClassName:@"PurchaseStatus"];
        objPurchaseStatus[@"status"] = @"Purchases are disabled in your device (func:purchaseProduct)";
        [objPurchaseStatus saveInBackground];
    }
}


- (void) restorePurchase{
    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


-(IBAction)bttnPurchase:(id)sender{
    [self purchaseProduct:[validProductsInStore objectAtIndex:0]];
    //bttnPurchase.enabled = NO;
}

#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    // Parse
    PFObject *objPurchaseStatus = [PFObject objectWithClassName:@"PurchaseStatus"];
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                //NSLog(@"Purchasing Product From Store!");
                break;
            case SKPaymentTransactionStatePurchased:
                
                if ([transaction.payment.productIdentifier    isEqualToString:INAPP_PRODUCT_ID]) {
                    //NSLog(@"Product Purchased From Store!");
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                              @"Purchase is completed succesfully" message:nil delegate:
                                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alertView show];
                    
                    NSString *valueToSave = @"yes";
                    [[NSUserDefaults standardUserDefaults]
                    setObject:valueToSave forKey:@"upgradedToPlankPro"];
                    
                    // successfully
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:INAPP_PURCHASED];
                    [[NSNotificationCenter defaultCenter] postNotificationName:INAPP_SUCCESS object:nil];
                    
                    objPurchaseStatus[@"status"] = @"Purchase is completed succesfully";
                    [objPurchaseStatus saveInBackground];
                    
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
            {
                //NSLog(@"Restored ");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                          @"Purchases restored" message:nil delegate:
                                          self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
                
                objPurchaseStatus[@"status"] = @"Purchase restored";
                [objPurchaseStatus saveInBackground];
            }
                break;
            case SKPaymentTransactionStateFailed:
                //NSLog(@"Purchase failed ");
                objPurchaseStatus[@"status"] = @"Purchase failed";
                [objPurchaseStatus saveInBackground];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:INAPP_FAIL object:nil];
                break;
            default:
                break;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:INAPP_ENABLE object:nil];
    }
}


-(void)productsRequest:(SKProductsRequest *)request  didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if (count>0) {

        validProductsInStore = [[NSMutableArray alloc] init];
        validProductsInStore = [response.products copy];
        
        validProduct = [response.products objectAtIndex:0];
        
        if ([validProduct.productIdentifier isEqualToString:INAPP_PRODUCT_ID])
        {
            NSLog(@"Price = %@", validProduct.price);
            _strProdPrice = CFBridgingRetain(validProduct.price);
            [[NSNotificationCenter defaultCenter] postNotificationName:INAPP_ENABLE object:nil];
        }
        
    } else {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
    }
}

- (void) returnStrTest
{
    NSLog(@"£££ TEST £££");
}

@end


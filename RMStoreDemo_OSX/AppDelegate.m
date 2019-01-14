//
//  AppDelegate.m
//  RMStoreDemo_OSX
//
//  Created by Sergey P on 12.07.16.
//  Copyright © 2016 Robot Media. All rights reserved.
//

#import "AppDelegate.h"
#import "RMStore.h"
#import "RMStoreAppReceiptVerifier.h"
#import "RMStoreKeychainPersistence.h"
#import "RMAppReceipt.h"

@interface AppDelegate ()

@end

@implementation AppDelegate





- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [[RMStore defaultStore] removeStoreObserver:self];
    NSLog(@"Products termed");
}

- (void)storeProductsRequestFailed:(NSNotification*)notification
{
    NSError *error = notification.rm_storeError;
    NSLog(@"storeProductsRequestFailed");
}

- (void)storeProductsRequestFinished:(NSNotification*)notification
{
    NSArray *products = notification.rm_products;
    NSArray *invalidProductIdentifiers = notification.rm_invalidProductIdentifiers;
    NSLog(@"storeProductsRequestFinished");
}


@end

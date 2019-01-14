
#import "inapppurchase.h"
#import "RMStore.h"
#import "RMStoreAppReceiptVerifier.h"
#import "RMStoreKeychainPersistence.h"
#import "RMAppReceipt.h"
#import "AppDelegate.h"


int ReceiptValidation(){

    __block int ret = 1;
    
    RMStoreAppReceiptVerifier *_receiptVerifier = [[RMStoreAppReceiptVerifier alloc] init];
    [RMStore defaultStore].receiptVerifier = _receiptVerifier;
    
    if (_receiptVerifier.verifyAppReceipt) {
        NSLog(@"RECEIPT VALID:%@",_receiptVerifier.bundleIdentifier);
        ret = 0;
    } else {
        [[RMStore defaultStore] refreshReceiptOnSuccess:^{
            if (_receiptVerifier.verifyAppReceipt)
            {
                NSLog(@"Refresh RECEIPT VALID");
                ret = 0;
            }
            else
            {
                NSLog(@"Refresh RECEIPT NOT VALID");
                ret = -1;
            }
        } failure:^(NSError *error) {
            ret = -2;
            NSLog(@"Refresh RECEIPT NOT VALID 2:%@",error.localizedDescription);
        }];
    }

    int itime = 0;
    do{
        usleep(1000*300);
        if (ret==1) {
            continue;
        }else{
            break;
        }
    }while (itime++<20);
    
    return ret;
}


int GetInAppLists(TPayInfoList*pplist){
    __block int ret = 1;
    __block int index = 0;
    
    RMAppReceipt *receipt = [RMAppReceipt bundleReceipt];
    
    pplist->counts = receipt.inAppPurchases.count;
    __block TPayInfo* pro = malloc(sizeof(TPayInfo)*pplist->counts);
    pplist->pro = pro;
    
    for (RMAppReceiptIAP *data in  receipt.inAppPurchases){
        NSLog(@"Purchase:[%@,%@,%ld,%@]",data.transactionIdentifier,data.productIdentifier,(long)data.quantity,[data.purchaseDate description]);
        
        pro[index].iQuantity = data.quantity;
        strncpy(pro[index].szProductID,[data.productIdentifier UTF8String],125);
        strncpy(pro[index].szTransantionID,[data.transactionIdentifier UTF8String],125);
        strncpy(pro[index].szPurchaseDate,[[data.purchaseDate description] UTF8String],125);
        index++;
    }
    
    return ret;
}


int GetInAppInfo(TProductInfoList* outlist,TProductIdList* inlist){
   return [[RMStore defaultStore] GetInAppInfoObc:outlist:inlist];
}


int InAppPurchase(char* szproductID){
    
    __block int ret = 1;
    
    NSString *productID = [NSString stringWithUTF8String: szproductID];
    
    [[RMStore defaultStore] addPayment:productID success:^(SKPaymentTransaction *transaction) {
        NSLog(@"addPayment %@ success",productID);
        ret = 0;
    } failure:^(SKPaymentTransaction *transaction, NSError *error) {
        NSLog(@"addPayment %@ failure %ld %@",productID,(long)error.code,error.localizedDescription);
        ret = -1;
    }];
    
    int itime = 0;
    do{
        usleep(1000*300);
        if (ret==1) {
            continue;
        }else{
            break;
        }
    }while (1);
    
    return ret;
}




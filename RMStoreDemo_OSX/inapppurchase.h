

#ifndef inapppurchase_h
#define inapppurchase_h


#ifdef __cplusplus
extern "C" {
#endif

    int ReceiptValidation();
    
   
    typedef struct tagPayInfo
    {
        long    iQuantity;
        char    szProductID[125];
        char    szTransantionID[125];
        char    szPurchaseDate[125];
    }TPayInfo;
    typedef struct TPayInfoList{
        int counts;
        TPayInfo* pro;  // free(pro);
    }TPayInfoList;
    int GetInAppLists(TPayInfoList*);
    

    typedef struct tagProductInfo
    {
        char    szProductID[125];
        char    szTitle[125];
        char    szPrice[125];
        char    szDescription[255];
    }TProductInfo;
    typedef struct TProductInfoList{
        int counts;
        TProductInfo* pro;  // free(pro);
    }TProductInfoList;
    typedef struct TProId{
        char pid[125];
    }TProId;
    typedef struct TProductIdList{
        int counts;
        TProId* pidlist;
    }TProductIdList;
    int GetInAppInfo(TProductInfoList* outlist,TProductIdList* inlist);
    
    
    int InAppPurchase(char* productID);
    
    
#ifdef __cplusplus
}
#endif



#endif /* inapppurchase_h */

//
//  MasterDataModelController.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterDataModelController.h"

static MasterDataModelController *sharedInstance = nil;

@implementation MasterDataModelController

+(MasterDataModelController*) sharedInstance{
    @synchronized(self){
        if(sharedInstance == nil)
            sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;   
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


@end

//
//  MoleHelper.m
//  Bop-A-Mole
//
//  Created by Ethan Benanav on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoleHelper.h"
#import "Moles.h"

@implementation MoleHelper

+(id)createMole:(int)type {
    switch(type) {
        case MOLE_TAP: return [[SingleTapMole alloc] initSingleTapMole];
            break;
        case MOLE_DOUBLE_TAP: return [[MultiTapMole alloc] initMultiTapMole];
            break;
        default: return [[SingleTapMole alloc] initSingleTapMole];
            break;
    }
}

@end

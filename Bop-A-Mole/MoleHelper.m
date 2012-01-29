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

+(id)createMole:(NSString*)type {
    if([type isEqualToString:@"Tap Mole"]) {
        return [[SingleTapMole alloc] initSingleTapMole];
    }
    else if([type isEqualToString:@"Multi Tap Mole"]) {
        return [[MultiTapMole alloc] initMultiTapMole];
    }
    else if([type isEqualToString:@"Slash Mole"]) {
        return [[SlashMole alloc] initSlashMole];
    }
    else {
        return nil;
    }
}

@end

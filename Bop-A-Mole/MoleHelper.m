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
    else if([type isEqualToString:@"Jumping Mole"]) {
        return [[JumpingMole alloc] initJumpingMole];
    }
    else if([type isEqualToString:@"Quick Tap Mole"]) {
        return [[QuickTapMole alloc] initWithQuickTapMole];
    }
    else if([type isEqualToString:@"Quick Slash Mole"]) {
        return [[QuickSlashMole alloc] initWithQuickSlashMole];
    }
    else if([type isEqualToString:@"Bomb Mole"]) {
        return [[BombMole alloc] initWithBombMole];
    }
    else if([type isEqualToString:@"Skip"]) {
        return [[SkipMole alloc] initWithSkipMole];
    }else{
        return nil;
    }
}

@end

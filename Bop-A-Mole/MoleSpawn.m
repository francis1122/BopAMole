//
//  MoleSpawn.m
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/29/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import "MoleSpawn.h"

@implementation MoleSpawn

@synthesize mole, nextMole, dt, death_dt, pattern;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end

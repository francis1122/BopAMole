//
//  SkipMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SkipMole.h"
#import "Constants.h"

@implementation SkipMole

-(id) initWithSkipMole{
    if(self = [super init]){
        self.enteringBeatSpan = .2;
        self.beatLifeSpan = .2;
    }
    return self;
}

-(void) draw{
    //[super draw];
    if(DEBUGMODE){
        CGPoint array[4];
        array[0] = CGPointMake(0, 0);
        array[1] = CGPointMake(self.contentSize.width, 0);
        array[2] = CGPointMake(self.contentSize.width, self.contentSize.height);
        array[3] = CGPointMake(0, self.contentSize.height);
        
        ccDrawPoly(array, 4, YES);
    }
}

@end

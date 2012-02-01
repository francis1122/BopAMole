//
//  Heart.m
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/31/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import "Heart.h"
#import "cocos2d.h"

@implementation Heart

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drop {
    CCRotateBy* rotate1 = [CCRotateBy actionWithDuration:0.1 angle:25];
    CCRotateBy* rotate1Rev = [CCRotateBy actionWithDuration:0.1 angle:-25];
    
    
    CCSequence* seq = [CCSequence actions:rotate1, rotate1Rev, 
                       rotate1Rev, rotate1, 
                       /*[CCMoveBy actionWithDuration:0.5 position:CGPointMake(0, -100)],*/
                       [CCFadeOut actionWithDuration:0.5],
                       nil];
    [self runAction:seq];
    
}

- (void)draw {
    [super draw];
    //if(self.position.y < -75) {
    if(self.opacity < 5) {
        [self removeFromParentAndCleanup:YES];
    }
}

@end

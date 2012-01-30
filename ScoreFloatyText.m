//
//  ScoreFloatyText.m
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/30/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import "ScoreFloatyText.h"
#import "cocos2d.h"

@implementation ScoreFloatyText

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)startFloat {
    CCMoveBy* action = [CCMoveBy actionWithDuration:0.5 position:CGPointMake(0, 25)];
    CCEaseIn* easeIn = [CCEaseIn actionWithAction:action rate:0.5f];
    [self runAction:easeIn];
    [self runAction:[CCFadeOut actionWithDuration:0.5]];
}

- (void)draw {
    [super draw];
    if(self.opacity < 5) {
        [self removeFromParentAndCleanup:YES];
    }
}

@end

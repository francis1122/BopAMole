//
//  LifeContainer.m
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/31/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import "LifeContainer.h"
#import "cocos2d.h"
#import "Heart.h"

#define MAX_HEALTH 3

@implementation LifeContainer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) resetHealth{
    for(int x = 1; x <= MAX_HEALTH; ++x) {
        Heart* heart = [[Heart alloc] initWithFile:@"HeartFlattened.png"];
        [self addChild:heart z:0 tag:x];
        heart.position = CGPointMake(-(heart.contentSize.width)*(x-1), 0);
    }
}

- (void)reduceHealthTo:(int)health {
    for(int i = health+1; i <= MAX_HEALTH; ++i) {
        Heart* heart = (Heart*)[self getChildByTag:i];
        if(heart) {
            [heart drop];
        }
    }
}

@end

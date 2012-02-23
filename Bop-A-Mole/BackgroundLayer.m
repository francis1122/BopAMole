//
//  BackgroundLayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer

-(id)init{
    if( (self=[super init])) {
    
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"whackamoleBG.png"];
        CGSize s = [CCDirector sharedDirector].winSize;
        
        [backgroundSprite setPosition:ccp(s.width/2, s.height/2)];
        
        [self addChild:backgroundSprite];        
    }
    return self;
}


@end

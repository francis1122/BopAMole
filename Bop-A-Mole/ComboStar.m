//
//  ComboStar.m
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/30/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import "ComboStar.h"
#import "cocos2d.h"

@implementation ComboStar

@synthesize velocity;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setupComboStar {
    velocity = CGPointMake(-1, 2);
    gravity = CGPointMake(0, 0.1);
    [self runAction:[CCFadeOut actionWithDuration:0.5]];
}

- (void)draw{
    if(self.opacity < 5) {
        [self removeFromParentAndCleanup:YES];
    }
    else {
        [super draw];
        velocity = CGPointMake(velocity.x - gravity.x, velocity.y - gravity.y);
        self.position = CGPointMake(self.position.x + velocity.x, self.position.y + velocity.y);
    }
    
}



@end

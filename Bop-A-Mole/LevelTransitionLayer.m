//
//  LevelTransitionLayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelTransitionLayer.h"
#import "Constants.h"
#import "GameScene.h"


@implementation LevelTransitionLayer

@synthesize transitionLabel;

-(id)init{
    if(self = [super init]){
        //pause label 
        self.transitionLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"level:%d complete", [[GameScene sharedScene] level]] fontName:kFont1 fontSize:20];
        transitionLabel.position = ccp(200, 260);
        ccColor3B yellow = {224, 225, 0};
        [transitionLabel setColor:yellow];
        [self addChild:transitionLabel];
        
        
        transitionTime = 0.0;

    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    transitionTime += dt;

    if(transitionTime > 5.5){
        transitionTime = 0.0f;
        [[GameScene sharedScene] startNextLevel];
    }
}

@end

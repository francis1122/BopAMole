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
#import "Moles.h"


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
    [self createTutorialMole:[[GameScene sharedScene] level]];
    if(transitionTime > kLevelTransitionTime){
        transitionTime = 0.0f;
       [[GameScene sharedScene] transitionFromLevelTransitionStateToGamePlayState];
    }
}

-(void)createTutorialMole:(NSInteger)level{
    if (level == 2) {
        [[GameScene sharedScene] setIsTutorialMode:YES];
        SingleTapMole* singleTapMole = [[SingleTapMole alloc] initSingleTapMole];
        singleTapMole.isTutorial = YES;
        singleTapMole.enteringBeatSpan = 0.0;
        [singleTapMole setPosition:CGPointMake(480/2, 320/2)];
        [[[[GameScene sharedScene] gameLayer] moleArray] addObject:singleTapMole];
        [[GameScene sharedScene] addChild:singleTapMole];
        [singleTapMole onSpawn];
    }

}

@end

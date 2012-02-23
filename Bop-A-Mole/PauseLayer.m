//
//  PauseLayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "GameScene.h"
#import "Constants.h"


@implementation PauseLayer


-(id)init{
    if(self = [super init]){
        //pause label
        pauseLabel = [CCLabelTTF labelWithString:@"PAUSE" fontName:kFont1 fontSize:20];
        pauseLabel.position = ccp(200, 260);
        ccColor3B yellow = {224, 225, 0};
        [pauseLabel setColor:yellow];
        [self addChild:pauseLabel];

        
        //pause button
        CCSprite *resumeButtonSprite = [CCSprite spriteWithFile:@"ResumeButton.png"];
        
        CCMenuItemSprite *resumeButton = [CCMenuItemSprite itemFromNormalSprite:resumeButtonSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(resumeButtonTouched:)];
        resumeButton.position = ccp(200, 100);

        CCMenu *menu = [CCMenu menuWithItems:resumeButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
    }
    return self;
}

-(void)resumeButtonTouched:(CCMenuItem*)sender{
    [[GameScene sharedScene] transitionFromPauseStateToGamePlayState];
}

@end

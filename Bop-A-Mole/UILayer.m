//
//  UILayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"
#import "GameScene.h"
#import "Constants.h"


@implementation UILayer

@synthesize pauseButton, scoreLabel, comboLabel, lifeLabel;

-(id)init{
    if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        
        //score label
        self.scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:kFont1 fontSize:20];
        self.scoreLabel.position = ccp(400, 300);
        ccColor3B yellow = {224, 225, 0};
        [self.scoreLabel setColor:yellow];
        [self addChild:self.scoreLabel];
        
        self.comboLabel = [CCLabelTTF labelWithString:@"1x" fontName:kFont1 fontSize:20];
        self.comboLabel.position = ccp(400, 270);
        [self.comboLabel setColor:yellow];
        [self addChild:self.comboLabel];
        
        self.lifeLabel = [CCLabelTTF labelWithString:@"Lives:3" fontName:kFont1 fontSize:20];
        self.lifeLabel.position = ccp(39,30);
        [self addChild:self.lifeLabel];
        
        //pause button
        CCSprite *sprite10 = [CCSprite spriteWithFile:@"PauseButton.png"];
        CCSprite *sprite11 = [CCSprite spriteWithFile:@"PauseButton.png"];
        CCSprite *sprite12 = [CCSprite spriteWithFile:@"PauseButton.png"];
        CCMenuItemSprite *raceBeginButton = [CCMenuItemSprite itemFromNormalSprite:sprite10 selectedSprite:sprite11 disabledSprite:sprite12 target:self selector:@selector(pauseButtonTouched:)];
        raceBeginButton.position = ccp(20, 300);
        raceBeginButton.tag = 0;
        
        
        
        self.pauseButton = [CCMenu menuWithItems:raceBeginButton,  nil];
        self.pauseButton.position = CGPointZero;
        
        
        [self addChild:self.pauseButton];
        
        
        
    }
    return self;
}


-(void)pauseButtonTouched:(CCMenuItem*)sender{
    GameScene *scene = [GameScene sharedScene];
    if(scene.isGamePaused){
        //shoudn't get called ever
        [scene unPauseGame];
    }else{
        [scene pauseGame];
    }
}

@end

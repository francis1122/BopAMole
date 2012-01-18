//
//  GameOverLayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameScene.h"
#import "Constants.h"

@implementation GameOverLayer


-(id) initWithScore:(NSInteger) score{
    if(self = [super init]){
        
        CCLabelTTF* greatest = [CCLabelTTF labelWithString:@"GameOver" fontName:kFont1 fontSize:20];
        greatest.position = ccp(280, 249);
        ccColor3B green = {154, 255, 56};
        [greatest setColor:green];
        [self addChild:greatest];
        
        
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"score:%d",score] fontName:kFont1 fontSize:16];
        scoreLabel.position = ccp(280, 160);
        ccColor3B yellow = {255, 255, 0};
        [scoreLabel setColor:yellow];
        [self addChild:scoreLabel];
        
        
        //create button that takes you to the game
        CCSprite *sprite = [CCSprite spriteWithFile:@"PlayButton.png"];

        
        CCMenuItemSprite *retryButtin = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(retryButtonTouched:)];
        retryButtin.position = ccp(220, 100);
        
        CCMenu *menu = [CCMenu menuWithItems:retryButtin, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
    }
    return self;
}

-(void)retryButtonTouched:(CCMenuItem*)sender{
    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
}

@end

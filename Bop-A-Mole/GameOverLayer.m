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
#import "MasterDataModelController.h"

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
        
        CCSprite *sprite4 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite5 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite6 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCMenuItemSprite *leaderboardButton = [CCMenuItemSprite itemFromNormalSprite:sprite4 selectedSprite:sprite5 disabledSprite:sprite6 target:self selector:@selector(leaderboardButtonTouched:)];
        leaderboardButton.position = ccp(220, 200);
        
        CCMenu *menu = [CCMenu menuWithItems:retryButtin, leaderboardButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
    }
    return self;
}

-(void)retryButtonTouched:(CCMenuItem*)sender{
    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
}

-(void)leaderboardButtonTouched:(CCMenuItem*)sender{
    [[MasterDataModelController sharedInstance] showLeaderboard];
}

@end

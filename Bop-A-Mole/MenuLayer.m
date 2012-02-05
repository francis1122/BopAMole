//
//  MenuLayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "Constants.h"
#import "GameScene.h"
#import "MasterDataModelController.h"

@implementation MenuLayer
    

-(id)init{
    if( self = [super init] ){
        CCLabelTTF* greatest = [CCLabelTTF labelWithString:@"Bop-A-Mole" fontName:kFont1 fontSize:20];
        greatest.position = ccp(280, 249);
        ccColor3B green = {154, 255, 56};
        [greatest setColor:green];
        [self addChild:greatest];
        
        
        
        
        
        //create button that takes you to the game
        CCSprite *sprite = [CCSprite spriteWithFile:@"PlayButton.png"];
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"PlayButton.png"];

        
        CCSprite *sprite4 = [CCSprite spriteWithFile:@"Icon-72.png"];
        
        CCMenuItemSprite *spriteTimeTrailButton = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(playButtonTouched:)];
        spriteTimeTrailButton.position = ccp(220, 140);
        
        CCMenuItemSprite *spriteSettingsButton = [CCMenuItemSprite itemFromNormalSprite:sprite2 selectedSprite:nil target:self selector:@selector(settingsButtonTouched:)];
        spriteSettingsButton.position = ccp(220, 70);
        
        CCMenuItemSprite *leaderboardButton = [CCMenuItemSprite itemFromNormalSprite:sprite4 selectedSprite:nil disabledSprite:nil target:self selector:@selector(leaderboardButtonTouched:)];
        leaderboardButton.position = ccp(40, 40);
        
        CCMenu *menu = [CCMenu menuWithItems:spriteTimeTrailButton, spriteSettingsButton, leaderboardButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
  
    }
    return self;
}

-(void)playButtonTouched:(CCMenuItem*)sender{
    [[GameScene sharedScene] transitionFromMainMenuStateToGamePlayState];
//    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
}

-(void)settingsButtonTouched:(CCMenuItem*)sender{
    [[GameScene sharedScene] transitionFromMainMenuStateToSettingsMenuState];
}

-(void)leaderboardButtonTouched:(CCMenuItem*)sender{
    [[MasterDataModelController sharedInstance] showLeaderboard];
}


@end

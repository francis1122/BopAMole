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
        CCSprite *sprite3 = [CCSprite spriteWithFile:@"PlayButton.png"];
        
        CCMenuItemSprite *spriteTimeTrailButton = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:sprite2 disabledSprite:sprite3 target:self selector:@selector(playButtonTouched:)];
        spriteTimeTrailButton.position = ccp(220, 140);
        
        CCMenu *menu = [CCMenu menuWithItems:spriteTimeTrailButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
        
        
        
        
    }
    return self;
}

-(void)playButtonTouched:(CCMenuItem*)sender{
    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
}


@end

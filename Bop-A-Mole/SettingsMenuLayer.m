//
//  SettingsMenu.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsMenuLayer.h"
#import "GameScene.h"
#import "CCSliderControl.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"


@implementation SettingsMenuLayer
@synthesize slider;

-(id)init{
    if( self = [super init] ){
        CCLabelTTF* greatest = [CCLabelTTF labelWithString:@"Settings" fontName:kFont1 fontSize:20];
        greatest.position = ccp(280, 300);
        ccColor3B green = {154, 255, 56};
        [greatest setColor:green];
        [self addChild:greatest];
        
        //create button that takes you to the game
        CCSprite *sprite = [CCSprite spriteWithFile:@"PlayButton.png"];
        
        
        CCMenuItemSprite *spriteTimeTrailButton = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(menuButtonTouched:)];
        spriteTimeTrailButton.position = ccp(220, 40);
        
        
        
        
        CCSprite *sliderBar = [CCSprite spriteWithFile:@"SliderBG.png"];
        CCSprite *sliderScale = [CCSprite spriteWithFile:@"Icon-72.png"];
        
        
//        CGSize s = [CCDirector sharedDirector].winSize;
        
        self.slider = [[[CCSliderControl alloc] init] autorelease];
        [self.slider setWithSprite:sliderBar slider:sliderScale];
        self.slider.position = CGPointMake(40, 180);
        self.slider.value = 0.5;
        self.slider.delegate = self;
        [self addChild:self.slider z:0 tag:2];
        
        
        
        
        
        CCMenu *menu = [CCMenu menuWithItems:spriteTimeTrailButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
    }
    return self;
}

-(void)menuButtonTouched:(CCMenuItem*)sender{
    [[GameScene sharedScene] transitionFromSettingsMenuStateToMainMenuState];
    //[[GameScene sharedScene] transitionFromMainMenuStateToGamePlayState];
    //    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
}

- (void) valueChanged: (float) value tag: (int) tag{
//    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"CRevell_Mole_Game.mp3"];   
    [SimpleAudioEngine sharedEngine].backgroundMusicVolume = value;
}


@end

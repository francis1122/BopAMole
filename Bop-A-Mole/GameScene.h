//
//  GameScene.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer, UILayer;
@interface GameScene : CCScene {
    
    GameLayer *gameLayer;
    UILayer *uiLayer;
    
    NSInteger combo;
    NSInteger score;
    NSInteger playerLife;
    
    float gameTime;
    BOOL isGamePaused;
}

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) UILayer *uiLayer;
@property (nonatomic) NSInteger combo;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger playerLife;
@property (nonatomic) BOOL isGamePaused;
@property (nonatomic) float gameTime;

+(GameScene*) sharedScene;

-(void) gameLoop:(ccTime) dt;

-(void) addToScore:(NSInteger)points;
-(void) addToCombo:(NSInteger)points;
-(void) playerGotHurt;
    
-(void) pauseGame;
-(void) unPauseGame;

@end

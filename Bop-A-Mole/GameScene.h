//
//  GameScene.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


typedef enum {
    PauseState,
    GamePlayState,
    GameOverState,
    MainMenuState,
    LevelTransitionState,
    SettingsMenuState
} GameState;

@class GameLayer, UILayer, PauseLayer, LevelTransitionLayer, MenuLayer, GameOverLayer, SettingsMenuLayer, BackgroundLayer;
@interface GameScene : CCScene {
    
    GameState gameState;
    
    
    //Layers of the game
    MenuLayer *menuLayer;
    GameOverLayer *gameOverLayer;
    GameLayer *gameLayer;
    UILayer *uiLayer;
    PauseLayer *pauseLayer;
    LevelTransitionLayer *levelTransitionLayer;
    SettingsMenuLayer *settingsMenuLayer;
    BackgroundLayer *backgroundLayer;
    
    
    NSInteger combo;
    NSInteger score;        
    NSInteger playerLife;   
    
    NSInteger level;
    NSInteger realLevel;
    float timeOnCurrentLevel;
    float levelLength;
    float BPM;
    
    float gameTime;
    BOOL isGameOver;        
    BOOL isGamePaused; 
    BOOL isBetweenLevels;
}

@property (nonatomic, retain) MenuLayer *menuLayer;
@property (nonatomic, retain) GameOverLayer *gameOverLayer;
@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) UILayer *uiLayer;
@property (nonatomic, retain) PauseLayer *pauseLayer;
@property (nonatomic, retain) LevelTransitionLayer *levelTransitionLayer; 
@property (nonatomic, retain) SettingsMenuLayer *settingsMenuLayer;
@property (nonatomic, retain) BackgroundLayer *backgroundLayer;
@property (nonatomic) NSInteger combo;  //players current combo

@property (nonatomic) NSInteger score;  //players current score
@property (nonatomic) NSInteger playerLife;   //how many times the player can get hit before they lose the game
@property (nonatomic) BOOL isGamePaused;  //has the player lost yet?
@property (nonatomic) BOOL isGameOver;  //is the game paused?
@property (nonatomic) float gameTime; //how long the game has been going for

@property (nonatomic) BOOL isBetweenLevels; //is the gamestate between levels
@property (nonatomic) NSInteger level; //what level the player is on
@property (nonatomic) float timeOnCurrentLevel; //how long the game has been on current level
@property (nonatomic) float levelLength; //how long the level is
@property (nonatomic) float BPM; //the level's BPM


+(GameScene*) sharedScene;



-(void) gameLoop:(ccTime) dt;

//add points to current score
-(void) addToScore:(NSInteger)points;

//add points to current score, do a pop-up
-(void) addToScore:(NSInteger)points withDisplayPoint:(CGPoint)displayPt;


//add combo
-(void) addToCombo:(NSInteger)points;

//add combo, do a pop-up
-(void) addToCombo:(NSInteger)points withDisplayPoint:(CGPoint)displayPt;

//player was damaged by a mole and will lose 1 life and any combo they have going
-(void) playerGotHurt;

//begins transition to next level
-(void) nextLevel;    

-(void) moveToNextLevel;

-(void) startNextLevel;

-(void) cleanGameState;

#pragma transitions
-(void) transitionFromGamePlayStateToPauseState;
-(void) transitionFromPauseStateToGamePlayState;
-(void) transitionFromGamePlayStateToGameOverState;
-(void) transitionFromMainMenuStateToGamePlayState;
-(void) transitionFromGameOverStateToGamePlayState;
-(void) transitionFromGameOverStateToMainMenuState;
-(void) transitionFromMainMenuStateToSettingsMenuState;
-(void) transitionFromSettingsMenuStateToMainMenuState;

@end

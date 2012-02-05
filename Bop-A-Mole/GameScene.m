//
//  GameScene.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "UILayer.h"
#import "MenuLayer.h"
#import "GameOverLayer.h"
#import "PauseLayer.h"
#import "LevelTransitionLayer.h"
#import "SettingsMenuLayer.h"
#import "BackgroundLayer.h"

#import "MasterDataModelController.h"
#import "SimpleAudioEngine.h"
#import "ScoreFloatyText.h"
#import "ComboStar.h"
#import "MoleSpawner.h"
#import "LifeContainer.h"

static GameScene *sharedScene = nil;

@implementation GameScene

@synthesize uiLayer, gameLayer, combo, score, isGamePaused, gameTime, playerLife, isGameOver, pauseLayer, level, levelLength, isBetweenLevels, timeOnCurrentLevel, levelTransitionLayer, gameOverLayer, menuLayer, settingsMenuLayer, backgroundLayer;

+(GameScene*) sharedScene{
    NSAssert(sharedScene != nil, @"sharedScene not available!");
    return sharedScene;
}

-(id) init{
	
	if( (self=[super init])) {
        sharedScene = self;
        gameState = MainMenuState;
        self.score = 0;
        self.combo = 1;
        self.level = 1;
        realLevel = 1;
        self.isBetweenLevels = NO;
        self.timeOnCurrentLevel = 0.0f;
        self.gameTime = 0.0f;
        self.playerLife = 3;
        self.levelLength = -1.0f;
        self.isGameOver = NO;
        
        //setup layers of the game
        self.menuLayer = [MenuLayer node];
        self.gameOverLayer = [GameOverLayer node];
        self.gameLayer = [GameLayer node];
        self.uiLayer = [UILayer node];
        self.pauseLayer = [PauseLayer node];
        self.levelTransitionLayer = [LevelTransitionLayer node];
        self.settingsMenuLayer = [SettingsMenuLayer node];
        self.backgroundLayer = [BackgroundLayer node];
  
        [self addChild:self.backgroundLayer z:-1];
        [self addChild:self.menuLayer];
        
		[self schedule: @selector(gameLoop:)];
    }
	return self;
}

-(void)dealloc{
    [super dealloc];
    sharedScene = nil;
}



-(void) gameLoop:(ccTime) dt{
    
    //GamePlayState
    if(!self.isGamePaused && !self.isBetweenLevels && gameState == GamePlayState){
        
        if(isGameOver){
            [self transitionFromGamePlayStateToGameOverState];
        }
        
        self.timeOnCurrentLevel += dt;
        self.gameTime += dt;
        
        if(self.gameLayer){
            [self.gameLayer gameLoop:dt];
        }
        
    }
    
    //LevelTransitionState
    if(self.isBetweenLevels && gameState == LevelTransitionState){
        [self.levelTransitionLayer gameLoop:dt];
    }
    
    //update UI
    if(self.uiLayer && (gameState == LevelTransitionState || gameState == GamePlayState || gameState == PauseState)){
        [self.uiLayer gameLoop:dt];
    }
}

-(float)levelLength {
    if(levelLength == -1.0) { // Level length hasn't been set yet
        levelLength = [[[[[MoleSpawner sharedInstance] levelData] objectForKey:
                         [NSString stringWithFormat:@"%d",realLevel]] 
                        valueForKey:@"Length"] floatValue];
    }
    return levelLength;
}

- (float)BPM {
    return 130;
}

-(void) setScore:(NSInteger)_score{
    if(self.uiLayer){
        [self.uiLayer.scoreLabel setString:[NSString stringWithFormat:@"%d", _score]];
    }
    score = _score;
}

-(void) addToCombo:(NSInteger)points withDisplayPoint:(CGPoint)displayPt {
    [self addToCombo:points];
    
    // draw star
    ComboStar* comboStar = [[ComboStar alloc] initWithFile:@"Star.png"];
    [comboStar setupComboStar];
    comboStar.position = displayPt;
    [self addChild:comboStar z:100];
    
    // setup second star going opposite direction
    comboStar = [[ComboStar alloc] initWithFile:@"Star.png"];
    [comboStar setupComboStar];
    comboStar.velocity = CGPointMake(-comboStar.velocity.x, comboStar.velocity.y);
    comboStar.position = displayPt;
    [self addChild:comboStar z:100];
}

-(void) setCombo:(NSInteger)_combo{
    if(self.uiLayer){
        [self.uiLayer.comboLabel setString:[NSString stringWithFormat:@"%dx", _combo]];
    }
    combo = _combo;
}

-(void) addToScore:(NSInteger)points{
    self.score += points * combo;
}

-(void) addToScore:(NSInteger)points withDisplayPoint:(CGPoint)displayPt {
    [self addToScore:points];
    int totalPoints = points*combo;
    int fontSizeIncrease = 2*(totalPoints/500);
    
    ccColor3B color = ccWHITE;
    
    if(totalPoints > 500) {
        color = ccYELLOW;
    }
    else if(totalPoints > 1000) {
        color = ccRED;
    }
    else if(totalPoints > 2000) {
        color = ccMAGENTA;
    }
    
    ScoreFloatyText* label = [ScoreFloatyText labelWithString:[NSString stringWithFormat:@"+%d",points*combo] fontName:@"Nonstopitalic.ttf" fontSize:20.0 + fontSizeIncrease];
    [label setColor:color];
    [self addChild:label z:100];
    label.position = CGPointMake(displayPt.x, displayPt.y);
    [label startFloat];
}

-(void) addToCombo:(NSInteger)points{
    self.combo += points;
}

-(void) playerGotHurt{
    self.playerLife--;
    if(self.uiLayer){
        [self.uiLayer.life reduceHealthTo:self.playerLife];
    }
    self.combo = 1;
}

-(void) setPlayerLife:(NSInteger)_playerLife{
    playerLife = _playerLife;
    if(playerLife <= 0){
        self.isGameOver = YES;
    }
}



-(void) cleanGameState{
    self.isGamePaused = NO;
    self.isGameOver = NO;
    self.score = 0;
    self.combo = 1;
    self.level = 1;
    realLevel = 1;
    self.isBetweenLevels = NO;
    self.timeOnCurrentLevel = 0.0f;
    self.gameTime = 0.0f;
    self.playerLife = 3;
    self.levelLength = -1.0f;

}

#pragma mark - Transitions

-(void)transitionFromGamePlayStateToLevelTransitionState{
    gameState = LevelTransitionState;
    self.isBetweenLevels = YES;
    self.level++;
    self.timeOnCurrentLevel = 0.0f;
    [self.levelTransitionLayer.transitionLabel setString:[NSString stringWithFormat:@"level:%d", level]];

    NSArray* levelData = [[MoleSpawner sharedInstance] generateLevel:[NSString stringWithFormat:@"%d",level] withBPM:130];
    int levelToGrab = self.level;
    while(levelData == nil) {
        levelData = [[MoleSpawner sharedInstance] generateLevel:[NSString stringWithFormat:@"%d",levelToGrab--] withBPM:130];
    }
    
    realLevel = levelToGrab;
    
    self.levelLength = [[[[[MoleSpawner sharedInstance] levelData] objectForKey:
                          [NSString stringWithFormat:@"%d",realLevel]] 
                         valueForKey:@"Length"] floatValue];
    
    self.gameLayer.level = [[NSMutableArray alloc] initWithArray:levelData];
    [self removeChild:self.gameLayer cleanup:NO];
    [self addChild: self.levelTransitionLayer];
}

-(void)transitionFromLevelTransitionStateToGamePlayState{
    gameState = GamePlayState;
    self.isBetweenLevels = NO;
    self.timeOnCurrentLevel = 0.0f;
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"CRevell_Mole_Game.mp3"];    
    [self removeChild:self.levelTransitionLayer cleanup:NO];
    [self addChild: self.gameLayer];
}

-(void) transitionFromGamePlayStateToPauseState{
    gameState = PauseState;
    self.isGamePaused = YES;
    self.gameLayer.isTouchEnabled = NO;
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [self addChild:self.pauseLayer];
}

-(void) transitionFromPauseStateToGamePlayState{
    if(self.isBetweenLevels){
        gameState = LevelTransitionState;
    }else{
        gameState = GamePlayState;
    }

    self.isGamePaused = NO;
    self.gameLayer.isTouchEnabled = YES;
    
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    [self removeChild:self.pauseLayer cleanup:NO];
}

-(void) transitionFromGamePlayStateToGameOverState{
    gameState = GameOverState;
    [self.gameOverLayer setScore:self.score];
    [[MasterDataModelController sharedInstance] trackScore:score];
    [[MasterDataModelController sharedInstance] submitScore:score];
    [self removeChild:self.uiLayer cleanup:NO];
    [self removeChild:self.gameLayer cleanup:NO];
    [self addChild:self.gameOverLayer];
}

-(void)transitionFromMainMenuStateToGamePlayState{
    gameState = GamePlayState;
    [self cleanGameState];
    [self.gameLayer cleanGameLayer];
    [self.uiLayer cleanUILayer];
    [self removeChild:self.menuLayer cleanup:NO];
    [self addChild:self.gameLayer];
    [self addChild:self.uiLayer z:10];
}

-(void)transitionFromGameOverStateToGamePlayState{
    gameState = GamePlayState;
    [self cleanGameState];
    [self.gameLayer cleanGameLayer];
    [self.uiLayer cleanUILayer];
    [self removeChild:self.gameOverLayer cleanup:NO];
    [self addChild:self.gameLayer];
    [self addChild:self.uiLayer z: 10];
}

-(void)transitionFromGameOverStateToMainMenuState{
    gameState = MainMenuState;
    [self removeChild:self.gameOverLayer cleanup:NO];
    [self addChild:self.menuLayer];
}

-(void)transitionFromMainMenuStateToSettingsMenuState{
    gameState = SettingsMenuState;
    [self removeChild:self.menuLayer cleanup:NO];
    [self addChild:self.settingsMenuLayer];
}

-(void) transitionFromSettingsMenuStateToMainMenuState{
    gameState = MainMenuState;
    [self removeChild:self.settingsMenuLayer cleanup:NO];
    [self addChild:self.menuLayer];
}



@end

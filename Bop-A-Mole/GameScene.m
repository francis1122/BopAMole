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
#import "MasterDataModelController.h"
#import "SimpleAudioEngine.h"
#import "ScoreFloatyText.h"
#import "ComboStar.h"
#import "MoleSpawner.h"

static GameScene *sharedScene = nil;

@implementation GameScene

@synthesize uiLayer, gameLayer, combo, score, isGamePaused, gameTime, playerLife, isGameOver, pauseLayer, level, levelLength, isBetweenLevels, timeOnCurrentLevel, levelTransitionLayer;

+(GameScene*) sharedScene{
    NSAssert(sharedScene != nil, @"sharedScene not available!");
    return sharedScene;
}

-(id) init{
	
	if( (self=[super init])) {
        sharedScene = self;
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
        self.gameLayer = [GameLayer node];
        self.uiLayer = [UILayer node];
        self.pauseLayer = [PauseLayer node];
        self.levelTransitionLayer = [LevelTransitionLayer node];
        
        [self addChild:self.gameLayer];
        [self addChild:self.uiLayer];

		[self schedule: @selector(gameLoop:)];
    }
	return self;
}

-(void)dealloc{
    [super dealloc];
    sharedScene = nil;
}



-(void) gameLoop:(ccTime) dt{
    if(isGameOver){
        [self transitionToGameOverLayer];
        [[MasterDataModelController sharedInstance] trackScore:score];
        [[MasterDataModelController sharedInstance] submitScore:score];
    }
    if(!self.isGamePaused && !self.isBetweenLevels){
        
        self.timeOnCurrentLevel += dt;
        self.gameTime += dt;

        if(self.gameLayer){
            [self.gameLayer gameLoop:dt];
        }

    }
    if(self.isBetweenLevels){
        [self.levelTransitionLayer gameLoop:dt];
    }
    if(self.uiLayer){
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
    return 130.0;
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
        [self.uiLayer.lifeLabel setString:[NSString stringWithFormat:@"Lives:%d", self.playerLife]];
    }
    self.combo = 1;
}

-(void) setPlayerLife:(NSInteger)_playerLife{
    playerLife = _playerLife;
    if(playerLife <= 0){
        self.isGameOver = YES;
    }
}

-(void) moveToNextLevel{
    self.isBetweenLevels = YES;
    self.level++;
    self.timeOnCurrentLevel = 0.0f;
    [self.levelTransitionLayer.transitionLabel setString:[NSString stringWithFormat:@"level:%d", level]];
    [self addChild: self.levelTransitionLayer];
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
}

-(void) startNextLevel{
    self.isBetweenLevels = NO;
    self.timeOnCurrentLevel = 0.0f;
    [self removeChild:self.levelTransitionLayer cleanup:NO];    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"CRevell_Mole_Game.mp3"];    
}

#pragma mark - Transitions

-(void) transitionToGameOverLayer{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[[GameOverLayer alloc] initWithScore:self.score] autorelease] ];
}

-(void) transitionToMainMenu{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer node]];
}


#pragma mark - game state functions
-(void) pauseGame{
    self.isGamePaused = YES;
    self.gameLayer.isTouchEnabled = NO;
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [self addChild: self.pauseLayer];
}

-(void) unPauseGame{
    self.isGamePaused = NO;
    self.gameLayer.isTouchEnabled = YES;
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    
    [self removeChild:self.pauseLayer cleanup:NO];
}

@end

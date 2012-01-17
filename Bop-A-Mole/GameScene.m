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

static GameScene *sharedScene = nil;

@implementation GameScene

@synthesize uiLayer, gameLayer, combo, score, isGamePaused, gameTime, playerLife;

+(GameScene*) sharedScene{
    NSAssert(sharedScene != nil, @"sharedScene not available!");
    return sharedScene;
}

-(id) init{
	
	if( (self=[super init])) {
        sharedScene = self;
        self.score = 0;
        self.combo = 1;
        self.gameTime = 0.0f;
        self.playerLife = 3;
        
        //setup layers of the game
        self.gameLayer = [GameLayer node];
        self.uiLayer = [UILayer node];
        
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
    if(!self.isGamePaused){
        self.gameTime += dt;
        if(self.gameLayer){
            [self.gameLayer gameLoop:dt];
        }
    }
}

-(void) setScore:(NSInteger)_score{
    if(self.uiLayer){
         [self.uiLayer.scoreLabel setString:[NSString stringWithFormat:@"%d", _score]];
    }
    score = _score;
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

#pragma mark - Transitions

-(void) transitionToMainMenu{
    [[CCDirector sharedDirector] replaceScene:[MenuLayer node]];
}


#pragma mark - game state functions
-(void) pauseGame{
    self.isGamePaused = YES;

//    [self addChild: self.pauseLayer];
}

-(void) unPauseGame{
    self.isGamePaused = NO;
  //  [self removeChild:self.pauseLayer cleanup:NO];
}

@end

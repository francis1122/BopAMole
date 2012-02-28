//
//  QuickSlashMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "QuickSlashMole.h"
#import "GameScene.h"
#import "Constants.h"

@implementation QuickSlashMole

-(id) initWithQuickSlashMole{
    if(self = [super init]){
        self.beatLifeSpan = 3.0 + BEAT_WINDOW;
        
        ccColor3B yellow = {0, 225, 255};
        self.normalSprite.color = yellow;
        self.unburrowingSprite.color = yellow;
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
    
    //use for changing cri
    
}

-(void) beatUpdate:(float)beatDt{
    [super beatUpdate:beatDt];
    /*  if(self.criticalBeatTime < self.beatLifeTime && (self.criticalBeatTime + self.criticalBeatSpan) > self.beatLifeTime){
     ccColor3B yellow = {224, 225, 0};
     self.normalSprite.color = yellow;
     self.isCritical = YES;
     }else{
     self.normalSprite.color = ccBLUE;
     self.isCritical = NO;
     }*/
}

-(void)slashed{
    GameScene *gameScene = [GameScene sharedScene];
    if(self.moleState == EnteringState){
        return;
    }
    
    self.isDead = YES;

    //second update combo score
    if(self.isCritical){
        [gameScene addToCombo:1 withDisplayPoint:self.position];
    }else{
        [gameScene setCombo:1];
    }
    //first add points
    [gameScene addToScore:200 withDisplayPoint:self.position];
}

@end

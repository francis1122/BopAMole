//
//  JumpingMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "JumpingMole.h"
#import "GameScene.h"


@implementation JumpingMole

-(id) initJumpingMole{
    if(self = [super init]){
        //initWithFile:@"mole.png"]
        ccColor3B green = {0, 0, 255};
        //self.color = green;
        self.scale = 1.2;

    }
    return self;
}

-(void)onSpawn{
    [super onSpawn];
}

-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];

}

-(void) beatUpdate:(float)beatDt{
    [super beatUpdate:beatDt];
    if(self.criticalBeatTime < self.beatLifeTime && (self.criticalBeatTime + self.criticalBeatSpan) > self.beatLifeTime){
        ccColor3B yellow = {224, 225, 0};
        self.normalSprite.color = yellow;
        self.isCritical = YES;
    }else{
        self.normalSprite.color = ccGREEN;
        self.isCritical = NO;
    }
}

-(void)manageMoleStates{
    if(self.moleState == EnteringState && self.beatLifeTime > self.enteringBeatSpan){
        self.moleState = AboveGroundState;
        [self removeChild:self.unburrowingSprite cleanup:NO];
        [self addChild:self.normalSprite];
        CCMoveTo* move = [CCMoveTo actionWithDuration:1.05 position:ccp(self.position.x, self.position.y + 120)];
        CCMoveTo* moveRev = [CCMoveTo actionWithDuration:1.05 position:ccp(self.position.x, self.position.y)];
        
        
        CCSequence* seq = [CCSequence actions:move, moveRev,
                           nil];
        [self runAction:seq];
    }
}

-(void)slashed{
    if(self.moleState == EnteringState){
        return;
    }
    GameScene *gameScene = [GameScene sharedScene];
    
    self.isDead = YES;
    //first add points
    [gameScene addToScore:100];
    //second update combo score
    if(self.isCritical){
        [gameScene addToCombo:1];
    }else{
        [gameScene setCombo:1];
    }
}
@end

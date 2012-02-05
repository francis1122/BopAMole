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
    if(self = [super initWithFile:@"mole.png"]){
        ccColor3B green = {0, 0, 255};
        self.color = green;
        self.lifeTime = 0.0;
        self.lifeSpan = 2.1;
        self.criticalTime = .7;
        self.criticalSpan = 0.7;
        self.scale = 1.2;

    }
    return self;
}

-(void)onSpawn{
    [super onSpawn];
    CCMoveTo* move = [CCMoveTo actionWithDuration:1.05 position:ccp(self.position.x, self.position.y + 120)];
    CCMoveTo* moveRev = [CCMoveTo actionWithDuration:1.05 position:ccp(self.position.x, self.position.y)];
    
    
    CCSequence* seq = [CCSequence actions:move, moveRev,
                       nil];
    [self runAction:seq];
}

-(void)gameLoop:(ccTime)dt{
    //    [super gameLoop:dt];
    self.lifeTime += dt;// * (60.0/[[GameScene sharedScene] BPM]);
    if(self.lifeTime > self.lifeSpan){
        self.gotAway = YES;
    }
    
    //use for changing cri
    if(self.criticalTime < self.lifeTime && (self.criticalTime + self.criticalSpan) > self.lifeTime){
        ccColor3B yellow = {224, 225, 0};
        self.color = yellow;
        self.isCritical = YES;
    }else{
        self.color = ccGREEN;
        self.isCritical = NO;
    }
}

-(void)slashed{
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

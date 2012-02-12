//
//  SlashMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SlashMole.h"
#import "GameScene.h"


@implementation SlashMole

-(id) initSlashMole{
    if(self = [super init]){
        //initWithFile:@"mole.png"]
        ccColor3B green = {0, 0, 255};
        //self.color = green;
        self.scale = 1.2;
        
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
    
    //use for changing cri

}

-(void) beatUpdate:(float)beatDt{
    [super beatUpdate:beatDt];
    if(self.criticalBeatTime < self.beatLifeTime && (self.criticalBeatTime + self.criticalBeatSpan) > self.beatLifeTime){
        ccColor3B yellow = {224, 225, 0};
        self.normalSprite.color = yellow;
        self.isCritical = YES;
    }else{
        self.normalSprite.color = ccBLUE;
        self.isCritical = NO;
    }
}

-(void)slashed{
    GameScene *gameScene = [GameScene sharedScene];
    if(self.moleState == EnteringState){
        return;
    }

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

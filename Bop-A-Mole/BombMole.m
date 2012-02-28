//
//  BombMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BombMole.h"
#import "GameScene.h"
#import "Constants.h"

@implementation BombMole


-(id) initWithBombMole{
    if(self = [super init]){
        self.beatLifeSpan = 3.0 + BEAT_WINDOW;
        
        ccColor3B yellow = {255, 0, 0};
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
}


-(void)tapped{
    if(self.moleState == EnteringState){
        return;
    }
    GameScene *gameScene = [GameScene sharedScene];
    self.isDead = YES;
    
    [gameScene playerGotHurt];

}

-(void)slashed{
    GameScene *gameScene = [GameScene sharedScene];
    if(self.moleState == EnteringState){
        return;
    }
    
    self.isDead = YES;
    [gameScene playerGotHurt];

}

@end

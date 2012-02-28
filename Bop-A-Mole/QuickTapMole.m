//
//  QuickTapMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 2/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "QuickTapMole.h"
#import "GameScene.h"
#import "Constants.h"


@implementation QuickTapMole

-(id) initWithQuickTapMole{
    
    if(self = [super init]){
        //        initWithFile:@"mole.png"]
        self.beatLifeSpan = 3.0 + BEAT_WINDOW;
        ccColor3B yellow = {224, 0, 0};
        self.normalSprite.color = yellow;
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
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


    
    //first update combo score
    if(self.isCritical){
        [gameScene addToCombo:1 withDisplayPoint:self.position];
    }else{
        [gameScene setCombo:1];
    }
    //second update score
    [gameScene addToScore:200 withDisplayPoint:self.position];
    
}

@end



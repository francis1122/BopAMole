//
//  SingleTapMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleTapMole.h"
#import "GameScene.h"

@implementation SingleTapMole


-(id) initSingleTapMole{

    if(self = [super init]){
//        initWithFile:@"mole.png"]
        self.scale = 1.2;
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
    [gameScene addToScore:100 withDisplayPoint:self.position];

}

@end

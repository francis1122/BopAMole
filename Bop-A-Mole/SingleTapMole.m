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

    if(self = [super initWithFile:@"mole.png"]){
        self.lifeTime = 0.0;
        self.lifeSpan = 1.0;
        self.criticalTime = 0.25;
        self.criticalSpan = 0.25;
        self.scale = 1.2;
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
}

-(void)tapped{
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

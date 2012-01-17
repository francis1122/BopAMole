//
//  MultiTapMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiTapMole.h"
#import "GameScene.h"

@implementation MultiTapMole

@synthesize life, startingLife;

-(id) initMultiTapMole{
    if(self = [super initWithFile:@"mole.png"]){
        self.lifeTime = 0.0;
        self.lifeSpan = 3.0;
        self.criticalTime = 1.0;
        self.criticalSpan = 1.0;
        self.scale = 2;

        self.startingLife = 2;
        self.life = self.startingLife;
        
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
}

-(void)tapped{
    GameScene *gameScene = [GameScene sharedScene];
    self.life--;
    if(life <= 0){
        self.isDead = YES;
        [gameScene addToScore:500];
        if(self.isCritical){
            [gameScene addToCombo:1];
        }else{
            [gameScene setCombo:1];
        }
        return;
    }
    
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

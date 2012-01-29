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
    if(self = [super initWithFile:@"mole.png"]){
        ccColor3B green = {0, 0, 255};
        self.color = green;
        self.lifeTime = 0.0;
        self.lifeSpan = 3.0;
        self.criticalTime = 1.0;
        self.criticalSpan = 1.0;
        self.scale = 1.5;
        
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
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

//
//  MoleBaseClass.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoleBaseClass.h"
#import "GameScene.h"
#import "Constants.h"

@implementation MoleBaseClass

@synthesize gotAway, criticalBeatSpan, criticalBeatTime, isCritical, isDead, moleState, enteringBeatSpan;
@synthesize relativeX, relativeY, beatLifeTime, beatLifeSpan, unburrowingSprite, normalSprite;


-(id) init{
    if(self = [super init]){
        
        //set the hitbox for mole
        self.contentSize = CGSizeMake(40, 40);
        
        self.moleState = EnteringState;
        self.unburrowingSprite = [CCSprite spriteWithFile:@"Star.png"];
        self.unburrowingSprite.position = CGPointMake(self.contentSize.width/2, self.contentSize.height/2);
        self.normalSprite = [CCSprite spriteWithFile:@"mole.png"];
        self.normalSprite.position = CGPointMake(self.contentSize.width/2, self.contentSize.height/2);
        
        [self addChild:self.unburrowingSprite];
        self.enteringBeatSpan = 1.0 - BEAT_WINDOW;
        self.beatLifeSpan = 6.0 + BEAT_WINDOW;
        self.beatLifeTime = 0.0;
        self.criticalBeatTime = 2.0;
        self.criticalBeatSpan = 1.0;
        self.gotAway = NO;
        self.isCritical = NO;
        self.isDead = NO;
        

        
    }
    return self;
}

-(void)onSpawn{
    //CCScaleTo *shit = [CCScaleTo actionWithDuration:Game scale:1.5];
    //CCSequence* seq = [CCSequence actions:move, moveRev, nil];
   // [self runAction:seq];
}

-(void)gameLoop:(ccTime)dt{
    

}

-(void)beatUpdate:(float)beatDt{
    
    self.beatLifeTime += beatDt;
    
    [self manageMoleStates];
    
    if(self.beatLifeTime > self.beatLifeSpan){
        self.gotAway = YES;
    }
    
    float time = (float)floorf(self.beatLifeTime);
    float change = self.beatLifeTime - time;
    
    if(change < BEAT_WINDOW || change > (1.00-BEAT_WINDOW)){
        self.normalSprite.scale = 1.3;
        self.isCritical = YES;
    }else{
        self.normalSprite.scale = 1.0;
        self.isCritical = NO;
    }
    
    //use for changing cri
    /*if(self.criticalBeatTime < self.beatLifeTime && (self.criticalBeatTime + self.criticalBeatSpan) > self.beatLifeTime){
        ccColor3B yellow = {224, 225, 0};
        self.normalSprite.color = yellow;
        self.isCritical = YES;
    }else{
        self.normalSprite.color = ccWHITE;
        self.isCritical = NO;
    }*/
}

-(void)manageMoleStates{
    if(self.moleState == EnteringState && self.beatLifeTime > self.enteringBeatSpan){
        self.moleState = AboveGroundState;
        [self removeChild:self.unburrowingSprite cleanup:NO];
        [self addChild:self.normalSprite];
    }
}

-(void) draw{
    [super draw];
    if(DEBUGMODE){
        CGPoint array[4];
        array[0] = CGPointMake(0, 0);
        array[1] = CGPointMake(self.contentSize.width, 0);
        array[2] = CGPointMake(self.contentSize.width, self.contentSize.height);
        array[3] = CGPointMake(0, self.contentSize.height);
        
        ccDrawPoly(array, 4, YES);
    }
}
    
    

-(void)tapped{
    
}

-(void)slashed{
    
}

-(void)setPosition:(CGPoint)position {
    [super setPosition:position];
}

@end

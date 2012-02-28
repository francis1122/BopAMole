//
//  MoleBaseClass.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


typedef enum {
    EnteringState,
    AboveGroundState
} MoleState;

@interface MoleBaseClass : CCNode {
    
    MoleState moleState;
    
    CCSprite *unburrowingSprite;
    CCSprite *normalSprite;
    
    float enteringBeatSpan; //how many beats the mole takes to come up from the ground
    
    float beatLifeTime; //how many beats a mole has been alive
    float beatLifeSpan; //how many beats a mole stays alive
    
    BOOL gotAway; // did the mole escape
    BOOL isDead; //has the mole been destroyed
    BOOL isTutorial; //is the mole a tutrial mole
    
    float criticalBeatTime; //when the critical time starts
    float criticalBeatSpan; //how long the critical time lasts for
    BOOL isCritical; //the mole is in the critical timing window
    
    int relativeX;
    int relativeY;
}

@property (nonatomic) MoleState moleState;
@property (nonatomic) float  criticalBeatTime, criticalBeatSpan, beatLifeTime, beatLifeSpan, enteringBeatSpan;
@property (nonatomic) BOOL gotAway, isCritical, isDead, isTutorial;
@property (nonatomic, retain) CCSprite *unburrowingSprite, *normalSprite;
@property (nonatomic) int relativeX;
@property (nonatomic) int relativeY;

-(void)onSpawn;

-(void)gameLoop:(ccTime)dt;

-(void)beatUpdate:(float)beatDt;

-(void)manageMoleStates;

-(void)tapped;

-(void)slashed;

@end

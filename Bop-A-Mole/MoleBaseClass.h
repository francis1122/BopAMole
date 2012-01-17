//
//  MoleBaseClass.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MoleBaseClass : CCSprite {
    float lifeTime;  //how long the mole has been alive
    float lifeSpan;  //how long a mole stays above ground
    
    BOOL gotAway; // did the mole escape
    BOOL isDead; //has the mole been destroyed
    
    float criticalTime; //when the critical time starts
    float criticalSpan; //how long the critical time lasts for
    BOOL isCritical; //the mole is in the critical timing window
}

@property (nonatomic) float lifeTime;
@property (nonatomic) float lifeSpan, criticalTime, criticalSpan;
@property (nonatomic) BOOL gotAway, isCritical, isDead;

-(void)gameLoop:(ccTime)dt;

-(void)tapped;

@end

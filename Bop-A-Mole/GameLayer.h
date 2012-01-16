//
//  GameLayer.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//gameplay and player interaction with gameworld takes place on this layer

@class MoleBaseClass;
@interface GameLayer : CCLayer {
    NSMutableArray *moleArray;
    NSMutableArray *deadMolesArray;
}

@property (nonatomic, retain) NSMutableArray *moleArray, *deadMolesArray;


-(void)gameLoop:(ccTime)dt;

-(void)spawnMoles;

-(void)removeMoles;

-(void)removeMoleObject:(MoleBaseClass*) deadMole;

-(void)checkTapCollision:(CGPoint) touch;

@end

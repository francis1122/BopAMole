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
}

@property (nonatomic) float lifeTime;

-(void)gameLoop:(ccTime)dt;

@end

//
//  LevelTransitionLayer.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelTransitionLayer : CCLayer {
    float transitionTime;
    CCLabelTTF *transitionLabel;
}

@property (nonatomic, retain) CCLabelTTF *transitionLabel;

-(void)gameLoop:(ccTime)dt;

@end

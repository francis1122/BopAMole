//
//  UILayer.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//contains elements of the games interface such as pause button and score labels

@interface UILayer : CCLayer {
    CCLabelTTF *scoreLabel;
    CCLabelTTF *comboLabel;
    CCLabelTTF *lifeLabel;
    
    CCMenu *pauseButton;
    
    CCRibbon *ribbon;
}

@property (nonatomic, retain) CCRibbon *ribbon;
@property (nonatomic, retain) CCMenu *pauseButton;
@property (nonatomic, retain) CCLabelTTF *scoreLabel;
@property (nonatomic, retain) CCLabelTTF *comboLabel;
@property (nonatomic, retain) CCLabelTTF *lifeLabel;

-(void)pauseButtonTouched:(CCMenuItem*)sender;

-(void)gameLoop:(ccTime) dt;

@end

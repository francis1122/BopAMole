//
//  SettingsMenu.h
//  Bop-A-Mole
//
//  Created by John Wilson on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSliderControl.h"


@class CCSliderControl;

@interface SettingsMenuLayer : CCLayer <CCSliderControlDelegate> {

    CCSliderControl *slider;
}

@property (nonatomic, retain) CCSliderControl *slider;

-(void)menuButtonTouched:(CCMenuItem*)sender;

- (void) valueChanged: (float) value tag: (int) tag;

@end

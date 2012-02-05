//
//  CCSliderControl.h
//  AmericanTomato
//
//  Created by iroth on 1/5/11.
//  Copyright 2011 iRoth.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol CCSliderControlDelegate

- (void) valueChanged: (float) value tag: (int) tag;

@end

@interface CCSliderControl : CCLayer {
	float value;
	id<CCSliderControlDelegate> delegate;
	float minX;
	float maxX;
}

@property (nonatomic, assign) float value;
@property (nonatomic, retain) id<CCSliderControlDelegate> delegate;

-(void)setWithSprite:(CCSprite *)sliderBar slider:(CCSprite *)slider;

@end
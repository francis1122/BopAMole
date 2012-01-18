//
//  GameOverLayer.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayer {
    CCLabelTTF *gameOverLabel;
    CCLabelTTF *scoreLabel;

}

-(id) initWithScore:(NSInteger) score;

@end

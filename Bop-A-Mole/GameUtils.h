//
//  GameUtils.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameUtils : NSObject

+(void) animateSprite:(CCSprite*)thisSprite withNumFrames:(int)frames called:(NSString*)frameName withDuration:(float)dur repeatForever:(BOOL)repeat;
/* Helper class to set up animation
 * @thisSprite	The sprite to be animated
 * @frames		the number of frames
 * @frameName	the name of the animation png, minus the last 3 digits and .png
 * @dur			the length of time the animation lasts
 * @repeat		whether or not the animation should repeat forever
 */

@end

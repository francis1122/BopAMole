/**
 * Description of method.
 * @param  paramName Description.
 * @param  paramName Description.
 *
 * @return  Description of returned variable.
 */
//
//  GameUtils.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameUtils.h"

@implementation GameUtils

+(void) animateSprite:(CCSprite*)thisSprite withNumFrames:(int)frames called:(NSString*)frameName withDuration:(float)dur repeatForever:(BOOL)repeat {
	/* Helper class to set up animation
	 * @thisSprite	The sprite to be animated
	 * @frames		the number of frames
	 * @frameName	the name of the animation png, minus the last 3 digits and .png
	 * @dur			the length of time the animation lasts
	 * @repeat		whether or not the animation should repeat forever
	 */
	NSMutableArray *animFrames = [NSMutableArray array];
	
	for (int j=0; j<frames; j++) {	
		CCSpriteFrame *frameTemp = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%03d.png",frameName,j]];
		[animFrames addObject:frameTemp];
	}
	
	CCAnimation *mjAnimation = [[CCAnimation animation] initWithFrames:animFrames];
	
	id mjAnimate = [CCAnimate actionWithDuration:dur animation:mjAnimation restoreOriginalFrame:FALSE];
	if (repeat)
		[thisSprite runAction:[CCRepeatForever actionWithAction:mjAnimate]];
	else
		[thisSprite runAction:mjAnimate];
}

//-(CCParticleSystem*) makeParticleSystem {
//	CCParticleSystem* safeParticle2 = [CCParticleSystemQuad particleWithFile:@"safespot.plist"];
//	[safeParticle2 setPosition:ccp(trackPos.x+23, trackPos.y+30)];
//	[map addChild:safeParticle2 z:newNumberZ];
//}

@end

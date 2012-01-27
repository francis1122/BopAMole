//
//  MenuLayer.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface MenuLayer : CCLayer{
    
}




-(id)init;

-(void)playButtonTouched:(CCMenuItem*)sender;
-(void)leaderboardButtonTouched:(CCMenuItem*)sender;

@end

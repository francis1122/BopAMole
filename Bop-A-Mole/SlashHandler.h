//
//  SlashHandler.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SlashHandler : NSObject{
    NSMutableArray *touchArray;
}
@property (nonatomic, retain) NSMutableArray *touchArray;


-(id) init;

-(void)update:(ccTime)dt;

-(void)addPoint:(CGPoint) point;

-(void) clearAllTouches;

@end

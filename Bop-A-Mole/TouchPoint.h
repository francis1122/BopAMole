//
//  TouchPoint.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TouchPoint : NSObject{
    CGPoint position;
    float lifeTime;
    
}
@property (nonatomic) CGPoint position;
@property (nonatomic) float lifeTime;

-(id)initWithPosition:(CGPoint) point;
-(void)update:(ccTime) dt;

@end

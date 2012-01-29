//
//  TouchPoint.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchPoint.h"


@implementation TouchPoint

@synthesize lifeTime, position;

-(id)initWithPosition:(CGPoint) point{
    if(self = [super init]){
        self.position = point;
        self.lifeTime = 0.0;
    }
    return self;
}

-(void)update:(ccTime) dt{
    self.lifeTime += dt;
}

@end

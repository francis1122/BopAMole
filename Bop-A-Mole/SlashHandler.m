//
//  SlashHandler.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SlashHandler.h"
#import "TouchPoint.h"

@implementation SlashHandler

@synthesize touchArray;

-(id) init{
    if(self = [super init]){
        self.touchArray = [[[NSMutableArray alloc] init] autorelease];
        
    }
    return self;
}


-(void)update:(ccTime)dt{
    for(TouchPoint *point in self.touchArray){
        [point update:dt];
    }
}

-(void)addPoint:(CGPoint) point{
    TouchPoint *previousTouchPoint = [self.touchArray lastObject];
    //new touch point
    TouchPoint *touchPoint = [[[TouchPoint alloc] initWithPosition:point] autorelease];
    if(previousTouchPoint){
        [self.touchArray addObject:previousTouchPoint];
    }
    [self.touchArray addObject: touchPoint];
}

-(void) clearAllTouches{
    [self.touchArray removeAllObjects];
}

@end

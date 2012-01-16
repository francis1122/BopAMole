//
//  SingleTapMole.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleTapMole.h"

@implementation SingleTapMole


-(id) initSingleTapMole{
    if(self = [super initWithFile:@"mole.png"]){
        
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    [super gameLoop:dt];
}

@end

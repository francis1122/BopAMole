//
//  MoleBaseClass.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoleBaseClass.h"


@implementation MoleBaseClass

@synthesize lifeTime;

-(id) initWithFile:(NSString*)spriteName{
    if(self = [super initWithFile:spriteName]){
        self.lifeTime = 0.0;
    }
    
    return self;

}


-(void)gameLoop:(ccTime)dt{
    self.lifeTime += dt;
}

@end

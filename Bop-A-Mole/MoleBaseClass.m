//
//  MoleBaseClass.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoleBaseClass.h"


@implementation MoleBaseClass

@synthesize lifeTime, lifeSpan, gotAway, criticalSpan, criticalTime, isCritical, isDead;


-(id) initWithFile:(NSString*)spriteName{
    if(self = [super initWithFile:spriteName]){
        self.lifeTime = 0.0;
        self.lifeSpan = 2.0;
        self.criticalTime = 1.1;
        self.criticalSpan = 0.6;
        self.gotAway = NO;
        self.isCritical = NO;
        self.isDead = NO;
        
    }
    
    return self;

}


-(void)gameLoop:(ccTime)dt{
    self.lifeTime += dt;
    if(self.lifeTime > self.lifeSpan){
        self.gotAway = YES;
    }
    if(self.criticalTime < self.lifeTime && (self.criticalTime + self.criticalSpan) > self.lifeTime){
        ccColor3B yellow = {224, 225, 0};
        self.color = yellow;
        self.isCritical = YES;
    }else{
        ccColor3B white = {255, 255, 255};
        self.color = white;
        self.isCritical = NO;
    }
}

-(void)tapped{
    
}

@end

//
//  GameLayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameScene.h"

#import "MoleBaseClass.h"
#import "SingleTapMole.h"
#import "MultiTapMole.h"


@implementation GameLayer

@synthesize moleArray, deadMolesArray;

-(id)init{
    if(self = [super init]){
        //setup the background
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"whackamoleBG.png"];
        CGSize s = [CCDirector sharedDirector].winSize;
        
        [backgroundSprite setPosition:ccp(s.width/2, s.height/2)];


//        backgroundSprite.position = ccp(0,0);
        [self addChild:backgroundSprite];
        
        
        self.isTouchEnabled = YES;
        self.moleArray = [[[NSMutableArray alloc] init] autorelease];
        self.deadMolesArray = [[[NSMutableArray alloc] init] autorelease];
    }
    return self;
}


-(void)gameLoop:(ccTime)dt{
    
    for(MoleBaseClass* moleObject in self.moleArray){
        [moleObject gameLoop:dt];
        if(moleObject.gotAway){
            [self.deadMolesArray addObject:moleObject];
            [[GameScene sharedScene] playerGotHurt];
        }
        if(moleObject.isDead){
            [self.deadMolesArray addObject:moleObject];
        }
    }
    

    
    [self spawnMoles];
    
    [self removeMoles];
    
    if( [[GameScene sharedScene] timeOnCurrentLevel] > 10.0){
        
        //remove moles while level changes
            for(MoleBaseClass* moleObject in self.moleArray){
                [self.deadMolesArray addObject:moleObject];
            }
        [self removeMoles];
        [[GameScene sharedScene] moveToNextLevel];
    }
    
}


-(void)spawnMoles{
//    float gameTime = [GameScene sharedScene].gameTime;
    int level = [[GameScene sharedScene] level];
    
    if(rand()%120 - 10*level == 0){
        if(rand()%6 == 0){
            MultiTapMole *newMole = [[[MultiTapMole alloc] initMultiTapMole] autorelease];
            newMole.position = ccp( (rand()%440) + 20, (rand()%200) + 20 );
            [self.moleArray addObject:newMole];
            [self addChild:newMole];
        }else{
            SingleTapMole *newMole = [[[SingleTapMole alloc] initSingleTapMole] autorelease];
            newMole.position = ccp( (rand()%440) + 20, (rand()%200) + 20 );
            [self.moleArray addObject:newMole];
            [self addChild:newMole];
        }
    }
    
}

-(void)removeMoles{
    for(MoleBaseClass* deadMole in self.deadMolesArray){
        [self removeChild:deadMole cleanup:YES];
        [self.moleArray removeObject:deadMole];
    }
}

-(void)removeMoleObject:(MoleBaseClass*) deadMole{
    [self.deadMolesArray addObject:deadMole];
}



#pragma -
#pragma touch

-(void)checkTapCollision:(CGPoint) touch{
    GameScene *gameScene = [GameScene sharedScene];
    for(MoleBaseClass* moleObject in self.moleArray){
        CGRect boundingBox = [moleObject boundingBox];
        if(CGRectContainsPoint( boundingBox, touch)){
            [moleObject tapped];
            break;
        }
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch* touch in touches){

        //        UITouch *touch = [touches anyObject];
//        CGPoint location = [touch locationInView: [touch view]];
//        CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView:[touch view]]];
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        [self checkTapCollision:location];

    }


}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
}
@end

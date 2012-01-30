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
#import "SlashHandler.h"
#import "SlashMole.h"
#import "TouchPoint.h"
#import "MathLib.h"


@implementation GameLayer

@synthesize moleArray, deadMolesArray, slashHandler;

-(id)init{
    if(self = [super init]){
        //setup the background
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"whackamoleBG.png"];
        CGSize s = [CCDirector sharedDirector].winSize;
        
        [backgroundSprite setPosition:ccp(s.width/2, s.height/2)];
        
        
        //        backgroundSprite.position = ccp(0,0);
        [self addChild:backgroundSprite];
        
        
        self.isTouchEnabled = YES;
        self.slashHandler = [[[SlashHandler alloc] init] autorelease];
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
    
    if( [[GameScene sharedScene] timeOnCurrentLevel] > 15.0){
        
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
    
    if(rand()%(70 - 5*level) == 0){
        if(rand()%6 == 0){
            MultiTapMole *newMole = [[[MultiTapMole alloc] initMultiTapMole] autorelease];
            newMole.position = ccp( (rand()%440) + 20, (rand()%200) + 20 );
            [self.moleArray addObject:newMole];
            [self addChild:newMole];
        }else{
/*            SingleTapMole *newMole = [[[SingleTapMole alloc] initSingleTapMole] autorelease];
            newMole.position = ccp( (rand()%440) + 20, (rand()%200) + 20 );
            [self.moleArray addObject:newMole];
            [self addChild:newMole];
 */
            
            SlashMole *newMole = [[[SlashMole alloc] initSlashMole] autorelease];
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
#pragma draw
/*
 -(void) draw{
 [super draw];
 glLineWidth(3.0f);
 glColor4f(1.0, 0.4, 0.76, 1.0);  
 
 if(self.slashHandler.touchArray.count >= 2){
 NSLog(@"draw");
 for(int i = 1; i < self.slashHandler.touchArray.count; i++){        
 CGPoint a = ((TouchPoint*)[self.slashHandler.touchArray objectAtIndex:i-1]).position;
 CGPoint b = ((TouchPoint*)[self.slashHandler.touchArray objectAtIndex:i]).position;
 ccDrawLine(a,b);
 }
 }
 int height = 400;
 for(int i = 1; i < 5; i++){
 ccDrawLine(ccp( (480/4) * i,0 ), ccp((480/4) * i, height));
 }
 
 
 
 }
 */

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

-(void)checkSlashCollision:(CGPoint) touch{

    GameScene *gameScene = [GameScene sharedScene];
    [self.slashHandler addPoint:touch];
    if(self.slashHandler.touchArray.count < 2){
        return;
    }
    for(MoleBaseClass* moleObject in self.moleArray){
        for(int i = 1; i < self.slashHandler.touchArray.count; i++){
            CGPoint a = ((TouchPoint*)[self.slashHandler.touchArray objectAtIndex:i-1]).position;
            CGPoint b = ((TouchPoint*)[self.slashHandler.touchArray objectAtIndex:i]).position;
//            NSLog(@" a: %f, %f", a.x, a.y);
  //          NSLog(@" b: %f, %f", b.x, b.y);
            
            if([MathLib intersectionStartLinePoint:a endLinePoint:b WithRect:moleObject.boundingBox]){
                [moleObject slashed];
              }
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
        [self checkSlashCollision:location];

    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];    

    [self checkSlashCollision:location];
    //temporary code, check for collisions
}


-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];
    
    [self.slashHandler clearAllTouches];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];    
    [self.slashHandler clearAllTouches];
}
@end

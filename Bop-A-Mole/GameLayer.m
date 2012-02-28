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
#import "Moles.h"
#import "TouchPoint.h"
#import "SlashHandler.h"
#import "MathLib.h"
#import "MoleSpawner.h"
#import "MoleSpawn.h"
#import "SimpleAudioEngine.h"

@implementation GameLayer

@synthesize moleArray, deadMolesArray, slashHandler, level;

-(id)init{
    if(self = [super init]){
        //setup the background
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"whackamoleBG.png"];
        CGSize s = [CCDirector sharedDirector].winSize;
        
        [backgroundSprite setPosition:ccp(s.width/2, s.height/2)];
        
        
        [self addChild:backgroundSprite];
        
        
        self.isTouchEnabled = YES;
        self.slashHandler = [[[SlashHandler alloc] init] autorelease];
        self.moleArray = [[[NSMutableArray alloc] init] autorelease];
        self.deadMolesArray = [[[NSMutableArray alloc] init] autorelease];
        level = nil;
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"CRevell_Mole_Game.mp3"];
        
    }
    return self;
}

-(void)cleanGameLayer{
    for(MoleBaseClass* mole in self.moleArray){
        [self removeChild:mole cleanup:YES];
    }
    [self.moleArray removeAllObjects];
    [self.deadMolesArray removeAllObjects];
    if(level){
        [level release];
    }
    level = nil;
    level = [[NSMutableArray alloc] initWithArray:[[MoleSpawner sharedInstance] generateLevel:@"1" withBPM:[[GameScene sharedScene] BPM]]];
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
}

-(void)beatUpdate:(float)beatDt{
    for(MoleBaseClass* moleObject in self.moleArray){
        [moleObject beatUpdate:beatDt];
        if(moleObject.gotAway){
            [self.deadMolesArray addObject:moleObject];
            if([moleObject isKindOfClass:[SkipMole class]]){
                
            }else{
                [[GameScene sharedScene] playerGotHurt];
            }
        }
    }

}

-(void)spawnMoles{    
    float elapsedTime = [[GameScene sharedScene] timeOnCurrentLevel];
    BOOL objectsLeftToSpawnThisTick = YES;
    
    // Spawn all moles that should have by now
    while([level count] > 0 && objectsLeftToSpawnThisTick) {
        MoleSpawn* spawn = [level objectAtIndex:0];
        float spawnTime = spawn.dt;
        if(spawnTime <= elapsedTime) {
            if(spawn.mole){
                CGPoint pixelPos = [[MoleSpawner sharedInstance] getPixelForParititionPosition:[spawn.mole position]];
                [spawn.mole setPosition:CGPointMake(pixelPos.x, pixelPos.y)];
                [self.moleArray addObject:spawn.mole];
                [self addChild:spawn.mole];
                [spawn.mole onSpawn];
                [level removeObjectAtIndex:0];
            }else{
                NSLog(@"spawn object didn't create a mole");
            }
        }
        else {
            objectsLeftToSpawnThisTick = NO;
        }
    }  
    
    // If level is finished, start next level
    if(elapsedTime > [[GameScene sharedScene] levelLength]){
        for(MoleBaseClass* moleObject in self.moleArray){
            [self.deadMolesArray addObject:moleObject];
        }
        [self removeMoles];
        [[GameScene sharedScene] transitionFromGamePlayStateToLevelTransitionState];
        
    }
}

-(void)removeMoles{
    for(MoleBaseClass* deadMole in self.deadMolesArray){
        [self removeChild:deadMole cleanup:YES];
        [self.moleArray removeObject:deadMole];
    }
}

-(void)removeMoleObject:(MoleBaseClass*) deadMole{
    if(deadMole.isTutorial){
        [[GameScene sharedScene] setIsTutorialMode:NO];
    }
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

    for(MoleBaseClass* moleObject in self.moleArray){
        CGRect boundingBox = [moleObject boundingBox];
        if(CGRectContainsPoint( boundingBox, touch)){
            [moleObject tapped];
            break;
        }
    }
}

-(void)checkSlashCollision:(CGPoint) touch{
    

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

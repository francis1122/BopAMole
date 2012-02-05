//
//  UILayer.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"
#import "GameScene.h"
#import "Constants.h"
#import "LifeContainer.h"

@implementation UILayer

@synthesize pauseButton, scoreLabel, comboLabel, life, ribbon;

-(id)init{
    if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //score label
        
        
        self.scoreLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(100, 25) alignment:UITextAlignmentRight fontName:kFont1 fontSize:20];
        self.scoreLabel.position = ccp(winSize.width - 60, winSize.height - 20);
        ccColor3B yellow = {224, 225, 0};
        [self.scoreLabel setColor:yellow];
        [self addChild:self.scoreLabel];
        
        self.comboLabel = [CCLabelTTF labelWithString:@"1x" dimensions:CGSizeMake(100, 25) alignment:UITextAlignmentRight fontName:kFont1 fontSize:20];
        self.comboLabel.position = ccp(winSize.width - 60, winSize.height - 50);
        [self.comboLabel setColor:yellow];
        [self addChild:self.comboLabel];
                
        self.life = [[LifeContainer alloc] init];
        [self addChild:self.life];
        self.life.position = ccp(winSize.width - 25, 25);
        
        //pause button
        CCSprite *sprite10 = [CCSprite spriteWithFile:@"Pause.png"];
        CCSprite *sprite11 = [CCSprite spriteWithFile:@"Pause.png"];
        CCSprite *sprite12 = [CCSprite spriteWithFile:@"Pause.png"];
        CCMenuItemSprite *raceBeginButton = [CCMenuItemSprite itemFromNormalSprite:sprite10 selectedSprite:sprite11 disabledSprite:sprite12 target:self selector:@selector(pauseButtonTouched:)];
        raceBeginButton.position = ccp(sprite10.contentSize.width/2 + 5, winSize.height - sprite10.contentSize.height/2 - 5);
        raceBeginButton.tag = 0;
        
        self.isTouchEnabled = YES;

        self.pauseButton = [CCMenu menuWithItems:raceBeginButton,  nil];
        self.pauseButton.position = CGPointZero;
        
        
        [self addChild:self.pauseButton];
        
        ccColor4B black = ccc4(200, 200, 35, 255);
        self.ribbon = [[CCRibbon alloc] initWithWidth:30.0f image:@"Icon.png" length:30.0f color:black fade:0.2];
        
        [self addChild:ribbon];
        
        
        
    }
    return self;
}

-(void)cleanUILayer{
    [self.life resetHealth];
}

-(void)pauseButtonTouched:(CCMenuItem*)sender{
    GameScene *scene = [GameScene sharedScene];
    if(scene.isGamePaused){
        //shoudn't get called ever
        [scene transitionFromPauseStateToGamePlayState];
    }else{
        [scene transitionFromGamePlayStateToPauseState];

    }
}

-(void)gameLoop:(ccTime) dt{
    [self.ribbon update:dt];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch* touch in touches){
        
        //        UITouch *touch = [touches anyObject];
        //        CGPoint location = [touch locationInView: [touch view]];
        //        CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView:[touch view]]];
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        

        
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];    
    
    [self.ribbon addPointAt:location width:30.0];
    //temporary code, check for collisions
}


-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];
    

}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];    
    
}

@end

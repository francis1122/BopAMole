//
//  MoleSpawner.m
//  Bop-A-Mole
//
//  Created by Ethan Benanav on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoleSpawner.h"
#import "MoleHelper.h"
#import "Moles.h"

@implementation MoleSpawner

static MoleSpawner *sharedInstance = nil;


+(MoleSpawner*) sharedInstance{
    @synchronized(self){
        if(sharedInstance == nil)
            sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;   
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSString * molePlistPath = [[NSBundle mainBundle] pathForResource:@"Moles" ofType:@"plist"];
        moleData = [NSDictionary dictionaryWithContentsOfFile:molePlistPath];

        NSString * levelPlistPath = [[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"];
        levelData = [NSDictionary dictionaryWithContentsOfFile:levelPlistPath];
                    
        lastSpawn = 0.0; // Initialization code here.
    }
    
    return self;
}

- (NSDictionary*)rollBetweenItems:(NSArray*)items {
    int roll = arc4random() % 100;
    int totalProbability = 0;
    
    for(NSDictionary* item in items) {
        totalProbability += [[item valueForKey:@"Chance"] intValue];
    }        
    roll /= totalProbability;
    
    int totalChance = 0;
    for(NSDictionary* item in items) {
        totalChance += [[item valueForKey:@"Chance"] intValue];
        if(roll <= totalChance) {
            return item;
        }
    }        
    return [items objectAtIndex:0];
    
}

-(NSArray*)generateLevel:(NSString*)levelNum withBPM:(int)BPM {
    NSDictionary* level = [levelData objectForKey:levelNum];

    NSMutableArray* beatTimings = [NSMutableArray new];
    NSMutableArray* moles = [NSMutableArray new];

    float beatInterval = 60.0/BPM;
    float elapsedTime = 0.0;
    float levelLength = [[level valueForKey:@"Length"] floatValue];
    NSDictionary* currentStage = [[level objectForKey:@"Stages"] objectAtIndex:0];

    do {
        float percentComplete = 100 * (elapsedTime / levelLength);

        // Go to next stage, if needed
        if (percentComplete >= [[currentStage valueForKey:@"Percent"] intValue]) {
            for (NSDictionary* stage in [level objectForKey:@"Stages"]) {
                if(percentComplete < [[stage valueForKey:@"Percent"] intValue]) {
                    currentStage = stage;
                    break;
                }
            }
        }
        
        // Choose beat interval
        NSArray* beatIntervals = [currentStage objectForKey:@"When"];        
        NSDictionary* chosenBeatInterval = [self rollBetweenItems:beatIntervals];
        float beat = [[chosenBeatInterval valueForKey:@"Beat"] floatValue];
        elapsedTime += beatInterval * beat;
        
        // Choose mole pattern to spawn
        NSArray* molePatterns = [currentStage objectForKey:@"What"]; 
        NSDictionary* chosenMolePattern = [self rollBetweenItems:molePatterns];
        NSArray* molePattern = [moleData objectForKey:[chosenMolePattern valueForKey:@"Mole Type"]];

        // Setup and add mole
        for(NSDictionary* mole in molePattern) {
            NSArray* positionArray = [[mole valueForKey:@"Position"] componentsSeparatedByString:@","];
            CGPoint position = CGPointMake([[positionArray objectAtIndex:0] floatValue],[[positionArray objectAtIndex:1] floatValue]);
            float time = elapsedTime + [[mole valueForKey:@"Time"] floatValue];
            id moleObj = [MoleHelper createMole:[mole valueForKey:@"Mole Type"]];
            [moleObj setPosition:position];    
            
            [beatTimings addObject:[NSNumber numberWithFloat:time]];
            [moles addObject:moleObj];
        }
        
    } while(elapsedTime < levelLength);
    
    return [NSArray arrayWithObjects:beatTimings, moles, nil];
}

@end

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

#import "MoleSpawn.h"
#import "MasterDataModelController.h"

#define BOARD_X_PARTITIONS 12
#define BOARD_Y_PARTITIONS 4

#define BOARD_X_SIZE 400
#define BOARD_Y_SIZE 150

@implementation MoleSpawner

@synthesize moleData, levelData;

static MoleSpawner *sharedInstance = nil;


+(MoleSpawner*) sharedInstance{
    @synchronized(self){
        if(sharedInstance == nil)
            sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;   
}

-(id)init
{
    self = [super init];
    if (self) {
        
        NSString * molePlistPath = [[NSBundle mainBundle] pathForResource:@"Moles" ofType:@"plist"];
        self.moleData = [NSDictionary dictionaryWithContentsOfFile:molePlistPath];
        
        NSString * levelPlistPath = [[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"];
        self.levelData = [NSDictionary dictionaryWithContentsOfFile:levelPlistPath];
        
        boardState = [NSMutableDictionary new];
        lastSpawn = 0.0; // Initialization code here.
        spotCheck = [NSMutableArray new];
        
        for(int x = 0; x < BOARD_X_PARTITIONS; ++x) {
            for(int y = 0; y < BOARD_Y_PARTITIONS; ++y) {
                NSString* key = [[NSString alloc] initWithFormat:@"%d,%d",x,y];
                [spotCheck addObject:key];
            }
        }
        
        finalizedMoles = [NSMutableArray new];
        
        
    }
    
    return self;
}

- (CGPoint)locationForMoleSpawn:(MoleSpawn*)spawn {
    BOOL success = NO;
    
    int boardX = 0;
    int boardY = 0;
    
    NSMutableArray* remainingSpots = [[NSMutableArray alloc] initWithArray:spotCheck];
    
    CGPoint directionalModifiers = CGPointMake(rand() % 100 < 50 ? 1 : -1, rand() % 100 < 50 ? 1 : -1);
    
    
    // TODO: Handle impossible situation
    while(!success && [remainingSpots count] > 0) {
        int randomSpot = rand() % [remainingSpots count];
        NSString* key = [remainingSpots objectAtIndex:randomSpot];
        
        NSArray* locComponents = [key componentsSeparatedByString:@","];
        boardX = [[locComponents objectAtIndex:0] intValue];
        boardY = [[locComponents objectAtIndex:1] intValue];
        
        [remainingSpots removeObject:key];
        
        NSMutableArray* stack = [boardState objectForKey:key];
        if(!stack) {
            stack = [NSMutableArray new];
            [boardState setObject:stack forKey:key];
        }
        success = [self attemptMoleSpawn:spawn inStack:stack];
        
        // Spawn any following moles that might exist in the pattern
        MoleSpawn* nextSpawn = spawn.nextMole;
        while(nextSpawn && success) {            
            int relativeX = [nextSpawn.mole relativeX];
            int relativeY = [nextSpawn.mole relativeY];
            if(relativeX == -666){
                relativeX = rand()%25 - 12;
                if(relativeX == 0){
                    relativeX = 100;
                }
            }
            if(relativeY == -666){
                relativeY = rand()%9 - 4;
                if(relativeY == 0){
                    relativeY = 100;
                }
            }
            
            relativeX *= directionalModifiers.x;
            relativeY *= directionalModifiers.y;
            
            CGPoint nextSpawnAbsolutePosition = CGPointMake((int)(boardX + relativeX), 
                                                            (int)(boardY + relativeY));
            // Make sure next spawn fits on the board
            if(nextSpawnAbsolutePosition.x < BOARD_X_PARTITIONS &&
               nextSpawnAbsolutePosition.y < BOARD_Y_PARTITIONS &&
               nextSpawnAbsolutePosition.x > 0 &&
               nextSpawnAbsolutePosition.y > 0) {
                key = [NSString stringWithFormat:@"%d,%d",(int)nextSpawnAbsolutePosition.x,
                       (int)nextSpawnAbsolutePosition.y];
                
                NSLog(@"next mole pos: %@",key);
                stack = [boardState objectForKey:key];
                if(!stack) {
                    stack = [NSMutableArray new];
                    [boardState setObject:stack forKey:key];
                }
                
                success = [self attemptMoleSpawn:nextSpawn inStack:stack];
                if(success) {
                    [nextSpawn.mole setPosition:nextSpawnAbsolutePosition];
                    
                    nextSpawn = nextSpawn.nextMole;
                }
                else {
                    nextSpawn = nil;
                }
                
            }
            else {
                success = NO;
                nextSpawn = nil;
            }
        }
    }    
    if(success) {
        return CGPointMake(boardX, boardY);
    }
    else {
        return CGPointMake(-1, -1);
    }
    
}

- (BOOL)attemptMoleSpawn:(MoleSpawn*)spawn inStack:(NSMutableArray*)stack {
    int index = 0;
    for(MoleSpawn* stackSpawn in stack) {
        if(spawn.dt > stackSpawn.dt && spawn.dt < stackSpawn.death_dt) {
            return NO;
        }
        if(stackSpawn.death_dt < spawn.dt) {
            [stack insertObject:spawn atIndex:index];
            return YES;
        }
        index++;
    }        
    
    [stack insertObject:spawn atIndex:index];
    return YES;
}

-(CGSize)partitionSize {
    return CGSizeMake(BOARD_X_SIZE/BOARD_X_PARTITIONS, 
                      BOARD_Y_SIZE/BOARD_Y_PARTITIONS);
}

-(CGPoint)getPixelForParititionPosition:(CGPoint)position {
    CGSize partitionSize = [self partitionSize];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    float xOffset = (winSize.width - BOARD_X_SIZE)/2;
    float yOffset = 50;
    
    return CGPointMake(xOffset + partitionSize.width*(int)position.x + partitionSize.width/2, 
                       yOffset + partitionSize.height*(int)position.y + partitionSize.height/2);
}

-(NSDictionary*)rollBetweenItems:(NSArray*)items {
    int roll = rand() % 100;
    int totalProbability = 0;
    
    for(NSDictionary* item in items) {
        totalProbability += [[item valueForKey:@"Chance"] intValue];
    }
    
    float normalizedRoll = roll/100.0;
    
    roll = (int)(normalizedRoll * totalProbability);
    
    int totalChance = 0;
    for(NSDictionary* item in items) {
        totalChance += [[item valueForKey:@"Chance"] intValue];
        if(roll <= totalChance && [[item valueForKey:@"Chance"] intValue] > 0) {
            return item;
        }
    }        
    return [items objectAtIndex:0];
    
}

-(NSArray*)generateLevel:(NSString*)levelNum withBPM:(int)BPM {
    NSDictionary* level = [levelData objectForKey:levelNum];
    
    // Get player's current seed
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int seed = [userDefaults integerForKey:@"randSeed"];
    srand(seed);
    
    // Change the stored seed
    [[MasterDataModelController sharedInstance] trackRandomSeed:seed+1];

    if(level) {
        // Reset state
        boardState = [NSMutableDictionary new];
        finalizedMoles = [NSMutableArray new];
        
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
            if(beat == 0) {
                NSLog(@"Zero beat!");
            }
            
            // Choose mole pattern to spawn
            NSArray* molePatterns = [currentStage objectForKey:@"What"]; 
            NSDictionary* chosenMolePattern = [self rollBetweenItems:molePatterns];
            NSArray* molePattern = [[moleData objectForKey:[chosenMolePattern valueForKey:@"Mole Type"]] objectForKey:@"Moles"];
            
            bool exclusive = [[moleData objectForKey:[chosenMolePattern valueForKey:@"Mole Type"]] valueForKey:@"Exclusive"];
            
            // Setup and add mole
            MoleSpawn* prevSpawn = nil;
            
            // Increment elapsed time
            elapsedTime += beatInterval * beat;                
                        
            for(int i = 0; i < [molePattern count]; ++i) {
                NSDictionary* mole = [molePattern objectAtIndex:i];
                NSArray* positionArray = [[mole valueForKey:@"Position"] componentsSeparatedByString:@","];
                CGPoint position = CGPointMake([[positionArray objectAtIndex:0] intValue],[[positionArray objectAtIndex:1] intValue]);
                float time = elapsedTime + beatInterval * [[mole valueForKey:@"Time"] floatValue];
                id moleObj = [MoleHelper createMole:[mole valueForKey:@"Mole Type"]];
                
                MoleSpawn* spawn = [[MoleSpawn alloc] init];
                spawn.mole = moleObj;
                spawn.dt = time;
                //must convert beatLifeSpan back to seconds
                spawn.death_dt = time + ((float)[moleObj beatLifeSpan] * beatInterval) ;
                spawn.pattern = [chosenMolePattern valueForKey:@"Mole Type"];
                
                if(prevSpawn) {
                    prevSpawn.nextMole = spawn;
                }
                else {
                    [moles addObject:spawn];
                }
                
                [moleObj setRelativeX:(int)position.x];    
                [moleObj setRelativeY:(int)position.y];
                
                prevSpawn = spawn;
            }
            
            // This pattern was exclusive, don't allow other patterns to spawn
            // till this one is done
            if(exclusive) {
                elapsedTime += beatInterval * [[[molePattern lastObject] valueForKey:@"Time"] floatValue];
            }
            
        } while(elapsedTime < levelLength);
        
        // Position the moles
        for(int i = 0; i < [moles count]; ++i) {
            MoleSpawn* spawn = [moles objectAtIndex:i];
            CGPoint spawnPosition = [self locationForMoleSpawn:spawn];
            
            // Only add moles if valid position was found
            if(spawnPosition.x >= 0 && spawnPosition.y >= 0) {
                [finalizedMoles addObject:spawn];
                MoleSpawn* nextSpawn = [spawn nextMole];
                while (nextSpawn) {                
                    [finalizedMoles addObject:nextSpawn];
                    nextSpawn = [nextSpawn nextMole];
                }
                
                [[spawn mole] setPosition:spawnPosition];
            }
            
        }    
        
        NSArray *sortedMoles;
        sortedMoles = [finalizedMoles sortedArrayUsingComparator:^(id a, id b) {
            NSNumber* dt1 = [NSNumber numberWithFloat:[(MoleSpawn*)a dt]];
            NSNumber* dt2 = [NSNumber numberWithFloat:[(MoleSpawn*)b dt]];
            return [dt1 compare:dt2];
        }];
        
        return sortedMoles;
    }
    return nil;
}

@end

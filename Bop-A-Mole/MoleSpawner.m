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
        lastSpawn = 0.0; // Initialization code here.
        levelData = [[NSDictionary alloc] initWithContentsOfFile:@"Levels.plist"];        
    }
    
    return self;
}

// For now: linearly interpolate between begin/end spawnrate values for a level
-(float)getSpawnIntervalForLevel:(int)level elapsedTime:(float)elapsedTime {
    NSDictionary* currentLevelData = [levelData objectForKey:[NSString stringWithFormat:@"%d", level]];
        
    float levelBeginValue = [[currentLevelData valueForKey:@"spawnRateBegin"] floatValue];
    float levelEndValue = [[currentLevelData valueForKey:@"spawnRateEnd"] floatValue];
    float levelLength = [[currentLevelData valueForKey:@"levelLength"] floatValue];
    
    return elapsedTime/levelLength * (levelEndValue - levelBeginValue) + levelBeginValue;
}

-(id)spawnMoleWithLevel:(int)level elapsedTime:(float)elapsedTime {
    float spawnDt = elapsedTime - lastSpawn;    
    float frequency = [self getSpawnIntervalForLevel:level elapsedTime:elapsedTime];
    
    if(frequency <= spawnDt) { // Enough time has elapsed: A mole should spawn
        int type = MOLE_TAP;
        
    }
    
    return nil; // No mole is spawning this tick
}


@end

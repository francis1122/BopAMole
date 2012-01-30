//
//  MoleSpawner.h
//  Bop-A-Mole
//
//  Created by Ethan Benanav on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MoleSpawn;

@interface MoleSpawner : NSObject {
    float lastSpawn;
    NSDictionary* levelData;
    NSDictionary* moleData;
    NSMutableDictionary* boardState;
    NSMutableArray* spotCheck;
    NSMutableArray* finalizedMoles;
}

@property (nonatomic, retain) NSDictionary* levelData;
@property (nonatomic, retain) NSDictionary* moleData;

+(MoleSpawner*)sharedInstance;
-(NSArray*)generateLevel:(NSString*)levelNum withBPM:(int)BPM;
-(CGSize)partitionSize;
-(CGPoint)getPixelForParititionPosition:(CGPoint)position;
-(NSDictionary*)rollBetweenItems:(NSArray*)items;

// Mole positioning
- (CGPoint)locationForMoleSpawn:(MoleSpawn*)spawn;
- (BOOL)attemptMoleSpawn:(MoleSpawn*)spawn inStack:(NSMutableArray*)stack;


@end

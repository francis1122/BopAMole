//
//  MoleSpawner.h
//  Bop-A-Mole
//
//  Created by Ethan Benanav on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoleSpawner : NSObject {
    float lastSpawn;
    NSDictionary* levelData;
    NSDictionary* moleData;
}

+(MoleSpawner*)sharedInstance;
-(NSArray*)generateLevel:(NSString*)levelNum withBPM:(int)BPM;
- (NSDictionary*)rollBetweenItems:(NSArray*)items;



@end

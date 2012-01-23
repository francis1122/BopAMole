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
}

+(MoleSpawner*)sharedInstance;
-(id)spawnMoleWithLevel:(int)level elapsedTime:(float)elapsedTime;

@end

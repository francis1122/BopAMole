//
//  MoleSpawn.h
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/29/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoleSpawn : NSObject {
    id mole;
    MoleSpawn* nextMole;
    float dt;
    float death_dt;
    NSString* pattern;
    
}

@property (nonatomic, retain) id mole;
@property (nonatomic, retain) MoleSpawn* nextMole;

@property (nonatomic) float dt;
@property (nonatomic) float death_dt;
@property (nonatomic, retain) NSString* pattern;

@end

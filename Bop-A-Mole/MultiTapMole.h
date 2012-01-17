//
//  MultiTapMole.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoleBaseClass.h"
#import "cocos2d.h"

@interface MultiTapMole : MoleBaseClass {
    NSInteger life; //how many taps left to kill mole
    NSInteger startingLife; //starting life of mole
}
@property (nonatomic) NSInteger life, startingLife;

-(id) initMultiTapMole;

@end

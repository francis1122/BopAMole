//
//  ComboStar.h
//  Bop-A-Mole
//
//  Created by Vinit Agarwal on 1/30/12.
//  Copyright 2012 Zynga. All rights reserved.
//

#import "CCSprite.h"

@interface ComboStar : CCSprite {
    CGPoint velocity;
    CGPoint gravity;
}

@property (nonatomic) CGPoint velocity;

- (void)setupComboStar;

@end

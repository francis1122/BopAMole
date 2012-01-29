//
//  MasterDataModelController.h
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
@interface MasterDataModelController : NSObject <GKLeaderboardViewControllerDelegate, GameCenterManagerDelegate>{
    GameCenterManager *gameCenterManager;
    UIViewController *overlayViewController;
    NSInteger highScore;
}

+(MasterDataModelController*) sharedInstance;
-(void) connectToGameCenter;
-(void)showLeaderboard;
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;
-(void)submitScore:(int)score;
-(void)trackScore:(int)score;

@property (assign) NSInteger highScore;
    
@end

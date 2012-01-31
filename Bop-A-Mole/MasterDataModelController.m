//
//  MasterDataModelController.m
//  Bop-A-Mole
//
//  Created by John Wilson on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterDataModelController.h"
#import "cocos2d.h"
#import "AppDelegate.h"

#define SEED_EXPIRATION_THRESHOLD 300

static MasterDataModelController *sharedInstance = nil;

@implementation MasterDataModelController
@synthesize highScore;

+(MasterDataModelController*) sharedInstance{
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
        // Initialization code here.
        overlayViewController = [[UIViewController alloc] init];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        highScore = [userDefaults integerForKey:@"highScore"];
    }
    
    return self;
}

-(void)connectToGameCenter{
    
	
	//load the specific leadeboard for this game, or well for a type of game, this could be for EASY/MED/HARD but for now we are just going to post 1 leaderboard
	
	if([GameCenterManager isGameCenterAvailable])
	{
		gameCenterManager= [[[GameCenterManager alloc] init] autorelease];
		[gameCenterManager setDelegate: self];
		[gameCenterManager authenticateLocalUser];
		
		// [self updateCurrentScore];
	}
	else
	{
		//[self showAlertWithTitle: @"Game Center Support Required!" message: @"The current device does not support Game Center, which this sample requires."];
		// put an alert here that the current device is not supported by Game Center (IE a non 3.0 Device)
	}		
	
}

-(void)showLeaderboard{
	GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init] autorelease];
	
	if (leaderboardController != nil)
	{
		leaderboardController.leaderboardDelegate = self;
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		//[[[CCDirector sharedDirector] openGLView] addSubview:overlayViewController.view];
        [appDelegate.window addSubview:overlayViewController.view];
		[overlayViewController presentModalViewController:leaderboardController animated:YES];
	}
	
}

// This leaderboard view controller did finish launching is USED when the user selects DONE on the ladeboard it will quit, if you dont have this the APP WILL CRASH!!! 
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[overlayViewController dismissModalViewControllerAnimated: YES];
	[overlayViewController.view.superview removeFromSuperview];
}

-(void)submitScore:(int)score{
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:@"bopamole1122"] autorelease];
    
	
	scoreReporter.value = [[NSNumber numberWithInt:score] intValue];
	
	[scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
		if (error != nil)
		{
			NSLog(@"Submitting Score Failed");
		}
		else {
			NSLog(@"Submitting Succeeded");	
		}
	}];
    
}

-(void)trackScore:(int)score{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(highScore < score){
        [userDefaults setInteger:score forKey:@"highScore"];  
        highScore = score;
        [userDefaults synchronize];
    }
    
}

-(void)trackRandomSeed:(int)seed {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate* lastSeedDate = [userDefaults objectForKey:@"seedDate"];
    
    // Initial case
    if(lastSeedDate == nil) {
        lastSeedDate = [[NSDate alloc] init];
        [userDefaults setObject:lastSeedDate forKey:@"seedDate"];
        [userDefaults setInteger:seed forKey:@"randSeed"];          
    }
    else {
        
        NSDate *now = [[NSDate alloc] init];
        
        // If enough time has elapsed, generate a new seed
        if([now timeIntervalSince1970] - [lastSeedDate timeIntervalSince1970] 
           > SEED_EXPIRATION_THRESHOLD) {
            
            [userDefaults setInteger:seed forKey:@"randSeed"];  
            [userDefaults setObject:lastSeedDate forKey:@"seedDate"];
        }
    }
    [userDefaults synchronize];    
    
}

-(void)dealloc{
    [super dealloc];
    [overlayViewController release];
}


@end

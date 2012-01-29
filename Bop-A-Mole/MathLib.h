//
//  MathLib.h
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MathLib : NSObject {
    
}


+(float) distanceBetweenPoint:(CGPoint) pointA and:(CGPoint) pointB;

//vector math

// returns in degrees
+(float) calcAngleBetweenVectors:(CGPoint) v1 and:(CGPoint) v2;
//different way of getting an angle between two points
//returns in degrees
+(float) calcAngle:(CGPoint) p1 and:(CGPoint)p2;

+(CGPoint) normalizeVector:(CGPoint) vector;

+(BOOL) lineIntersectionStartPointA:(CGPoint) a1 endPointA:(CGPoint) a2 startPointB:(CGPoint) b1 endPointB:(CGPoint) b2;

+(BOOL) intersectionStartLinePoint:(CGPoint) startPoint endLinePoint:(CGPoint) endPoint WithRect:(CGRect) box;

@end

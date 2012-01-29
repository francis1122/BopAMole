//
//  MathLib.m
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MathLib.h"



@implementation MathLib

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

+(float) distanceBetweenPoint:(CGPoint) pointA and:(CGPoint) pointB{
    return sqrtf( powf(pointA.x - pointB.x,2) + powf(pointA.y - pointB.y,2));
}



//vector math

+(float) calcAngleBetweenVectors:(CGPoint) v1 and:(CGPoint) v2{
    
    float dot = v1.x * v2.x + v1.y * v2.y;
    float angle = acosf(dot/( sqrt(powf(v1.x,2) + powf(v1.y,2)) * sqrt(powf(v2.x,2) + powf(v2.y,2)))  );
    return angle * 180/M_PI;
}

+(float) calcAngle:(CGPoint) p1 and:(CGPoint)p2{
    float angle = tan((p2.y-p1.y)/ (p2.x - p1.x)) * 180/M_PI;
    
    //if it is in the first quadrant
    if( p2.y < p1.y && p2.x > p1.x )
    {
        return angle;
    }
    //if its in the 2nd or 3rd quadrant
    if( ( p2.y < p1.y && p2.x < p1.x ) || ( p2.y > p1.y && p2.x < p1.x ) )
    {
        return angle + 180;
    }
    //it must be in the 4th quadrant so:
    return angle + 360;
}

+(CGPoint) normalizeVector:(CGPoint) vector{
    float length = sqrtf(vector.x * vector.x + vector.y *vector.y);
    CGPoint normlizedVector = CGPointMake(vector.x/length, vector.y/length);
    return normlizedVector;
}

+(BOOL) lineIntersectionStartPointA:(CGPoint) a1 endPointA:(CGPoint) a2 startPointB:(CGPoint) b1 endPointB:(CGPoint) b2{
    CGPoint b = CGPointMake(a2.x - a1.x, a2.y - a1.y);
    CGPoint d = CGPointMake(b2.x - b1.x, b2.y - b1.y);
    float bDotDPerp = b.x * d.y - b.y * d.x;
    
    // if b dot d == 0, it means the lines are parallel so have infinite intersection points
    if (bDotDPerp == 0){
        return NO;
    }
    

    CGPoint c = CGPointMake(b1.x - a1.x, b1.y - a1.y);
    float t = (c.x * d.y - c.y * d.x) / bDotDPerp;
    if (t < 0 || t > 1){
        return NO;
    }
    
    float u = (c.x * b.y - c.y * b.x) / bDotDPerp;
    if (u < 0 || u > 1){
        return NO;
    }
    
    return YES;
  
    // can be used to find exact intersection point of lines
//    intersection = a1 + t * b;
}

+(BOOL) intersectionStartLinePoint:(CGPoint) startPoint endLinePoint:(CGPoint) endPoint WithRect:(CGRect) box{

    //check four possible line intersections
    CGPoint bottomLeft = CGPointMake(box.origin.x, box.origin.y);
    CGPoint bottomRight = CGPointMake( box.origin.x + box.size.width, box.origin.y);
    CGPoint topLeft = CGPointMake(box.origin.x, box.origin.y + box.size.height);
    CGPoint topRight = CGPointMake(box.origin.x + box.size.width, box.origin.y + box.size.height);
    
    if(CGRectContainsPoint(box, startPoint)){
        return YES;
    }
    if(CGRectContainsPoint(box, endPoint)){
        return YES;
    }
    //bottom
    if( [MathLib lineIntersectionStartPointA:startPoint endPointA:endPoint startPointB:bottomLeft endPointB:bottomRight]){
        return YES;
    }
    
    //right
    if( [MathLib lineIntersectionStartPointA:startPoint endPointA:endPoint startPointB:bottomRight endPointB:topRight]){
        return YES;
    }
    
    //top 
    if( [MathLib lineIntersectionStartPointA:startPoint endPointA:endPoint startPointB:topRight endPointB:topLeft]){
        return YES;
    }
    
    // left
    if( [MathLib lineIntersectionStartPointA:startPoint endPointA:endPoint startPointB:topLeft endPointB:bottomLeft]){
        return YES;
    }
    
    
    return NO;
}

@end

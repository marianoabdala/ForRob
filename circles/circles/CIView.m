//
//  CIView.m
//  circles
//
//  Created by Mariano Abdala on 9/25/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "CIView.h"

#define OPAQUE          1.0f
#define SHADES_OF_GRAY  50  //Naughty.
#define CIRCLE_DIAMETER 20
#define CIRCLE_RADIUS   10

@interface CIView ()

@property (strong, nonatomic) NSMutableArray *dots;

- (void)processTouches:(NSSet *)touches;

@end

@implementation CIView

#pragma mark - Hierarchy
#pragma mark UIView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self processTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self processTouches:touches];
}

#pragma mark - Self
#pragma mark CIView
- (void)drawRect:(CGRect)rect {

    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    [self.dots enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        CGPoint dotLocation =
        ((NSValue *)obj).CGPointValue;

        CGRect circleRect =
        CGRectMake(dotLocation.x - CIRCLE_RADIUS,
                   dotLocation.y - CIRCLE_RADIUS,
                   CIRCLE_DIAMETER,
                   CIRCLE_DIAMETER);

        if (CGRectIntersectsRect(rect, circleRect)) {
            
            float gray = OPAQUE / (float)(idx % SHADES_OF_GRAY);
            
            CGContextSetRGBFillColor(contextRef, gray, gray, gray, OPAQUE);
            CGContextFillEllipseInRect(contextRef, circleRect);
        }
    }];
}

#pragma mark CIView ()
- (NSMutableArray *)dots {
    
    if (_dots == nil) {
        
        self.dots =
        [NSMutableArray array];
    }
    
    return _dots;
}

- (void)processTouches:(NSSet *)touches {
    
    for (UITouch *touch in touches) {
        
        CGPoint touchLocation =
        [touch locationInView:self];
        
        [self.dots addObject:[NSValue valueWithCGPoint:touchLocation]];
        
        CGRect circleRect =
        CGRectMake(touchLocation.x - CIRCLE_RADIUS,
                   touchLocation.y - CIRCLE_RADIUS,
                   CIRCLE_DIAMETER,
                   CIRCLE_DIAMETER);
        
        [self setNeedsDisplayInRect:circleRect];
    }
}

@end

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

#define AREA_1_RECT     CGRectMake(0,     0, 160, 160)
#define AREA_2_RECT     CGRectMake(160,   0, 160, 160)
#define AREA_3_RECT     CGRectMake(0,   160, 160, 160)
#define AREA_4_RECT     CGRectMake(160, 160, 160, 160)
#define AREA_5_RECT     CGRectMake(0,   320, 160, 160)
#define AREA_6_RECT     CGRectMake(160, 320, 160, 160)
#define AREA_7_RECT     CGRectMake(0,   480, 160, 160)
#define AREA_8_RECT     CGRectMake(160, 480, 160, 160)
#define AREA_9_RECT     CGRectMake(0,   640, 160, 160)
#define AREA_10_RECT    CGRectMake(160, 640, 160, 160)


@interface CIView ()

@property (strong, nonatomic) NSMutableArray *dotsInArea1;
@property (strong, nonatomic) NSMutableArray *dotsInArea2;
@property (strong, nonatomic) NSMutableArray *dotsInArea3;
@property (strong, nonatomic) NSMutableArray *dotsInArea4;
@property (strong, nonatomic) NSMutableArray *dotsInArea5;
@property (strong, nonatomic) NSMutableArray *dotsInArea6;
@property (strong, nonatomic) NSMutableArray *dotsInArea7;
@property (strong, nonatomic) NSMutableArray *dotsInArea8;
@property (strong, nonatomic) NSMutableArray *dotsInArea9;
@property (strong, nonatomic) NSMutableArray *dotsInArea10;

- (void)initialize;
- (void)processTouches:(NSSet *)touches;
- (CGRect)circleRectForLocation:(CGPoint)location;
- (void)storeTouchLocation:(CGPoint)location;
- (void)drawCirclesInArray:(NSArray *)dotsInArea inRect:(CGRect)rect inContext:(CGContextRef)context;

@end

@implementation CIView

static CGRect area1rect;
static CGRect area2rect;
static CGRect area3rect;
static CGRect area4rect;
static CGRect area5rect;
static CGRect area6rect;
static CGRect area7rect;
static CGRect area8rect;
static CGRect area9rect;
static CGRect area10rect;

#pragma mark - Hierarchy
#pragma mark UIView
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self =
    [super initWithCoder:aDecoder];
    
    if (self != nil) {
        
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self =
    [super initWithFrame:frame];
    
    if (self != nil) {
        
        [self initialize];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (CGRectIntersectsRect(rect, area1rect)) {
        
        [self drawCirclesInArray:self.dotsInArea1
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area2rect)) {
        
        [self drawCirclesInArray:self.dotsInArea2
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area3rect)) {
        
        [self drawCirclesInArray:self.dotsInArea3
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area4rect)) {
        
        [self drawCirclesInArray:self.dotsInArea4
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area5rect)) {
        
        [self drawCirclesInArray:self.dotsInArea5
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area6rect)) {
        
        [self drawCirclesInArray:self.dotsInArea6
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area7rect)) {
        
        [self drawCirclesInArray:self.dotsInArea7
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area8rect)) {
        
        [self drawCirclesInArray:self.dotsInArea8
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area9rect)) {
        
        [self drawCirclesInArray:self.dotsInArea9
                          inRect:rect
                       inContext:context];
    }
    
    if (CGRectIntersectsRect(rect, area10rect)) {
        
        [self drawCirclesInArray:self.dotsInArea10
                          inRect:rect
                       inContext:context];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self processTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self processTouches:touches];
}

#pragma mark CIView ()
- (void)initialize {
 
    self.dotsInArea1    = [NSMutableArray array];
    self.dotsInArea2    = [NSMutableArray array];
    self.dotsInArea3    = [NSMutableArray array];
    self.dotsInArea4    = [NSMutableArray array];
    self.dotsInArea5    = [NSMutableArray array];
    self.dotsInArea6    = [NSMutableArray array];
    self.dotsInArea7    = [NSMutableArray array];
    self.dotsInArea8    = [NSMutableArray array];
    self.dotsInArea9    = [NSMutableArray array];
    self.dotsInArea10   = [NSMutableArray array];
    
    area1rect   = AREA_1_RECT;
    area2rect   = AREA_2_RECT;
    area3rect   = AREA_3_RECT;
    area4rect   = AREA_4_RECT;
    area5rect   = AREA_5_RECT;
    area6rect   = AREA_6_RECT;
    area7rect   = AREA_7_RECT;
    area8rect   = AREA_8_RECT;
    area9rect   = AREA_9_RECT;
    area10rect  = AREA_10_RECT;
}

- (void)processTouches:(NSSet *)touches {
    
    for (UITouch *touch in touches) {
        
        CGPoint touchLocation =
        [touch locationInView:self];
        
        [self storeTouchLocation:touchLocation];
        
        CGRect circleRect =
        [self circleRectForLocation:touchLocation];
        
        [self setNeedsDisplayInRect:circleRect];
    }
}

- (CGRect)circleRectForLocation:(CGPoint)location {

    return
    CGRectMake(location.x - CIRCLE_RADIUS,
               location.y - CIRCLE_RADIUS,
               CIRCLE_DIAMETER,
               CIRCLE_DIAMETER);
}

- (void)storeTouchLocation:(CGPoint)location {

    NSValue *locationValue =
    [NSValue valueWithCGPoint:location];
    
    CGRect circleRect =
    [self circleRectForLocation:location];
    
    if (CGRectIntersectsRect(circleRect, area1rect)) {
        
        [self.dotsInArea1 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area2rect)) {
        
        [self.dotsInArea2 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area3rect)) {
        
        [self.dotsInArea3 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area4rect)) {
        
        [self.dotsInArea4 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area5rect)) {
        
        [self.dotsInArea5 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area6rect)) {
        
        [self.dotsInArea6 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area7rect)) {
        
        [self.dotsInArea7 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area8rect)) {
        
        [self.dotsInArea8 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area9rect)) {
        
        [self.dotsInArea9 addObject:locationValue];
    }
    
    if (CGRectIntersectsRect(circleRect, area10rect)) {
        
        [self.dotsInArea10 addObject:locationValue];
    }
}

- (void)drawCirclesInArray:(NSArray *)dotsInArea inRect:(CGRect)rect inContext:(CGContextRef)context {
    
    [dotsInArea enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGPoint dotLocation =
        ((NSValue *)obj).CGPointValue;
        
        CGRect circleRect =
        [self circleRectForLocation:dotLocation];
        
        if (CGRectIntersectsRect(rect, circleRect)) {
            
            float gray = (float)(idx % SHADES_OF_GRAY) / SHADES_OF_GRAY;
            
            CGContextSetRGBFillColor(context, gray, gray, gray, OPAQUE);
            CGContextFillEllipseInRect(context, circleRect);
        }
    }];
}

@end

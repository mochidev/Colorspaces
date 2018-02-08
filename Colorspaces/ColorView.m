//
//  ColorView.m
//  Colorspaces
//
//  Created by Dimitri Bouniol on 2/3/18.
//  Copyright © 2018 Mochi Development, Inc. All rights reserved.
//

#import "ColorView.h"

@interface ColorComponents: NSObject

@property (nonatomic) CGFloat r;
@property (nonatomic) CGFloat g;
@property (nonatomic) CGFloat b;

- (instancetype)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end

@implementation ColorComponents

- (instancetype)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    if (self = [super init]) {
        self.r = red;
        self.g = green;
        self.b = blue;
    }
    
    return self;
}

@end

@interface ColorView () {
    NSArray *baseColorComponents;
    NSArray *baseColorSpaces;
}

@end

@implementation ColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupColorViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupColorViews];
    }
    return self;
}

- (void)setupColorViews
{
    baseColorComponents = @[[[ColorComponents alloc] initWithRed:0 green:1 blue:1],
                            [[ColorComponents alloc] initWithRed:0 green:0 blue:1],
                            [[ColorComponents alloc] initWithRed:1 green:0 blue:1],
                            [[ColorComponents alloc] initWithRed:1 green:0 blue:0],
                            [[ColorComponents alloc] initWithRed:1 green:1 blue:0],
                            [[ColorComponents alloc] initWithRed:0 green:1 blue:0],
                            [[ColorComponents alloc] initWithRed:1 green:1 blue:1],
                            [[ColorComponents alloc] initWithRed:2./3. green:2./3. blue:2./3.],
                            [[ColorComponents alloc] initWithRed:1./3. green:1./3. blue:1./3.]];
    
    baseColorSpaces = @[(id)kCGColorSpaceExtendedSRGB,
                        (id)kCGColorSpaceDisplayP3,
                        (id)kCGColorSpaceDCIP3,
                        (id)kCGColorSpaceITUR_2020];
    
    _brightness = 1;
    
    CGFloat baseWidth = self.bounds.size.width/baseColorSpaces.count;
    CGFloat baseHeight = self.bounds.size.height/baseColorComponents.count;
    
    NSUInteger colorSpaceIndex = 0;
    for (id colorSpace in baseColorSpaces) {
        NSUInteger colorIndex = 0;
        for (ColorComponents *colorComponent in baseColorComponents) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(colorSpaceIndex*baseWidth, colorIndex*baseHeight, baseWidth, baseHeight)];
            
            view.backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithRed:colorComponent.r*_brightness green:colorComponent.g*_brightness blue:colorComponent.b*_brightness alpha:1 colorSpace:CGColorSpaceCreateWithName((CFStringRef)colorSpace)]];
            
            [self addSubview:view];
            
            colorIndex++;
        }
        
        colorSpaceIndex++;
    }
}

- (void)setBrightness:(CGFloat)brightness
{
    _brightness = brightness;
    
    NSUInteger viewIndex = 0;
    for (id colorSpace in baseColorSpaces) {
        for (ColorComponents *colorComponent in baseColorComponents) {
            UIView *view = [self.subviews objectAtIndex:viewIndex];
            
            view.backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithRed:colorComponent.r*_brightness green:colorComponent.g*_brightness blue:colorComponent.b*_brightness alpha:1 colorSpace:CGColorSpaceCreateWithName((CFStringRef)colorSpace)]];
            
            viewIndex++;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

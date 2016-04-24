//
//  DNOSingleText.m
//  DNOLabelAnimationDemo
//
//  Created by Danyow.Ed on 16/4/24.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import "DNOSingleText.h"
#define myRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

@interface DNOSingleText ()
{
    CGFloat _normalSteps;
    CGFloat _waveSteps;
    BOOL    _directionChange;
}

@end

@implementation DNOSingleText

+ (instancetype)singleTextWithAnimationRange:(CGFloat)animationRange
{
    DNOSingleText *obj = [[self alloc] init];
    obj.animationRange = animationRange;
    return obj;
}

- (void)calculateStep
{
    _directionChange ? _normalSteps-- : _normalSteps++;
    
    if (_normalSteps > self.animationRange) {
        _directionChange = YES;
    } else if (_normalSteps < 0) {
        _directionChange = NO;
    }
}

- (CGFloat)locationWithNormalAnimation
{
    [self calculateStep];
    return _normalSteps;
}

- (CGFloat)locationWithFirstEnumerate
{
    [self calculateStep];
    _normalSteps += 1;
    if (_normalSteps > self.animationRange) {
        _normalSteps = self.animationRange - (_normalSteps - self.animationRange);
    }
    self.enumerated = YES;
    return _normalSteps;
}

- (CGFloat)locationWithWaveAnimationCompletion:(void (^)())completion
{
    _waveSteps++;
    if (_waveSteps > 2 * self.animationRange) {
        completion();
        return 0;
    }
    return [self locationWithNormalAnimation];
}

- (void)normalReset
{
    self.enumerated  = NO;
    _directionChange = NO;
    _normalSteps     = 0;
}

- (void)waveReset
{
    _waveSteps = 0;
    [self normalReset];
}


@end

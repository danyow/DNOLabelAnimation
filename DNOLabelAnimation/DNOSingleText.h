//
//  DNOSingleText.h
//  DNOLabelAnimationDemo
//
//  Created by Danyow.Ed on 16/4/24.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNOSingleText : NSObject

@property (nonatomic, copy  ) NSString *text;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, assign) CGFloat  animationRange;
@property (nonatomic, assign) BOOL     enumerated;

+ (instancetype)singleTextWithAnimationRange:(CGFloat)animationRange;

- (CGFloat)locationWithFirstEnumerate;

- (CGFloat)locationWithNormalAnimation;
- (void)normalReset;

- (CGFloat)locationWithWaveAnimationCompletion:(void(^)())completion;
- (void)waveReset;

@end

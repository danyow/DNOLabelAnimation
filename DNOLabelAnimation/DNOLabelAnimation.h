//
//  DNOLabelAnimation.h
//  DNOLabelAnimationDemo
//
//  Created by Danyow.Ed on 16/4/24.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DNOLabelAnimationTypeNormal = 0,
    DNOLabelAnimationTypeWave   = 1
}DNOLabelAnimationType;

@interface DNOLabelAnimation : UILabel
@property (nonatomic, copy) NSString           *text;
@property (nonatomic, copy) NSAttributedString *attributedText;

@property (nonatomic, assign) DNOLabelAnimationType type;

@property (nonatomic, assign) CGFloat    animationHeight;
@property (nonatomic, assign) NSUInteger rate; // 1 is fastest 10 is slowest, default is 2
@property (nonatomic, assign) CGFloat    kerning;

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
- (instancetype)initWithFrame:(CGRect)frame attributedText:(NSAttributedString *)attributedText;

- (void)startAnimation;
- (void)pauseAnimation;
- (void)stopAnimation;

@end

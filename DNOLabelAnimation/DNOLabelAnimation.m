//
//  DNOLabelAnimation.m
//  DNOLabelAnimationDemo
//
//  Created by Danyow.Ed on 16/4/24.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import "DNOLabelAnimation.h"
#import "DNOSingleText.h"

//static int loopCount_ = -1;

@interface DNOLabelAnimation ()

@property (nonatomic, strong) NSMutableArray <DNOSingleText *>*allText;
@property (nonatomic, strong) CADisplayLink *time;
@property (nonatomic, assign) int loopCount;

@property (nonatomic, assign) int steps;

@end

@implementation DNOLabelAnimation

@synthesize text = _text;
@synthesize attributedText = _attributedText;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self prepare];
        [self setNeedsDisplay];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame attributedText:(NSAttributedString *)attributedText
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        self.attributedText = attributedText;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        self.text = text;
    }
    return self;
}

- (void)prepare
{
    self.loopCount = -1;
}

- (void)sizeToFit
{
    [self setFrame:({
        CGFloat x = self.frame.origin.x;
        CGFloat y = self.frame.origin.y;
        CGFloat width = self.kerning * self.allText.count;
        CGFloat height = self.font.ascender - self.font.descender + self.animationHeight;
        CGRectMake(x, y, width, height);
    })];
}
- (void)start
{
    self.steps = 0;
    self.steps ++;
    if (self.steps % 3 == 0 || self.steps % 3 == 1 ) {
        [self setNeedsDisplay];
    }
    if (self.steps > 1000) {
        self.steps = 0;
    }
}


- (void)startAnimation
{
    [self.time invalidate];
    self.time = [CADisplayLink displayLinkWithTarget:self selector:@selector(start)];
    [self.time addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pauseAnimation
{
    [self.time invalidate];
    self.time = nil;
}

- (void)stopAnimation
{
    [self.time invalidate];
    self.time = nil;
    self.loopCount = -1;
    [self.allText makeObjectsPerformSelector:@selector(normalReset)];
    [self.allText makeObjectsPerformSelector:@selector(waveReset)];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    __block CGFloat x = 0;
    __weak typeof(self) weakSelf = self;
    [self.allText enumerateObjectsUsingBlock:^(DNOSingleText *singleText, NSUInteger idx, BOOL *stop) {
        CGFloat location = 0;
        
        // 仅仅在能第一次遍历玩所有的文字的时候调用
        if (self.loopCount == idx * weakSelf.rate) {
            location = [singleText locationWithFirstEnumerate];
        }else{
            // 让其他的文字在一开始的时候不要动
            location = 0;
        }
        // 已经被遍历过的标志
        if (singleText.enumerated) {
            // 判断动画模式
            if (weakSelf.type) {
                location = [singleText locationWithWaveAnimationCompletion:^{
                    if (idx == weakSelf.allText.count - 1) {
                        [weakSelf.allText makeObjectsPerformSelector:@selector(waveReset)];
                        self.loopCount = -1;
                    }
                }];
            } else {
                location = [singleText locationWithNormalAnimation];
            }
        }
        CGFloat trueLocation = weakSelf.animationHeight - location;

        CGRect trueRect = CGRectMake(x, trueLocation, weakSelf.textSize, weakSelf.textSize);
        NSMutableDictionary *attibutes = [NSMutableDictionary dictionary];
        attibutes[NSFontAttributeName] = weakSelf.font;
        attibutes[NSForegroundColorAttributeName] = singleText.textColor;
        [singleText.text drawInRect:trueRect withAttributes:attibutes];
        x += weakSelf.kerning;
    }];
    self.loopCount ++;

}

#pragma mark -
#pragma mark setter && getter

- (CGFloat)textSize
{
    return self.font.pointSize + self.animationHeight;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    [self.allText removeAllObjects];
    for (int i = 0; i < text.length; ++i) {
        
        DNOSingleText *singleText = [DNOSingleText singleTextWithAnimationRange: text.length];
        singleText.text = [text substringWithRange:NSMakeRange(i, 1)];
        [self.allText addObject:singleText];
    }
    [self sizeToFit];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self.allText removeAllObjects];
    for (int i = 0; i < attributedText.length; ++i) {
        
        DNOSingleText *singleText = [DNOSingleText singleTextWithAnimationRange: attributedText.length];
        singleText.text = [attributedText.string substringWithRange:NSMakeRange(i, 1)];
        NSDictionary *attributed = [attributedText attributesAtIndex:i effectiveRange:nil];
        singleText.textColor = attributed[NSForegroundColorAttributeName];
        [self.allText addObject:singleText];
    }
    [self sizeToFit];
    [self setNeedsDisplay];
}

- (void)setType:(DNOLabelAnimationType)type
{
    _type = type;
    self.loopCount = -1;
    [self.allText makeObjectsPerformSelector:@selector(normalReset)];
    [self.allText makeObjectsPerformSelector:@selector(waveReset)];
}

- (CGFloat)kerning
{
    return _kerning + self.font.pointSize;
}


- (NSUInteger)rate
{
    if (!_rate) {
        _rate = 2;
    }
    if (_rate < 1) {
        _rate = 1;
    }
    if (_rate > 10) {
        _rate = 10;
    }
    return _rate;
}

//- (UIFont *)font
//{
//    if (![super font]) {
//        return [UIFont systemFontOfSize:15];
//    }
//    return [super font];
//}

@synthesize animationHeight = _animationHeight;

- (void)setAnimationHeight:(CGFloat)animationHeight
{
    _animationHeight = animationHeight + self.font.pointSize;
}

- (CGFloat)animationHeight
{
    if (!_animationHeight) {
        _animationHeight = self.font.pointSize;
    }
    return _animationHeight;
}

- (NSMutableArray<DNOSingleText *> *)allText
{
    if (!_allText) {
        _allText = [@[] mutableCopy];
    }
    return _allText;
}

@end

# DNOLabelAnimation
波浪式文字动画

![Demo.gif](https://github.com/imagons/DNOLabelAnimation/blob/master/1.gif?raw=true)

> Type 两种格式 Normal 和 Wave

```objc
typedef enum {
    DNOLabelAnimationTypeNormal = 0,
    DNOLabelAnimationTypeWave   = 1
}DNOLabelAnimationType;

```

> 创建方式 两种 frame可以设定位置和大小
  
  - 依据NSString来创建
  
```objc
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
```

  - 依据NSAttributedString来创建

```objc
- (instancetype)initWithFrame:(CGRect)frame attributedText:(NSAttributedString *)attributedText;
```

> sizeToFit 可以自适应大小

```objc
- (void)sizeToFit;
```


> 操作动画

  - 开始动画

```objc
- (void)startAnimation;
```


  - 暂停动画

```objc
- (void)pauseAnimation;
```

  - 结束动画
 
```objc
- (void)stopAnimation;
```
  
> 细节处理

- animationHeight 待处理
- rate 动画速度
- kerning 字间距 

```objc
@property (nonatomic, assign) CGFloat    animationHeight;
@property (nonatomic, assign) NSUInteger rate; // 1 is fastest 10 is slowest, default is 2
@property (nonatomic, assign) CGFloat    kerning;
```
## 安装
In your Podfile
>`pod 'DNOLabelAnimation'`

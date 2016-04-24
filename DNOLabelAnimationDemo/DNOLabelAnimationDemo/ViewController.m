//
//  ViewController.m
//  DNOLabelAnimationDemo
//
//  Created by Danyow.Ed on 16/4/24.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import "ViewController.h"
#import "DNOLabelAnimation.h"

#define myRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
#define myWidth  [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *textViews;
@property (nonatomic, assign) DNOLabelAnimationType type;

@end

@implementation ViewController
- (IBAction)typeChange:(UISegmentedControl *)sender
{
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        [self.textViews makeObjectsPerformSelector:@selector(setType:) withObject:nil];
            break;
        case 1:
        [self.textViews makeObjectsPerformSelector:@selector(setType:) withObject:@(1)];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo1];
    [self demo2];
    [self demo3];
    [self demo4];
    [self demo5];
}


- (void)buttonDidClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.textViews[sender.tag - 1] startAnimation];
    }else{
        [self.textViews[sender.tag - 1] stopAnimation];
        //[self.textViews[sender.tag - 1] pauseAnimation];
    }
}

- (void)getButtonWithPoint:(CGPoint)point tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(point.x, point.y, 60, 30);
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"start" forState:UIControlStateNormal];
    [button setTitle:@"pause" forState:UIControlStateSelected];
    [self.view addSubview:button];
    button.tag = tag;
}

- (void)demo1 {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : myRandomColor};
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"一一一一一一一一一一一一一" attributes:attribute];
    
    [string addAttribute:NSForegroundColorAttributeName value:myRandomColor range:NSMakeRange(2, 2)];
    [string addAttribute:NSForegroundColorAttributeName value:myRandomColor range:NSMakeRange(4, 2)];
    [string addAttribute:NSForegroundColorAttributeName value:myRandomColor range:NSMakeRange(6, 2)];
    [string addAttribute:NSForegroundColorAttributeName value:myRandomColor range:NSMakeRange(8, 2)];
    
    DNOLabelAnimation *textView = [[DNOLabelAnimation alloc] initWithFrame:CGRectMake(20, 60, 0, 0) attributedText:string];
    
    [textView sizeToFit];
    [self.view addSubview:textView];
    [self.textViews addObject:textView];
    [self getButtonWithPoint:CGPointMake(myWidth - 60, 60) tag:1];
}

- (void)demo2 {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : myRandomColor};
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"ABCDEFGHIJ" attributes:attribute];
    
    DNOLabelAnimation *textView = [[DNOLabelAnimation alloc] initWithFrame:CGRectMake(20, 120, 0, 0) attributedText:string];

    textView.type = self.type;
    textView.font = [UIFont systemFontOfSize:30];
    [textView sizeToFit];
    
    [self.view addSubview:textView];
    [self.textViews addObject:textView];
    
    [self getButtonWithPoint:CGPointMake(myWidth - 60, 120) tag:2];
}

- (void)demo3 {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : myRandomColor};
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"abcdefghij" attributes:attribute];
    DNOLabelAnimation *textView = [[DNOLabelAnimation alloc] initWithFrame:CGRectMake(20, 180, 0, 0) attributedText:string];

    textView.type = self.type;
    textView.font = [UIFont fontWithName:@"Courier" size:30];
    textView.rate = 1;
    [textView sizeToFit];
    [self.view addSubview:textView];
    [self.textViews addObject:textView];
    
    [self getButtonWithPoint:CGPointMake(myWidth - 60, 180) tag:3];
}

- (void)demo4 {
    
    DNOLabelAnimation *textView = [[DNOLabelAnimation alloc] initWithFrame:CGRectMake(20, 240, 0, 0) text:@"黑化肥会挥发"];

    textView.type = self.type;
    textView.font = [UIFont fontWithName:@"Courier" size:30];
    textView.rate = 10;
    [textView sizeToFit];
    [self.view addSubview:textView];
    [self.textViews addObject:textView];
    
    [self getButtonWithPoint:CGPointMake(myWidth - 60, 240) tag:4];
}

- (void)demo5 {
    
    DNOLabelAnimation *textView = [[DNOLabelAnimation alloc] initWithFrame:CGRectMake(20, 300, 0, 0) text:@"做人呢,最重要的就是不能让别人开心."];
    
    textView.type = self.type;
    textView.font = [UIFont systemFontOfSize:10];
    textView.kerning = 4;
    [textView sizeToFit];
    [self.view addSubview:textView];
    [self.textViews addObject:textView];
    
    [self getButtonWithPoint:CGPointMake(myWidth - 60, 300) tag:5];
}

- (NSMutableArray *)textViews
{
    if (!_textViews) {
        _textViews = [[NSMutableArray alloc] init];
    }
    return _textViews;
}

@end

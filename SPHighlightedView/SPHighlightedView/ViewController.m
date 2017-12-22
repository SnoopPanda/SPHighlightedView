//
//  ViewController.m
//  SPHighlightedView
//
//  Created by WangJie on 2017/12/22.
//  Copyright © 2017年 WangJie. All rights reserved.
//

#import "ViewController.h"
#import "SPHighlightedView.h"
#import "Masonry.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) SPHighlightedView *highlightedView;
@property (nonatomic, strong) UITextView *originXText;
@property (nonatomic, strong) UITextView *widthText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-200, SCREEN_HEIGHT)];
    containerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:containerView];
    self.containerView = containerView;

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.center = self.view.center;

    self.originXText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 130, 40)];
    self.originXText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.originXText];
    self.originXText.center = CGPointMake(self.view.center.x, 210);

    self.widthText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 130, 40)];
    self.widthText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.widthText];
    self.widthText.center = CGPointMake(self.view.center.x, 300);
}

- (void)start {
    
    CGFloat x = self.originXText.text.floatValue  ;
    CGFloat width = self.widthText.text.floatValue;
    
    if (x < 100) {
        NSLog(@"必须 >= 100");
        return;
    }
    
    SPHighlightedView *coverView = [[SPHighlightedView alloc] initWithFrame:self.view.frame transRect:CGRectMake(x, 300, width, 100) containerWidth:self.containerView.frame.size.width margin:100];
    [self.view addSubview:coverView];
}


@end

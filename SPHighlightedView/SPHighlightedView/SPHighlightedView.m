//
//  SPHighlightedView.m
//  SPHighlightedView
//
//  Created by WangJie on 2017/12/22.
//  Copyright © 2017年 WangJie. All rights reserved.
//

#import "SPHighlightedView.h"
#import "Masonry.h"

@interface SPHighlightedView () {
    CGFloat _margin;
    CGRect _transRect;
    BOOL _isBubbleLeft;
}

@property (nonatomic, strong) UIButton *operationBoard;
@property (nonatomic, strong) UIImageView *bubble1;
@property (nonatomic, strong) UIImageView *bubble2;
@end

@implementation SPHighlightedView

- (instancetype)initWithFrame:(CGRect)frame
                    transRect:(CGRect)rect
               containerWidth:(CGFloat)width
                       margin:(CGFloat)margin {
    self = [super initWithFrame:frame];
    if (self) {
        _transRect = rect;
        _margin = margin;
        
        [self generateTransLayerWithTransRect:rect];
        [self addSubview:self.operationBoard];
        [self addSubview:self.bubble1];
        [self addSubview:self.bubble2];
        
        if (rect.size.width < width*0.5) {
            if(rect.origin.x+rect.size.width*0.5 < margin+width*0.5) {
                _isBubbleLeft = YES;
            }else {
                _isBubbleLeft = NO;
            }
        }else {
            if (rect.origin.x+rect.size.width < margin+width*0.75) {
                _isBubbleLeft = YES;
            }else {
                _isBubbleLeft = NO;
            }
        }
        
        [self layoutContentView];
    }
    return self;
}

#pragma mark - Private

- (void)generateTransLayerWithTransRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *transPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:8];
    [path appendPath:transPath];
    path.usesEvenOddFillRule = YES;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillRule =kCAFillRuleEvenOdd;
    layer.fillColor = [UIColor blackColor].CGColor;
    layer.opacity = 0.5;
    [self.layer addSublayer:layer];
}

- (void)layoutContentView {
    
    [_operationBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(_transRect.origin.y-44-20);
        make.width.mas_equalTo(@(644.53));
        make.height.mas_equalTo(@(44));
        if (_isBubbleLeft) {
            make.left.equalTo(_bubble1.mas_left).offset(-25).priorityLow();
            make.right.mas_lessThanOrEqualTo(50-_margin).priorityHigh();
        }else {
            make.right.equalTo(_bubble1.mas_right).offset(25).priorityLow();
            make.left.mas_greaterThanOrEqualTo(_margin-50).priorityHigh();
        }
    }];
    
    if (_isBubbleLeft) {
        
        [_bubble1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_operationBoard.mas_bottom);
            make.width.mas_equalTo(14.51);
            make.height.mas_equalTo(8);
            make.right.equalTo(_bubble2.mas_left);
        }];
        
        [_bubble2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bubble1.mas_bottom).offset(3);
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(6);
            make.left.offset(_transRect.origin.x-5);
        }];
        
    }else {
        [_bubble1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_operationBoard.mas_bottom);
            make.width.mas_equalTo(14.51);
            make.height.mas_equalTo(8);
            make.left.equalTo(_bubble2.mas_right);
        }];
        
        [_bubble2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bubble1.mas_bottom).offset(3);
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(6);
            make.left.offset(_transRect.origin.x+_transRect.size.width+5);
        }];
    }
}

- (void)closeSelf {
    [self removeFromSuperview];
}

#pragma mark - Lazy load
- (UIButton *)operationBoard {
    if (!_operationBoard) {
        _operationBoard = [[UIButton alloc] init];
        _operationBoard.backgroundColor = [UIColor whiteColor];
        _operationBoard.layer.cornerRadius = 22;
        _operationBoard.clipsToBounds = YES;
        [_operationBoard addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationBoard;
}

- (UIImageView *)bubble1 {
    if (!_bubble1) {
        _bubble1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bubble1"]];
    }
    return _bubble1;
}

- (UIImageView *)bubble2 {
    if (!_bubble2) {
        _bubble2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bubble2"]];
    }
    return _bubble2;
}

@end

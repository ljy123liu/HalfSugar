//
//  TitleScrollView.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "TitleScrollView.h"
#import "Const.h"
#import <Masonry.h>
#import "UIView+Extension.h"
@interface TitleScrollView ()
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIScrollView *titleScrollView;
@property (nonatomic,assign) CGFloat itemWidth;
@end

@implementation TitleScrollView
- (instancetype)initWithTitleArray:(NSArray *)titleArray itemWidth:(CGFloat)itemWidth {
    if (self = [super init]) {
        self.itemWidth = itemWidth;
        _titleScrollView = [UIScrollView new];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_titleScrollView];
        
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_titleScrollView addSubview:_contentView];
        
        for (NSInteger i = 0; i < titleArray.count; i++) {
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = titleArray[i];
            titleLabel.font = [UIFont fontWithName:ThinFont size:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.userInteractionEnabled = YES;
            titleLabel.highlightedTextColor = [UIColor redColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClicked:)];
            [titleLabel addGestureRecognizer:tap];
            titleLabel.tag = i;
            [_contentView addSubview:titleLabel];
        }
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor redColor];
        [_contentView addSubview:_lineView];
        
        [_titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_titleScrollView);
            make.height.equalTo(_titleScrollView.mas_height);
        }];
        
        UILabel *lastLabel;
        for (NSInteger i = 0; i < _contentView.subviews.count - 1; i++) {
            UILabel *label = _contentView.subviews[i];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(lastLabel? lastLabel.mas_trailing : @0);
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(30);
                make.centerY.equalTo(self);
            }];
            lastLabel = label;
        }
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(lastLabel);
        }];
        
        UILabel *firstLabel = _contentView.subviews[0];
        firstLabel.highlighted = YES;
        firstLabel.font = [UIFont fontWithName:ThinFont size:14];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemWidth * 0.6);
            make.height.mas_equalTo(2);
            make.centerX.equalTo(firstLabel);
            make.top.equalTo(firstLabel.mas_bottom);
        }];
    }
    return self;
}

- (void)titleLabelClicked:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    [self titleScrollViewScrollTo:index];
    if (self.delegate) {
        [self.delegate titleScrollView:self didSelectedAtIndex:index];
    }
}

- (void)titleScrollViewScrollTo:(NSInteger)index {
    for (NSInteger i = 0; i < _contentView.subviews.count; i++) {
        UILabel *label = _contentView.subviews[i];
        label.highlighted = NO;
        label.font = [UIFont fontWithName:ThinFont size:14];
    }
    
    UILabel *label = self.contentView.subviews[index];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.itemWidth * 0.6);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(label);
        make.top.equalTo(label.mas_bottom);
    }];
    [self.lineView setNeedsLayout];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.lineView layoutIfNeeded];
        label.highlighted = YES;
        label.font = [UIFont fontWithName:ThinFont size:14];
    }];
    
    //当能够滑动的时候才设置偏移量
    if (self.titleScrollView.contentSize.width  > self.titleScrollView.width) {
        CGFloat leftOffset = CGRectGetMidX(label.frame) - CGRectGetWidth(self.bounds) / 2;
        CGFloat rightOffset = CGRectGetWidth(self.bounds) / 2 + CGRectGetMidX(label.frame) - CGRectGetWidth(self.contentView.frame);
        //偏移量
        if (leftOffset >= 0 && rightOffset <= 0) {
            [self.titleScrollView setContentOffset:CGPointMake(leftOffset, 0) animated:YES];
        }else {
            [self.titleScrollView setContentOffset:CGPointMake((leftOffset >= 0? :0), 0) animated:YES];
            [self.titleScrollView setContentOffset:CGPointMake((rightOffset <= 0? :CGRectGetWidth(self.contentView.frame) - CGRectGetWidth(self.bounds)), 0) animated:YES];
        }
    }
}



@end

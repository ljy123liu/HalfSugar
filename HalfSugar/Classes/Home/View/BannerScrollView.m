//
//  BannerScrollView.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "BannerScrollView.h"
#import "UIColor+Extension.h"
#import "Const.h"
#import "UIImageView+Extension.h"
#import "UIView+Extension.h"
@interface BannerScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray <NSString *> *images;
@property (nonatomic, strong) UIImage *placeHolderImage;
@end

//循环使用的imageView的个数
static const NSInteger MaxImageViewCount = 3;
@implementation BannerScrollView

+ (instancetype)pageScollView:(NSArray<NSString *> *)images placeHolder:(UIImage *)placeHolderImage {
    BannerScrollView *banner = [BannerScrollView new];
    banner.images = images;
    banner.placeHolderImage = placeHolderImage;
    return banner;
}

#pragma mark - UI
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageScrollView =({
            UIScrollView *view = [UIScrollView new];
            view.showsHorizontalScrollIndicator = NO;
            view.showsVerticalScrollIndicator = NO;
            view.pagingEnabled = YES;
            view.bounces = NO;
            view.delegate = self;
            view;
        });
        [self addSubview:self.imageScrollView];
        for (NSInteger i = 0; i < MaxImageViewCount; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageScrollView addSubview:imageView];
        }
        self.pageControl = [UIPageControl new];
        self.pageControl.currentPageIndicatorTintColor = [UIColor getColor:CustomBarTintColor];
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageScrollView.frame = self.bounds;
    CGFloat imageScrollViewW = self.imageScrollView.width;
    CGFloat imageScrollViewH = self.imageScrollView.height;
    self.imageScrollView.contentSize = CGSizeMake(imageScrollViewW * MaxImageViewCount, 0);
    for (NSInteger i = 0; i < self.imageScrollView.subviews.count; i++) {
        UIImageView *imageView = self.imageScrollView.subviews[i];
        imageView.frame = CGRectMake(i * imageScrollViewW, 0, imageScrollViewW, imageScrollViewH);
    }
    self.pageControl.frame = CGRectMake(0, imageScrollViewH - 20, imageScrollViewW, 20);
    [self addCurveLayer];
    [self addSubview:self.pageControl];
    [self updateBannerScrollView];
}

//banner下面的弧线形
- (void)addCurveLayer {
    CGFloat layerHeight = 40;
    CGFloat pageScollViewW = self.bounds.size.width;
    CGFloat pageScollViewH = self.bounds.size.height;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, pageScollViewH)];
    [path addQuadCurveToPoint:CGPointMake(pageScollViewW, pageScollViewH) controlPoint:CGPointMake(pageScollViewW / 2, pageScollViewH - layerHeight)];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];
}

//更新banner
- (void)updateBannerScrollView {
    for (NSInteger i = 0; i<self.imageScrollView.subviews.count; i++) {
        UIImageView *imageView = self.imageScrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index --;
        }else if(i == 2){
            index ++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        }else if(index > self.pageControl.numberOfPages - 1){
            index = 0;
        }
        imageView.tag = index;
        [imageView setImageWithURL:[NSURL URLWithString:self.images[index]] placeholderImage:self.placeHolderImage animate:NO];
    }
    self.imageScrollView.contentOffset = CGPointMake(self.imageScrollView.frame.size.width, 0);
}

- (void)setImages:(NSArray<NSString *> *)images {
    _images = images;
    _pageControl.numberOfPages = images.count;
    _pageControl.currentPage = 0;
    [self stopTimer];
    [self startTimer];
    [self updateBannerScrollView];
}

#pragma mark - Timer
- (void)startTimer {
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}


- (void)stopTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)next {
    [self.imageScrollView setContentOffset:CGPointMake(self.imageScrollView.width * 2, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minDistance = MAXFLOAT;
    NSInteger page = 0;
    for (NSInteger i = 0; i<self.imageScrollView.subviews.count; i++) {
        UIImageView *imageView = self.imageScrollView.subviews[i];
        /**
         *
         int abs(int i);                   处理int类型的取绝对值
         double fabs(double i);            处理double类型的取绝对值
         float fabsf(float i);             处理float类型的取绝对值
         */
        CGFloat distance = fabs(self.imageScrollView.contentOffset.x - imageView.frame.origin.x);
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateBannerScrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateBannerScrollView];
}

#pragma mark - EvenResopnses
- (void)imageViewClicked:(UITapGestureRecognizer *)tap {
    
}

@end

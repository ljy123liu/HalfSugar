//
//  HomeHeadView.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "HomeHeadView.h"
#import "BannerScrollView.h"
#import "HomeHotView.h"
#import <Masonry.h>
@interface HomeHeadView ()
@property (nonatomic,strong) HomeHotView *hotView;
@end

@implementation HomeHeadView
- (instancetype)initWithHomeData:(HomeModel *)homeData {
    if (self = [super init]) {
        NSMutableArray *bannerImages = [NSMutableArray array];
        [homeData.banners enumerateObjectsUsingBlock:^(HomeModelElemen *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [bannerImages addObject:obj.photo];
        }];
        BannerScrollView *pageView = [BannerScrollView pageScollView:bannerImages placeHolder:nil];
        [self addSubview:pageView];
        
        NSMutableArray *titles = [NSMutableArray array];
        NSMutableArray *images = [NSMutableArray array];
        [homeData.hotItems enumerateObjectsUsingBlock:^(HomeModelElemen *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [titles addObject:obj.title];
            [images addObject:obj.photo];
        }];
        HomeHotView *hotView = [[HomeHotView alloc]initWithTitles:titles images:images];
        [self addSubview:hotView];
        self.hotView = hotView;
        [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Width * 0.5);
            make.leading.top.trailing.equalTo(self);
        }];
        
        [hotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pageView.mas_bottom);
            make.leading.trailing.bottom.equalTo(self);
        }];
    }
    return self;
}


- (CGFloat)height {
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.hotView.frame);
}
@end

//
//  TitleScrollView.h
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleScrollView;
@protocol TitleScrollViewDelegate <NSObject>

- (void)titleScrollView:(TitleScrollView *)titleScrollView didSelectedAtIndex:(NSInteger)index;

@end

@interface TitleScrollView : UIView
@property (nonatomic, weak) id <TitleScrollViewDelegate> delegate;
- (instancetype)initWithTitleArray:(NSArray *)titleArray itemWidth:(CGFloat)itemWidth;
- (void)titleScrollViewScrollTo:(NSInteger)index;
@end

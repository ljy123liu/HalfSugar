//
//  HomeHeadView.h
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeHeadView : UIView
@property (nonatomic,assign) CGFloat height;
- (instancetype)initWithHomeData:(HomeModel *)homeData;
@end

//
//  HomeModel.h
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
@class HomeModelElemen;
@interface HomeModel : NSObject

@property (nonatomic,strong) NSArray *topics;
@property (nonatomic,strong) NSArray *categories;
@property (nonatomic,strong) NSArray <HomeModelElemen *> *hotItems;
@property (nonatomic,strong) NSArray *banners;

+ (void)loadHomeData:(Completelock)complete ;
@end


@interface HomeModelElemen : NSObject
@property (nonatomic,copy) NSString *hid;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *sub_title;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *is_show_like;
@property (nonatomic,copy) NSString *likes;
@property (nonatomic,copy) NSString *pic;
@end


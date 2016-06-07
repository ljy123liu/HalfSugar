//
//  HomeModel.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "HomeModel.h"
#import <MJExtension.h>
@implementation HomeModel
+ (void)loadHomeData:(Completelock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeData" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    HomeModel *homeData = [HomeModel mj_objectWithKeyValues:dic[@"data"]];
    complete(homeData,nil);
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"topics":@"HomeDataElemen",
             @"categories":@"HomeDataElemen",
             @"hotItems":@"HomeDataElemen",
             @"banners":@"HomeDataElemen"
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"topics":@"topic",
             @"categories":@"category_element",
             @"hotItems":@"banner_bottom_element",
             @"banners":@"banner"
             };
}
@end

@implementation HomeModelElemen

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"hid":@"id"};
}

@end

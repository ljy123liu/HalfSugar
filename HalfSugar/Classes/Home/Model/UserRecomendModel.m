//
//  UserRecomendModel.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "UserRecomendModel.h"
#import <MJExtension.h>

@implementation UserRecomendModel
+ (void)loadUserRecomendData:(Completelock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user_recomend" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    UserRecomendModel *recomendData = [UserRecomendModel mj_objectWithKeyValues:dic[@"data"]];
    complete(recomendData.list,nil);
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":NSStringFromClass([UserRecomend class])};
}
@end

@implementation TagModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"tid":@"id"};
}
@end

@implementation UserRecomend

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"rid":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"comments":NSStringFromClass([CommentModel class]),
             @"pics":NSStringFromClass([RecomendPicModel class]),
             @"product":NSStringFromClass([RelateProductModel class]),
             @"tags":NSStringFromClass([TagModel class])
             };
}


@end
@implementation RecomendPicModel


@end

@implementation RelateProductModel


@end

@implementation DynamicModel



@end

@implementation AuthorModel


@end


@implementation CommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cid":@"id"};
}
@end


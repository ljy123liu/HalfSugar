//
//  TopicDetailModel.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "TopicDetailModel.h"
#import <MJExtension.h>
@implementation TopicDetailModel

+ (void)loadTopicData:(Completelock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_detail" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    TopicDetailModel *topicData = [TopicDetailModel mj_objectWithKeyValues:dic];
    complete(topicData.data,nil);
}

@end

@implementation HomeTopicModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"product":NSStringFromClass([ProductDetailModel class])};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"tid":@"id"};
}

@end

@implementation ProductDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic":NSStringFromClass([PicModel class]),
             @"likes_list":NSStringFromClass([LikeModel class])
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"pid":@"id"};
}

@end

@implementation PicModel



@end

@implementation LikeModel


@end

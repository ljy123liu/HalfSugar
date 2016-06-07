//
//  UserRecomendModel.h
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
@class DynamicModel;
@class AuthorModel;
@class CommentModel;
@class RecomendPicModel;
@class RelateProductModel;

@interface UserRecomendModel : NSObject
@property (nonatomic,strong) NSArray *list;
+ (void)loadUserRecomendData:(Completelock)complete;

@end

@interface UserRecomend : NSObject
@property (nonatomic,copy  ) NSString         *rid;
@property (nonatomic,copy  ) NSString         *content;
@property (nonatomic,strong) NSArray          *tags;
@property (nonatomic,copy  ) NSString         *i_tags;
@property (nonatomic,copy  ) NSString         *datestr;
@property (nonatomic,strong) NSArray <RecomendPicModel *> *pics;
@property (nonatomic,strong) DynamicModel     *dynamic;
@property (nonatomic,strong) NSArray <RelateProductModel *> *product;
@property (nonatomic,strong) AuthorModel      *author;
@property (nonatomic,strong) NSArray <CommentModel*> *comments;
@end


@interface TagModel : NSObject
@property (nonatomic,copy) NSString *tid;
@property (nonatomic,copy) NSString *name;
@end

@interface RecomendPicModel : NSObject
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *tags;
@property (nonatomic,copy) NSString *width;
@property (nonatomic,copy) NSString *height;
@end

@interface RelateProductModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *platform;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *pic;
@end

@interface DynamicModel : NSObject
@property (nonatomic,copy) NSString *views;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *likes;
@property (nonatomic,copy) NSString *posts;
@end

@interface AuthorModel : NSObject
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *avatar;
@end

@interface CommentModel : NSObject
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *conent;
@property (nonatomic,copy) NSString *datestr;
@property (nonatomic,strong) AuthorModel *at_user;
@property (nonatomic,strong) RelateProductModel *product;
@property (nonatomic,copy) NSString *is_official;
@end
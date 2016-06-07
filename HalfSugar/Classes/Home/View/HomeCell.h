//
//  HomeCell.h
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeCell : UITableViewCell
@property (nonatomic,strong) UIImageView *bigImageView;
@property (nonatomic,strong) HomeModelElemen *topic;
@property (nonatomic,assign) CGFloat height;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

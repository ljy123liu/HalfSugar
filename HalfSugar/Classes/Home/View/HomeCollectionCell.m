//
//  HomeCollectionCell.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/7.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "HomeCollectionCell.h"
#import "HomeCell.h"

@interface HomeCollectionCell () <UITableViewDataSource>
@property (nonatomic, assign) CGFloat homeCellHeight;
@end

@implementation HomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = self.homeCellHeight;
        [self addSubview:_tableView];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [HomeCell cellWithTableView:tableView];
    cell.topic = self.topics[indexPath.row];
    return cell;
}
- (CGFloat)homeCellHeight {
    if (!_homeCellHeight) {
        _homeCellHeight = [[HomeCell alloc]init].height;
    }
    return  _homeCellHeight;
}


@end

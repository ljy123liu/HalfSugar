//
//  HomeViewController.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/5.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleScrollView.h"
#import "HomeModel.h"
#import "HomeHeadView.h"
#import "HomeCollectionCell.h"
#import "HomeScrollView.h"
#import "UINavigationBar+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "HomePushTransitionAnimator.h"
#import "ProductDetailControler.h"
#import "Const.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
/** 滚动标题的高度  */
static const CGFloat kTitleVewHeight = 40;
/** 滚动标题每个item的宽度  */
static const CGFloat kTitleViewItemWidth = 64;
/** 焦点按钮与下面的距离  */
static const CGFloat kHotViewMargin = 10;

@interface HomeViewController ()<UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,TitleScrollViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) HomeModel *homeData;
@property (nonatomic, strong) TitleScrollView *titleView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) HomeScrollView *mainScrollView;
@property (nonatomic, strong) HomeHeadView *headView;
@property (nonatomic, assign) BOOL canScrollViewScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, assign) BOOL canTableViewScroll;
/** navigationBar的alpha值 */
@property (nonatomic, assign) CGFloat navigationBarAlpha;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initNavigationbar];
    [self initMainScrollView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar zz_setBackgroundColor:[[UIColor getColor:CustomBarTintColor] colorWithAlphaComponent:self.navigationBarAlpha]];
    [self.navigationController.navigationBar zz_setElementAlpha:self.navigationBarAlpha];
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar zz_reset];
}

- (void)initNavigationbar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"半糖";
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel sizeToFit];
    self.navigationItem.titleView = nameLabel;
    
    UIBarButtonItem *searchItem = [UIBarButtonItem barBtnItemWithNmlImg:@"searchBtn" hltImg:@"searchBtn" target:self action:@selector(searchBtnCliked)];
    UIBarButtonItem *signItem = [UIBarButtonItem barBtnItemWithNmlImg:@"SignIn_normal" hltImg:@"SignIn_highLight" target:self action:@selector(searchBtnCliked)];
    self.navigationItem.leftBarButtonItem = searchItem;
    self.navigationItem.rightBarButtonItem = signItem;
}

- (void)initMainScrollView {
    self.mainScrollView = [[HomeScrollView alloc]init];
    self.mainScrollView.delegate = self;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.contentView = [[UIView alloc]init];
    [self.mainScrollView addSubview:self.contentView];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];
}

- (void)buildContentView {
    self.headerView = [[UIView alloc]init];
    HomeHeadView *headView = [[HomeHeadView alloc]initWithHomeData:self.homeData];
    [self.headerView addSubview:headView];
    
    NSMutableArray *categoryTitles = [NSMutableArray array];
    [self.homeData.categories enumerateObjectsUsingBlock:^(HomeModelElemen *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [categoryTitles addObject:obj.title];
    }];
    self.titleView = [[TitleScrollView alloc]initWithTitleArray:categoryTitles itemWidth:kTitleViewItemWidth];
    self.titleView.delegate = self;
    [self.headerView addSubview:self.titleView];
    
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.headerView);
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.headerView);
        make.height.mas_equalTo(45);
    }];
    
    
    [self.contentView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.leading.trailing.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(Height - NavigationBarHeight- kTitleVewHeight - TabbarBottomHeight);
    }];
    
}

- (UICollectionView *)mainCollectionView {
    if (_mainCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView = ({
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            view.pagingEnabled = YES;
            view.backgroundColor = [UIColor whiteColor];
            view.dataSource = self;
            view.delegate = self;
            view.bounces = NO;
            [view registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeCollectionCell class])];
            view;
        });
    }
    return _mainCollectionView;
}

- (void)loadData{
    [HomeModel loadHomeData:^(HomeModel *data, NSError *error) {
        self.homeData = data;
        [self buildContentView];
    }];
}

- (void)searchBtnCliked {
    
}

#pragma collectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeData.categories.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeCollectionCell class]) forIndexPath:indexPath];
    cell.topics = self.homeData.topics;
    cell.tableView.delegate = self;
    self.currentTableView = cell.tableView;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.mainCollectionView.bounds.size;
}


#pragma tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:[ProductDetailControler new] animated:YES];
}

#pragma scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        NSInteger index = scrollView.contentOffset.x / Width;
        [self.titleView titleScrollViewScrollTo:index];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        self.mainScrollView.scrollEnabled = NO;
    }
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (!self.canTableViewScroll) {
            [scrollView setContentOffset:CGPointZero];
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY<0) {
            self.canScrollViewScroll = YES;
            [scrollView setContentOffset:CGPointZero];
            self.canTableViewScroll = NO;
        }
        
    }
    if ([scrollView isEqual:self.mainScrollView]) {
        self.navigationBarAlpha = scrollView.contentOffset.y /(self.headerView.frame.size.height - NavigationBarHeight - kTitleVewHeight);
        [self.navigationController.navigationBar zz_setBackgroundColor:[[UIColor getColor:CustomBarTintColor] colorWithAlphaComponent:self.navigationBarAlpha]];
        [self.navigationController.navigationBar zz_setElementAlpha:self.navigationBarAlpha];
        
        
        CGFloat tabOffsetY = self.headerView.frame.size.height - NavigationBarHeight - kTitleVewHeight;
        CGFloat offsetY = scrollView.contentOffset.y;
        _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
        if (offsetY>=tabOffsetY) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            _isTopIsCanNotMoveTabView = YES;
        }else{
            _isTopIsCanNotMoveTabView = NO;
        }
        if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
            if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
                self.canTableViewScroll =YES;
                self.canScrollViewScroll = NO;
            }
            if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
                
                if (!self.canScrollViewScroll) {
                    scrollView.contentOffset = CGPointMake(0, tabOffsetY);
                }
            }
        }
    }
    self.mainScrollView.scrollEnabled= YES;
}

#pragma titleScrollView delegate
- (void)titleScrollView:(TitleScrollView *)titleScrollView didSelectedAtIndex:(NSInteger)index {
    [self.mainCollectionView setContentOffset:CGPointMake(Width * index, 0) animated:YES];
}

- (void)signBtnCliked{}
#pragma <UINavigationControllerDelegate> 转场动画相关

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return [HomePushTransitionAnimator new];
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

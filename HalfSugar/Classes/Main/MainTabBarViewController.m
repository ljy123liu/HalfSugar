//
//  MainTabBarViewController.m
//  HalfSugar
//
//  Created by LIUYONG on 16/6/5.
//  Copyright © 2016年 WanJianTechnology. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainNavigationViewController.h"
#import "HomeViewController.h"
#import "SquareViewController.h"
#import "MessageViewController.h"
#import "PersonalCenterViewController.h"
#import "PhotoController.h"
#import "AppSignView.h"
@interface MainTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self buildTabbarController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addSingView];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI
- (void)buildTabbarController {
    [self addChildViewController:[HomeViewController new]
                           image:[UIImage imageNamed:@"tab_0"]
                   selectedImage:[[UIImage imageNamed:@"tab_c0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             tag:0];
    [self addChildViewController:[SquareViewController new]
                           image:[UIImage imageNamed:@"tab_1"]
                   selectedImage:[[UIImage imageNamed:@"tab_c1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             tag:1];
    [self addChildViewController:[UIViewController new]
                           image:[UIImage imageNamed:@"tab_c0"]
                   selectedImage:[[UIImage imageNamed:@"tab_c0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             tag:2];
    [self addChildViewController:[MessageViewController new]
                           image:[UIImage imageNamed:@"tab_c2"]
                   selectedImage:[[UIImage imageNamed:@"tab_c2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             tag:3];
    [self addChildViewController:[PersonalCenterViewController new]
                           image:[UIImage imageNamed:@"tab_3"]
                   selectedImage:[[UIImage imageNamed:@"tab_c3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             tag:4];
}

- (void)addChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {
    UITabBarItem *item = [UITabBarItem new];
    item.image = image;
    item.title = nil;
    item.tag = tag;
    item.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    item.selectedImage = selectedImage;
    viewController.tabBarItem = item;
    MainNavigationViewController *navController = [[MainNavigationViewController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navController];
}

- (void)addSingView {
    AppSignView *signView = [[AppSignView  alloc]initWithFrame:[UIScreen mainScreen].bounds];
    signView.url = @"http://7xiwnz.com2.z0.glb.qiniucdn.com/signin/20160425-bg1.jpg";
    [[UIApplication sharedApplication].keyWindow addSubview:signView];
}

#pragma makr - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController.tabBarItem.tag == 2) {
        MainNavigationViewController *nav = [[MainNavigationViewController alloc]initWithRootViewController:[PhotoController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    return YES;
}


@end

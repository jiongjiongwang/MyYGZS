//
//  MainController.m
//  HomeDemo
//
//  Created by dn210 on 16/11/16.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "MainController.h"
#import "HomeViewController.h"
#import "SecondController.h"
#import "MyInfoController.h"


@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置子控制器
    [self setUpControllers];
    
    
    //1-设置一个什么图片都没有的bgImg当做tabBar的背景图片！！！
    UIImage *bgImg = [[UIImage alloc] init];
    [self.tabBar setBackgroundImage:bgImg];
    [self.tabBar setShadowImage:bgImg];
    
    //2-自定义一个backView,并设置backView为半透明(alpha设置为0.5）
    UIView *backView = [[UIView alloc] init];
    
    backView.backgroundColor = [UIColor blueColor];
    
    backView.frame = self.tabBar.bounds;
    
    backView.alpha = 0.5;
    
    //3-将自定义的backView插入到当前的tabBar当中
    [self.tabBar insertSubview:backView atIndex:0];
    
    //接受隐藏tabbar的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HideTabBar:) name:@"hideTabBar" object:nil];
}

//接受隐藏tabbar的通知
-(void)HideTabBar:(NSNotification *)notification
{
    //取值
    NSUInteger isHideTabBar = [notification.userInfo[@"hide"] integerValue];
    
    if (isHideTabBar)
    {
        self.tabBar.hidden = YES;
    }
    else
    {
        self.tabBar.hidden = NO;
    }
    

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//设置子控制器
-(void)setUpControllers
{
    //1-home界面
    [self addChildController:[[HomeViewController alloc] init] WithTitle:@"音色" WithImageName:@"tab1"];
    
    //2-第二个界面
    [self addChildController:[[SecondController alloc] init] WithTitle:@"求谱" WithImageName:@"tab2"];
    
    //3-我的信息界面
    [self addChildController:[[MyInfoController alloc] init]WithTitle:@"我的" WithImageName:@"tab3"];
    
}

//根据图片和名来添加子控制器
-(void)addChildController:(UIViewController *)childVc WithTitle:(NSString *)title WithImageName:(NSString *)imageName
{
    childVc.title = title;
    
    //设置tabBar图片
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置点击图片
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置富文本文字颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    
    
    //添加到tabbarVC上
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:childVc]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

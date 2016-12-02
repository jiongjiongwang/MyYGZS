//
//  HomeViewController.m
//  HomeDemo
//
//  Created by dn210 on 16/11/16.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "HomeViewController.h"
#import "Masonry.h"
#import "HomeViewCell.h"
#import "SecondViewCell.h"


@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//1-navigation背景
@property (nonatomic,weak)UIView *naviBackView;


//2-音色按钮
@property (nonatomic,weak)UIButton *leftButton;

//3-友鼓按钮
@property (nonatomic,weak)UIButton *rightButton;

//4-按钮下面的横线
@property (nonatomic,weak)UIView *lineView;


//5-collectionView的flowLayout
@property (nonatomic,weak)UICollectionViewFlowLayout *flowLayout;

//6-collectionView
@property (nonatomic,weak)UICollectionView *homeCollectionView;

//按钮数组
@property (nonatomic,strong)NSArray *buttonArray;


@end

@implementation HomeViewController

static NSString *collectionIdentifier = @"collectCell";

static NSString *secondCollectionIdentifier = @"secondCell";

-(NSArray<UIButton *> *)buttonArray
{
    if (_buttonArray == nil)
    {
        _buttonArray = @[self.leftButton,self.rightButton];
    }
    
    return _buttonArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //将系统的NavigationController隐藏掉
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    //NavigationController的触发事件取消掉
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    //自定义navigationController
    [self setNav];
    
    //设置位于中下部的collectionView
    [self setUpCollectionView];
}

//自定义navigationController
-(void)setNav
{
    //1-主题背景(UIView)
    UIView *naviBackView = [[UIView alloc] init];
    
    self.naviBackView = naviBackView;
    
    naviBackView.backgroundColor = [UIColor redColor];
    //naviBackView.backgroundColor = [UIColor colorWithRed:221/255 green:42/255 blue:65/255 alpha:1];
    
    
    
    [self.view addSubview:naviBackView];
    
    [naviBackView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.top.trailing.equalTo(self.view);
        
        make.height.equalTo(@80);
        
    }];
    
    
    
    //1-左右两个按钮
    //1.1-音色按钮
    UIButton *leftButton = [[UIButton alloc] init];
    
    self.leftButton = leftButton;
    
    [leftButton setTitle:@"音色" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [naviBackView addSubview:leftButton];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(naviBackView.mas_bottom).offset(-10);
        make.leading.equalTo(naviBackView.mas_leading).offset(120);
    }];
    
    
    //1.2-友鼓按钮
    UIButton *rightButton = [[UIButton alloc] init];
    
    self.rightButton = rightButton;
    
    [rightButton setTitle:@"友鼓" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [naviBackView addSubview:rightButton];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(naviBackView.mas_bottom).offset(-10);
        make.trailing.equalTo(naviBackView.mas_trailing).offset(-120);
    }];
    
    //按钮触发事件
    [leftButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //添加触发事件
    [rightButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //2-按钮下面的横线
    UIView *lineView = [[UIView alloc] init];
    
    self.lineView = lineView;
    
    lineView.backgroundColor = [UIColor blackColor];
    
    [naviBackView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(leftButton.mas_bottom).offset(0.5);
        make.centerX.equalTo(leftButton.mas_centerX);
        make.height.equalTo(@2);
        make.left.equalTo(naviBackView).offset(110);
    }];
    
}


//设置位于中下部的collectionView
-(void)setUpCollectionView
{
    //(1)实例化一个流水型布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.flowLayout = flowLayout;
    
    
    //设置行间距
    flowLayout.minimumLineSpacing = 0;
    
    //设置列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    
    //设置cell的滚动方向(默认为垂直方向)
    //滚动方向改变之后,行内距和列内距设置就相反了
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //(2)利用flowLayout来实例化一个collectionView
    //暂时把frame设置为zero，待会利用手动方式设置Auto Layout
    UICollectionView *homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    //设置背景
    homeCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.homeCollectionView = homeCollectionView;
    
    homeCollectionView.pagingEnabled = YES;
    homeCollectionView.bounces = NO;
    homeCollectionView.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:homeCollectionView];

    
    //(3)设置collectionView的layout
    [homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.naviBackView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
    
    homeCollectionView.dataSource = self;
    
    homeCollectionView.delegate = self;
    
    
    
    [homeCollectionView registerClass:[HomeViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    
    [homeCollectionView registerClass:[SecondViewCell class] forCellWithReuseIdentifier:secondCollectionIdentifier];
    
}

//布局子控件时设置flowLayout
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.flowLayout.itemSize = self.homeCollectionView.frame.size;
}

//实现collectionView的数据源方法
//1-组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//2-item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

//3-item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell;
    
    if (indexPath.item == 0)
    {
        cell = (HomeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    }
    else
    {
        cell = (SecondViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:secondCollectionIdentifier forIndexPath:indexPath];
    }
    
    
    return cell;
}
//(4)当手动拖拽collectionView时的触发事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat scale = scrollView.contentOffset.x / self.homeCollectionView.bounds.size.width;
    
    //取cell的索引(scale的整数部分)
    int preIndex = (int)scale;
    
    NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:preIndex inSection:0];
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:preIndex+1 inSection:0];
    
    //取前一个cell
    UICollectionViewCell * preCell = (UICollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:preIndexPath];
    

        //NSLog(@"前一个cell清晰度=%f",1 - (scale - preIndex));
        preCell.alpha = 1 - (scale - preIndex);
    
    
    
    
    
    //取后一个cell
    UICollectionViewCell * nextCell = (UICollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:nextIndexPath];
    
    
        //NSLog(@"下一个cell清晰度=%f",scale - preIndex);
        nextCell.alpha = scale - preIndex;
    
    
    //moveLine的滑动距离
    CGFloat moveX = (50 + self.leftButton.bounds.size.width) * scale;
    
    
    //moveLine运动
    _lineView.transform = CGAffineTransformMakeTranslation(moveX, 0);
}

//(5)当手动拖拽完成之后的触发事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/self.homeCollectionView.bounds.size.width;
    
    
    [self ClickButtonWith:index];
    
}

-(void)ClickButtonWith:(NSInteger )buttonIndex
{
    
    UIButton *clickButton = self.buttonArray[buttonIndex];
    
    
    
    //点击的button字体变成黑色
    [clickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        if (obj != clickButton)
        {
            [obj setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        
    }];
}
//按钮触发事件
-(void)ClickButton:(UIButton *)button
{
    
    //点击的button字体变成黑色
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        if (obj != button)
        {
            [obj setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        else
        {
            //collection滚动到响应的cell
            [weakSelf.homeCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            
            
            
            
            //moveLine的滑动
            //判断是不是第一个
            if (idx == 0)
            {
                self.lineView.transform = CGAffineTransformIdentity;
            }
            else
            {
                
                //moveLine的滑动距离
                CGFloat moveX = (50 + self.leftButton.bounds.size.width) * idx;
                
                //moveLine滑动
                self.lineView.transform =CGAffineTransformMakeTranslation(moveX, 0);
            }
            
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

//
//  HomeViewCell.m
//  HomeDemo
//
//  Created by dn210 on 16/11/16.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "HomeViewCell.h"
#import "Masonry.h"


@interface HomeViewCell()

//上面悬浮的headView
@property (nonatomic,weak)UIView *headView;

//已购按钮
@property (nonatomic,weak)UIButton *hasBuyButton;

//创作按钮
@property (nonatomic,weak)UIButton *createButton;


@end


@implementation HomeViewCell

//在此初始化方法内对cell进行设置
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
        
    }
    return self;
}

//设置子控件
-(void)setUpUI
{
    self.contentView.backgroundColor = [UIColor blackColor];
    
    
    //2-加载一个tableView到cell中
    HomeTableController *tableVC = [[HomeTableController alloc] init];
    
    self.tableVC = tableVC;
    
    tableVC.view.backgroundColor = [UIColor blackColor];
    
    
    [self.contentView addSubview:tableVC.view];
    
    
    
    
    //1-先加载一个View在tableview头部
    UIView *headView = [[UIView alloc] init];
    
    self.headView = headView;
    
    headView.backgroundColor = [UIColor colorWithRed:17/255 green:22/255 blue:28/255 alpha:1];
    
    headView.alpha = 1;
    
    [self.contentView addSubview:headView];
    
    
    
    
    //1.2-加载已购按钮在headView上
    UIButton *hasBuyButton = [[UIButton alloc] init];
    
    self.hasBuyButton = hasBuyButton;
    
    [hasBuyButton setTitle:@"已购" forState:UIControlStateNormal];
    
    [hasBuyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [hasBuyButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    hasBuyButton.backgroundColor = [UIColor blueColor];
    
    
    [headView addSubview:hasBuyButton];
    
    [hasBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(headView.mas_centerY);
        
        make.leading.equalTo(headView.mas_leading).offset(50);
        
        
    }];
    
    
    //1-3-加载创作按钮到headView上
    UIButton *createButton = [[UIButton alloc] init];
    
    self.createButton = createButton;
    
    [createButton setTitle:@"创作" forState:UIControlStateNormal];
    
    [createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [createButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    createButton.backgroundColor = [UIColor redColor];
    
    
    [headView addSubview:createButton];
    
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(headView.mas_centerY);
        
        make.trailing.equalTo(headView.mas_trailing).offset(-50);
        
    }];
    
    
    //1-4 一条用于分割的横线
    UIView *lineView = [[UIView alloc] init];
    
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [headView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.bottom.trailing.equalTo(headView);
        
        make.height.equalTo(@0.2);
    }];
    
    
    
    //headView接受外来的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(headViewChangeAlpha:) name:@"headViewChange" object:nil];
    
    
}

//布局子界面，设置嵌入的tableView的大小
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.tableVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(0.4);
        
        make.leading.trailing.equalTo(self.contentView);
        
        make.bottom.equalTo(self.contentView);
    }];
    
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(0.4);
        
        make.leading.trailing.equalTo(self.contentView);
        
        make.height.equalTo(@55);
    }];
    
    
    
    
    
    //self.tableVC.view.frame = self.bounds;
}

-(void)headViewChangeAlpha:(NSNotification *)notification
{
    //取值
    NSUInteger isHeadAppear = [notification.userInfo[@"disAppear"] integerValue];
    
    //消失
    if (isHeadAppear == 1)
    {
        //NSLog(@"headView消失");
        
        [UIView animateWithDuration:0.4 animations:^{
           
            //headView消失
            self.headView.transform = CGAffineTransformMakeTranslation(0, -55);
            
        } completion:^(BOOL finished) {
            
            
        }];
    }
    //显示
    else
    {
        //NSLog(@"headView显示");
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.headView.transform = CGAffineTransformIdentity;

            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

//
//  SecondViewCell.m
//  HomeDemo
//
//  Created by dn210 on 16/11/18.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "SecondViewCell.h"
#import "JSDownloadView.h"
#import "Masonry.h"
#import "JSDownLoadManager.h"


@interface SecondViewCell()<JSDownloadAnimationDelegate>

//3-下载的动画View
@property (nonatomic,weak)JSDownloadView *downLoadView;

@property (nonatomic, strong) JSDownLoadManager *manager;

//设置定时器
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,assign)NSUInteger count;

@end


@implementation SecondViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
        
    }
    return self;
}


-(void)setUpUI
{
    self.backgroundColor = [UIColor blueColor];
    
    
    //3-下载的动画View
    JSDownloadView *downLoadView = [[JSDownloadView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 50,self.frame.size.height/2 - 50, 100, 100)];
    
    
    self.downLoadView = downLoadView;
    
    downLoadView.progressWidth = 4;
    
    downLoadView.delegate = self;
    
    [self.contentView addSubview:downLoadView];
    
}

- (void)downTask
{
    
    _count = 0;
    
    //设置定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(labelUpdate) userInfo:nil repeats:YES];
    
}

//定时器方法
-(void)labelUpdate
{
    //1-取数字
    NSString *progressString  = [NSString stringWithFormat:@"%ld",_count];
    
    self.downLoadView.progress = progressString.integerValue;
    
    if (_count == 100)
    {
        self.downLoadView.isSuccess = YES;
        
        [_timer invalidate];
    }
    
    
    _count+= 1;
    
}



- (void)animationStart
{
    [self downTask];
}


@end

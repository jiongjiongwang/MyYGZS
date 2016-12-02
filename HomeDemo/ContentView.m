//
//  ContentView.m
//  HomeDemo
//
//  Created by dn210 on 16/11/22.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "ContentView.h"
#import "Masonry.h"

@interface ContentView()







@end


@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)strData andImage:(UIImage *)imageOfCell
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.labelStr = strData;
        
        self.imageOfCell = imageOfCell;
        
        
        
        //设计Ui布局
        [self setUpUI];
    }
    
    
    return self;
}
-(void)setUpUI
{
    //1-背景图片
    UIImageView *cellImage = [[UIImageView alloc] initWithImage:_imageOfCell];
    
    [self addSubview:cellImage];
    
    [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.top.trailing.bottom.equalTo(self).offset(0);
        
    }];
    
    
    //2-label
    UILabel *cellLabel = [[UILabel alloc] init];
    
    self.cellLabel = cellLabel;
    
    [cellLabel setTextColor:[UIColor whiteColor]];
    
    [cellLabel setTextAlignment:NSTextAlignmentCenter];
    
    [cellLabel setFont:[UIFont systemFontOfSize:15]];
    
    [cellLabel setText:self.labelStr];
    
    [self addSubview:cellLabel];
    
    [cellLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        
        make.top.equalTo(self.mas_top).offset(20);
        
    }];
    
    //3-返回按钮
    UIButton *backButton = [[UIButton alloc] init];
    
    self.backButton = backButton;
    
    backButton.layer.cornerRadius = 10;
    
    backButton.clipsToBounds = YES;
    
    backButton.backgroundColor = [UIColor lightGrayColor];
    
    [backButton setImage:[UIImage imageNamed:@"Down"] forState:UIControlStateNormal];
    
    [self addSubview:backButton];
    
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(self.mas_leading).offset(20);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        
    }];
    
    //添加点击触发事件
    [backButton addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    
}


//返回上一级
-(void)Back
{
    NSLog(@"点击返回");
}



@end

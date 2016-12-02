//
//  DescriptionView.m
//  HomeDemo
//
//  Created by dn210 on 16/11/23.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "DescriptionView.h"
#import "Masonry.h"

@interface DescriptionView()





@end


@implementation DescriptionView

- (instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)strData
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.descripStr = strData;
        
        //设计Ui布局
        [self setUpUI];
    }
    
    return self;
}
//设计UI布局
-(void)setUpUI
{
    
    self.backgroundColor = [UIColor purpleColor];
    
    
    //添加一个label到上面
    UILabel *descripLabel = [[UILabel alloc] init];
    
    self.descripLabel = descripLabel;
    
    [descripLabel setTextAlignment:NSTextAlignmentLeft];
    
    [descripLabel setFont:[UIFont systemFontOfSize:18]];
    
    [descripLabel setText:self.descripStr];
    
    [self addSubview:descripLabel];
    
    [descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(self).offset(50);
        
        make.trailing.equalTo(self).offset(-50);
        
        make.top.equalTo(self).offset(10);
        
    }];
    

    //添加一个button到下面
    //UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-5-50, self.frame.size.width, 50)];
    UIButton *clickButton = [[UIButton alloc] init];
    
    self.clickButton = clickButton;
    
    [clickButton setBackgroundColor:[UIColor greenColor]];

    
    [self addSubview:clickButton];
    

    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.trailing.equalTo(self);
        
        make.bottom.equalTo(self).offset(-5);
        make.height.equalTo(@50);
        
    }];
}



@end

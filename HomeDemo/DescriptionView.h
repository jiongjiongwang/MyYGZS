//
//  DescriptionView.h
//  HomeDemo
//
//  Created by dn210 on 16/11/23.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionView : UIView

//外部传来的介绍文字
@property (nonatomic,copy)NSString *descripStr;

- (instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)strData;

//蓝色的button
@property (nonatomic,weak)UIButton *clickButton;

//介绍label
@property (nonatomic,weak)UILabel *descripLabel;




@end

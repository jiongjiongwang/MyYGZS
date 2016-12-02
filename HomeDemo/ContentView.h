//
//  ContentView.h
//  HomeDemo
//
//  Created by dn210 on 16/11/22.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import <UIKit/UIKit.h>

//类似于重新创建一个cell
@interface ContentView : UIView

//从外界获取label的标识
@property (nonatomic,copy)NSString *labelStr;

- (instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)strData andImage:(UIImage *)imageOfCell;

//1-图片
@property (nonatomic,weak)UIImageView *cellImage;


//2-标签
@property (nonatomic,weak)UILabel *cellLabel;

//3-返回标签
@property (nonatomic,weak)UIButton *backButton;

//从外界获取的背景图片
@property (nonatomic,strong)UIImage *imageOfCell;

-(void)setUpUI;

@end

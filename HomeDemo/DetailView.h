//
//  DetailView.h
//  HomeDemo
//
//  Created by dn210 on 16/11/22.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "DescriptionView.h"


@interface DetailView : UIView


- (instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)strData index:(NSInteger)index andCellImage:(UIImage *)imageOfCell;

//原来的所属的cell的y轴坐标值
@property (nonatomic ,assign) CGFloat offsetY;

@property (nonatomic ,assign) CGFloat offsetX;

//转场动画
- (void)aminmationShow;

- (void)LoadAminmationShow;


- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete;

@end

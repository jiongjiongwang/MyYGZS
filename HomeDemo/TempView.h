//
//  TempView.h
//  HomeDemo
//
//  Created by dn210 on 16/11/25.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "DescriptionView.h"


@interface TempView : UIView


//上面的View
@property (nonatomic,weak)ContentView *contentView;

//下面的View
@property (nonatomic,weak)DescriptionView *descriptionView;


-(instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)contentStrData index:(NSInteger)index andCellImage:(UIImage *)imageOfCell andDescriptionStr:(NSString *)descriptionStr;




@end

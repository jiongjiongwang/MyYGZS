//
//  HomeTableViewCell.h
//  HomeDemo
//
//  Created by dn210 on 16/11/16.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

//从外界获取label的标识
@property (nonatomic,copy)NSString *labelStr;

//cell上的图片
@property (nonatomic,strong)UIImage *imageOfCell;

//1-图片
@property (nonatomic,weak)UIImageView *cellImage;


@end

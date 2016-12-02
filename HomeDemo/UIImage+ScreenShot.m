//
//  UIImage+ScreenShot.m
//  HomeDemo
//
//  Created by dn210 on 16/11/25.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "UIImage+ScreenShot.h"

@implementation UIImage (ScreenShot)

+(UIImage *)ScreenShot
{
    //1-获取当前的主界面window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //2-获取图形上下文
    UIGraphicsBeginImageContext(window.bounds.size);
    
    //3-将当前window上的图片渲染到图片上下文中
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    
    //4-获取图形上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
#warning 一定要关闭图形上下文!!!!!
    //5-关闭上下文
    UIGraphicsEndImageContext();
    
    
    return image;
}

@end

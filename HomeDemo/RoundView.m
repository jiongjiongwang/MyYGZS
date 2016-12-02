//
//  RoundView.m
//  HomeDemo
//
//  Created by dn210 on 16/11/28.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "RoundView.h"

@implementation RoundView



- (void)drawRect:(CGRect)rect 
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
    
    [[UIColor redColor] setFill];
    
    [path fill];
 
}


@end

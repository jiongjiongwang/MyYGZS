//
//  DetailView.m
//  HomeDemo
//
//  Created by dn210 on 16/11/22.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "DetailView.h"
#import "DescriptionView.h"
#import "TempView.h"
#import "UIImage+ScreenShot.h"
#import "UIImage+ImageEffects.h"



//屏幕的长度(固定值)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface DetailView()

@property (nonatomic,weak)TempView *tempView;

//毛玻璃背景界面
@property (nonatomic,weak)UIView *backView;


@end


@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)strData index:(NSInteger)index andCellImage:(UIImage *)imageOfCell
{
    self = [super initWithFrame:frame];

    
    if (self)
    {
        
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
    
        
        self.backgroundColor = [UIColor clearColor];
        
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        backView.backgroundColor = [UIColor colorWithPatternImage:[[UIImage ScreenShot] applyLightEffect]];
        
        self.backView = backView;
        
        backView.alpha = 0;
        
        [self addSubview:backView];
        
        
        
        //添加tempView
        TempView *tempView = [[TempView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) dataStr:strData index:index andCellImage:imageOfCell andDescriptionStr:@"当前音乐是。。。。"];
        
        self.tempView = tempView;
        
        [self addSubview:tempView];
        
        
        
    }

    
    return self;
}

//转场动画
- (void)aminmationShow
{
    
    //上
    self.tempView.contentView.frame = CGRectMake(self.offsetX, self.offsetY, 80, 80);
    
    
    self.tempView.contentView.cellLabel.hidden = YES;
    
    self.tempView.contentView.backButton.hidden = YES;
    
    
    
    //发通知隐藏tabbar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:self userInfo:@{@"hide":@(1)}];
    
    
    
    
    
    [UIView animateWithDuration:0.5 animations:^{

        
        //上
        self.tempView.contentView.frame = CGRectMake(kScreenWidth/2-80/2,kScreenWidth/2-80/2,self.tempView.contentView.frame.size.width,self.tempView.contentView.frame.size.height);
        
        
        
        
    } completion:^(BOOL finished) {
        
          [UIView animateWithDuration:1 animations:^{
             
              
              //圆形的刷新界面
              [self LoadRoundWithRect:self.tempView.contentView.frame];
              
              
              
              
          } completion:^(BOOL finished) {
              
              
              CGRect rec = self.tempView.contentView.frame;
              
              rec.origin.x = 0;
              rec.origin.y = 0;
              
              rec.size.width = kScreenWidth;
              rec.size.height = kScreenWidth;
              
              self.tempView.contentView.frame = rec;
              
              
              
              self.tempView.contentView.cellLabel.hidden = NO;
              
              self.tempView.contentView.backButton.hidden = NO;

              
          }];
        
    }];
    
}


//圆圈运动加载界面
-(void)LoadRoundWithRect:(CGRect)frame
{
    self.tempView.descriptionView.hidden = NO;
    
    
    CGRect finalFrame = frame;
    
    
    CGRect rect = CGRectInset(finalFrame, -kScreenHeight -50, -kScreenHeight -50);
    
    CGPathRef startPath = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(finalFrame, NULL);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = startPath;
    self.tempView.layer.mask = maskLayer;
    
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id)(endPath);
    pingAnimation.toValue   = (__bridge id)(startPath);
    pingAnimation.duration  = 0.7;
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert"];
    
    CGPathRelease(startPath);
    CGPathRelease(endPath);
}

//加载界面的运动
-(void)RoundScaleWithScale:(float)value
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:value];
    animation.toValue=[NSNumber numberWithFloat:1];
    animation.autoreverses=NO;
    //animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起始帧和终了帧的设定
    positionAnima.toValue = [NSValue valueWithCGPoint:self.tempView.layer.position]; // 起始帧
    positionAnima.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.offsetX + 80/2, self.offsetY +80/2 * kScreenHeight/kScreenWidth)]; // 终了帧
    positionAnima.autoreverses=NO;
    //positionAnima.removedOnCompletion=NO;
    positionAnima.fillMode=kCAFillModeForwards;
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    //动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    
    group.animations = @[animation,positionAnima];
    
    group.duration = 0.5;
    
    group.repeatCount = 1;
    
    //group.removedOnCompletion=NO;
    group.fillMode=kCAFillModeForwards;
    //[self.tempView.contentView.layer addAnimation:group forKey:@"zoom-move-layer"];
    [self.tempView.layer addAnimation:group forKey:@"zoom-move-layer"];
}

//缩小运动退出界面
/*
-(void)ExitRoundWithRect:(CGRect)frame
{
    
    CGRect finalFrame = frame;
    
    
    CGRect rect = CGRectInset(finalFrame, -100,-100);
    
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef startPath = CGPathCreateWithEllipseInRect(finalFrame, NULL);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = startPath;
    //self.tempView.layer.mask = maskLayer;
    self.tempView.contentView.layer.mask = maskLayer;
    
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //起点:CGRectInset(finalFrame, -kScreenHeight -50, -kScreenHeight -50);
    pingAnimation.fromValue = (__bridge id)(endPath);
    //终点:CGRectMake(kScreenWidth/2-80/2, kScreenWidth/2-80/2,80,80);
    pingAnimation.toValue   = (__bridge id)(startPath);
    pingAnimation.duration  = 1;
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert"];
    
    CGPathRelease(startPath);
    CGPathRelease(endPath);
}
*/




-(void)ExitScaleWithScale:(float)value
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:1];
    animation.toValue=[NSNumber numberWithFloat:value];
    animation.autoreverses=NO;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起始帧和终了帧的设定
    positionAnima.fromValue = [NSValue valueWithCGPoint:self.tempView.layer.position]; // 起始帧
    positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(self.offsetX + 80/2, self.offsetY +80/2 * kScreenHeight/kScreenWidth)]; // 终了帧
    positionAnima.autoreverses=NO;
    positionAnima.removedOnCompletion=NO;
    positionAnima.fillMode=kCAFillModeForwards;
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    //动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    
    group.animations = @[animation,positionAnima];
    
    group.duration = 0.5;
    
    group.repeatCount = 1;
    
    group.removedOnCompletion=NO;
    group.fillMode=kCAFillModeForwards;
    //[self.tempView.contentView.layer addAnimation:group forKey:@"zoom-move-layer"];
    [self.tempView.layer addAnimation:group forKey:@"zoom-move-layer"];
}


//回到原来位置的动画
/*
-(void)ExitBack
{
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起始帧和终了帧的设定
    positionAnima.fromValue = [NSValue valueWithCGPoint:self.tempView.contentView.layer.position]; // 起始帧
    positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(self.offsetX + 80/2, self.offsetY +80/2+80/2 * kScreenHeight/kScreenWidth)]; // 终了帧
    positionAnima.duration=0.3;
    positionAnima.autoreverses=NO;
    positionAnima.repeatCount=1;
    positionAnima.removedOnCompletion=NO;
    positionAnima.fillMode=kCAFillModeForwards;
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.tempView.contentView.layer addAnimation:positionAnima forKey:@"move-layer"];
}
*/


//转场加载动画
- (void)LoadAminmationShow
{
    
    float scaleValue = 80/self.tempView.contentView.bounds.size.width;
    
    //缩小之前隐藏label
    self.tempView.contentView.backButton.hidden = YES;
    
    self.tempView.contentView.cellLabel.hidden = YES;
    
    self.tempView.descriptionView.clickButton.hidden = YES;
    
    self.tempView.descriptionView.descripLabel.hidden = YES;
    
    //发通知隐藏tabbar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:self userInfo:@{@"hide":@(1)}];
    
    //大的主体运动
    [self RoundScaleWithScale:scaleValue];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        //小的区域运动
        CGRect rec = self.tempView.descriptionView.frame;
        
        rec.size.height = kScreenHeight - kScreenWidth;
        
        self.tempView.descriptionView.frame = rec;
        
    } completion:^(BOOL finished) {
        
        
        self.tempView.contentView.backButton.hidden = NO;
        
        self.tempView.contentView.cellLabel.hidden = NO;
        
        self.tempView.descriptionView.clickButton.hidden = NO;
        
        self.tempView.descriptionView.descripLabel.hidden = NO;
        
    }];
    
    //毛玻璃显示出来
    [UIView animateWithDuration:0.3 animations:^{
        
        
        self.backView.alpha = 1;
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}


//结束转场动画，返回主界面
- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete;
{

    
    float scaleValue = 80/self.tempView.contentView.bounds.size.width;
    
    
    //缩小之前隐藏label
    self.tempView.contentView.backButton.hidden = YES;
    
    self.tempView.contentView.cellLabel.hidden = YES;
    
    self.tempView.descriptionView.clickButton.hidden = YES;
    
    self.tempView.descriptionView.descripLabel.hidden = YES;
    
    
    //大的主体移动
    [self ExitScaleWithScale:scaleValue];
    
    
    
    /*
    [UIView animateWithDuration:0.5 animations:^{
        
        //返回到原来位置
        CGRect buttonRect = self.tempView.descriptionView.clickButton.frame;
        
        buttonRect.size.height = 0;
        
        //buttonRect.size.width = buttonRect.size.width - 50;
        
        
        self.tempView.descriptionView.clickButton.frame = buttonRect;
        
        
        
        
        
        CGRect rec = self.tempView.descriptionView.frame;
        
        rec.size.height = rec.size.height - 50;
        
        //rec.size.width = rec.size.width - 50;
        
        self.tempView.descriptionView.frame = rec;
        
        //self.tempView.descriptionView.alpha = 0;
        
        
        
    } completion:^(BOOL finished) {
        
        
        
        
     }];
    */
    

    
    
        [UIView animateWithDuration:0.5 animations:^{
            
            //小的区域运动
            CGRect rec = self.tempView.descriptionView.frame;
            
            rec.size.height = 0;
            
            self.tempView.descriptionView.frame = rec;
            
        } completion:^(BOOL finished) {
            
            
            [self.tempView.descriptionView removeFromSuperview];
        }];
    
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [UIView animateWithDuration:1.1 animations:^{
            
            self.backView.alpha = 0;
            
            
        } completion:^(BOOL finished) {
            
            //发通知显示tabbar
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:self userInfo:@{@"hide":@(0)}];
            
            //DetailView移除并销毁
            [self removeFromSuperview];
            
            
            complete();
            
        }];
        
        
        
    });
    
    
        
   
}

@end

//
//  HomeTableViewCell.m
//  HomeDemo
//
//  Created by dn210 on 16/11/16.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Masonry.h"
#import "JSDownloadView.h"


#define RANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@interface HomeTableViewCell()<JSDownloadAnimationDelegate>



//2-标签
@property (nonatomic,weak)UILabel *cellLabel;

//3-下载的动画View
@property (nonatomic,weak)JSDownloadView *downLoadView;


@end


@implementation HomeTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
    }
    
    return self;
}

-(void)setUpUI
{
    
    //self.backgroundColor = [UIColor blackColor];
    
    self.backgroundColor = [UIColor colorWithRed:17/255 green:22/255 blue:28/255 alpha:1];
    
    //1-图片
    
    //图片资源
    UIImage *imageOfCell = [UIImage imageNamed:@"Acoustic"];
    
    self.imageOfCell = imageOfCell;
    
    UIImageView *cellImage = [[UIImageView alloc] initWithImage:imageOfCell];
    
    self.cellImage = cellImage;
    
    
    [self.contentView addSubview:cellImage];
    
    [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(self.contentView).offset(30);
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        
        make.width.height.equalTo(@80);
    }];
    
    
    //2-label
    UILabel *cellLabel = [[UILabel alloc] init];
    
    self.cellLabel = cellLabel;
    
    [cellLabel setTextColor:[UIColor whiteColor]];
    
    [cellLabel setTextAlignment:NSTextAlignmentCenter];
    
    [cellLabel setFont:[UIFont systemFontOfSize:15]];
    
    [self.contentView addSubview:cellLabel];
    
    [cellLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView.mas_centerY);
        
        make.leading.equalTo(cellImage.mas_trailing).offset(20);
        
    }];
    
    //3-下载的动画View
    /*
    JSDownloadView *downLoadView = [[JSDownloadView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 50, self.contentView.frame.size.height/2 - 25, 40, 40)];
    
    self.downLoadView = downLoadView;
    
    downLoadView.progressWidth = 4;
    
    downLoadView.delegate = self;
    
    [self.contentView addSubview:downLoadView];
    */
}

- (void)animationStart
{
    
    NSLog(@"下载%@",_labelStr);
}

-(void)setLabelStr:(NSString *)labelStr
{
    _labelStr = labelStr;
    
    self.cellLabel.text = labelStr;
}


@end

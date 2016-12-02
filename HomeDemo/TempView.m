//
//  TempView.m
//  HomeDemo
//
//  Created by dn210 on 16/11/25.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "TempView.h"





#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TempView()




//上面View的字符信息
@property (nonatomic,copy)NSString *contentStrData;

@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)UIImage *imageOfCell;



//下面View的描述信息
@property (nonatomic,copy)NSString *descriptionStr;


@end



@implementation TempView


-(instancetype)initWithFrame:(CGRect)frame dataStr:(NSString *)contentStrData index:(NSInteger)index andCellImage:(UIImage *)imageOfCell andDescriptionStr:(NSString *)descriptionStr
{
    self = [super initWithFrame:frame];

    if (self)
    {
        
        self.contentStrData = contentStrData;
        
        self.index = index;
        
        self.descriptionStr = descriptionStr;
        
        self.imageOfCell = imageOfCell;
        
        //布局界面
        [self setUpUI];
        
        
        
    }

    return self;
}

//布局界面
-(void)setUpUI
{
     self.backgroundColor = [UIColor clearColor];

     //1-ContentView
    ContentView *contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) dataStr:_contentStrData andImage:_imageOfCell];
    
    
    self.contentView = contentView;
    
    [self addSubview:contentView];
    
    
    
    
    //2-descriptionView
    DescriptionView *descriptionView = [[DescriptionView alloc] initWithFrame:CGRectMake(0,kScreenWidth, kScreenWidth, 0) dataStr:@"当前音乐是。。。。"];
    
    self.descriptionView = descriptionView;
    
    //self.descriptionView.hidden = YES;
    
    [self addSubview:descriptionView];
    
    
}




@end

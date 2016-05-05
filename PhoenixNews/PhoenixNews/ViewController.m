//
//  ViewController.m
//  PhoenixNews
//
//  Created by  江苏 on 16/5/5.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "DetailTableViewController.h"
#import "TitleLabel.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *titleSV;
@property (strong, nonatomic) IBOutlet UIScrollView *contentSV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //关闭系统自己调整第一个scrollView的竖直偏移
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self setUpChildViewController];
    
    [self setUpTitleLabel];
    
    [self scrollViewDidEndScrollingAnimation:self.contentSV];
}

#pragma mark--添加顶部标题
-(void)setUpTitleLabel{
    
    CGFloat labelW=100;
    
    for (NSInteger i=0; i<7; i++) {
       
        TitleLabel* label=[[TitleLabel alloc]init];
        
        label.text=[self.childViewControllers[i] title];
        
        label.frame=CGRectMake(i*labelW, 0, labelW, self.titleSV.bounds.size.height);
        
        label.tag=i;
        
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        [label addGestureRecognizer:tap];
        
        [self.titleSV addSubview:label];
        
        if (i==0) label.scale=1.0;
        
        self.titleSV.contentSize=CGSizeMake(7*labelW,0);
        
        self.contentSV.contentSize=CGSizeMake(7*[UIScreen mainScreen].bounds.size.width, 0);
    }
    
}

-(void)tap:(UITapGestureRecognizer*)tap{
    
    //取出label对应下标
    NSInteger index=tap.view.tag;
    
    CGPoint offset=self.contentSV.contentOffset;
    
    offset.x=self.contentSV.frame.size.width*index;
    //设置contentSV的偏移量
    [self.contentSV setContentOffset:offset animated:YES];
}


#pragma mark--创建子控制器
-(void)setUpChildViewController{
    
    DetailTableViewController* vc0=[[DetailTableViewController alloc]init];
    vc0.title=@"国际";
    [self addChildViewController:vc0];
    
    DetailTableViewController* vc1=[[DetailTableViewController alloc]init];
    vc1.title=@"军事";
    [self addChildViewController:vc1];
    
    DetailTableViewController* vc2=[[DetailTableViewController alloc]init];
    vc2.title=@"社会";
    [self addChildViewController:vc2];
    
    DetailTableViewController* vc3=[[DetailTableViewController alloc]init];
    vc3.title=@"政治";
    [self addChildViewController:vc3];
    
    DetailTableViewController* vc4=[[DetailTableViewController alloc]init];
    vc4.title=@"经济";
    [self addChildViewController:vc4];
    
    DetailTableViewController* vc5=[[DetailTableViewController alloc]init];
    vc5.title=@"体育";
    [self addChildViewController:vc5];
    
    DetailTableViewController* vc6=[[DetailTableViewController alloc]init];
    vc6.title=@"娱乐";
    [self addChildViewController:vc6];
    
}

#pragma mark--UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat width=scrollView.frame.size.width;
    CGFloat height=scrollView.frame.size.height;
    CGFloat offsetX=scrollView.contentOffset.x;
    
    //当前位置需要显示的控制器的索引
    NSInteger index=offsetX/width;
    
    //取出需要居中显示的label
    TitleLabel * label=self.titleSV.subviews[index];
    CGPoint titleOffset=scrollView.contentOffset;
    titleOffset.x=label.center.x-width*0.5;
    //左边超出处理
    if (titleOffset.x<0) titleOffset.x=0;
    //右边超出处理
    CGFloat maxOffsetX=self.titleSV.contentSize.width-width;
    if (titleOffset.x>maxOffsetX) titleOffset.x=maxOffsetX;
    
    //设置标题视图的偏移量
    [self.titleSV setContentOffset:titleOffset animated:YES];
    //让其他label回到最初状态
    for (TitleLabel* otherLabel in self.titleSV.subviews) {
        if (otherLabel!=label) otherLabel.scale=0.0;
    }
    
    //取出需要显示的子控制器
    DetailTableViewController* vc=self.childViewControllers[index];
    
    if ([vc isViewLoaded]) return;
    
    vc.view.frame=CGRectMake(offsetX, 0, width, height);
    
    [self.contentSV addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //算出放大或缩小量
    CGFloat scale=scrollView.contentOffset.x/scrollView.frame.size.width;
    //当偏移量超出左右边界，直接返回
    if (scale<0||scale>self.titleSV.subviews.count-1) return;
    //取出需要操作的左边label
    NSInteger leftIndex=scale;
    TitleLabel* leftLabel=self.titleSV.subviews[leftIndex];
    //取出需要操作的右边label
    NSInteger rightIndex=leftIndex+1;
    TitleLabel* rightLabel=(rightIndex==self.titleSV.subviews.count)?nil:self.titleSV.subviews[rightIndex];
    
    //右边比例
    CGFloat rightScale=scale-leftIndex;
    //左边比例
    CGFloat leftScale=1-rightScale;
    
    //设置label的比例
    rightLabel.scale=rightScale;
    leftLabel.scale=leftScale;
    
}
@end

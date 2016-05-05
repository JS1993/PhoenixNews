//
//  ViewController.m
//  PhoenixNews
//
//  Created by  江苏 on 16/5/5.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "DetailTableViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *titleSV;
@property (strong, nonatomic) IBOutlet UIScrollView *contentSV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpChildViewController];
    
    [self setUpTitleLabel];
}

#pragma mark--添加顶部标题
-(void)setUpTitleLabel{
    
    CGFloat labelW=100;
    
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
       
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(i*labelW, -64, labelW, self.titleSV.bounds.size.height)];
        
        label.backgroundColor=[self gatRandomColor];
        
        label.text=[self.childViewControllers[i] title];
        
        label.tag=i;
        
        label.textAlignment=NSTextAlignmentCenter;
        
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        [label addGestureRecognizer:tap];
        
        [self.titleSV addSubview:label];
        
        if (i==self.childViewControllers.count-1) {
            
        }
        
        self.titleSV.contentSize=CGSizeMake(7*labelW,self.titleSV.bounds.size.height-64);
        
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

-(UIColor*)gatRandomColor{
    
    CGFloat r=arc4random_uniform(256)/255.0;
    CGFloat g=arc4random_uniform(256)/255.0;
    CGFloat b=arc4random_uniform(256)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
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
    NSInteger index=width/offsetX;
    
    //取出需要居中显示的label
    UILabel * label=self.titleSV.subviews[index];
    CGPoint titleOffset=scrollView.contentOffset;
    titleOffset.x=label.center.x-width*0.5;
    
    //设置标题视图的偏移量
    [self.titleSV setContentOffset:titleOffset animated:YES];
    
    //取出需要显示的子控制器
    DetailTableViewController* vc=self.childViewControllers[index];
    
    vc.view.frame=CGRectMake(0, 0, width, height);
    
    [self.contentSV addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
@end

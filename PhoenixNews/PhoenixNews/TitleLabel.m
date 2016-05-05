//
//  TitleLabel.m
//  PhoenixNews
//
//  Created by  江苏 on 16/5/5.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "TitleLabel.h"

#define JSRed 0.4
#define JSGreen 0.6
#define JSBlue 0.7

@implementation TitleLabel

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:JSRed green:JSGreen blue:JSBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)setScale:(CGFloat)scale{
    _scale=scale;
    
//     R    G    B
//默认 0.4  0.6  0.7
//红色 1.0  0.0  0.0
    CGFloat red=JSRed+(1-JSRed)*scale;
    CGFloat green=JSGreen-JSGreen*scale;
    CGFloat blue=JSBlue-JSBlue*scale;
    
    self.textColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.transform=CGAffineTransformMakeScale(1+scale*0.3, 1+scale*0.3);
    
}
@end

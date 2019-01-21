//
//  CheckPointPageView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CheckPointPageView.h"
#import "CheckPointView.h"

@implementation CheckPointPageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //获取参数
    double WIDTH = self.frame.size.width;
    double HEIGHT = self.frame.size.height;
    double check_f = 100;//checkpoint的长宽相同
    double margin_horizon = (WIDTH - 3 * check_f) / 4;
    double margin_vertical = (HEIGHT - 3 * check_f) / 4;
    //设置scrollview的内容
    self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    //设置checkpoint
    for (int i = 0; i < _checkPoints.count; i++) {
        CheckPointView *cpv = [CheckPointView checkPoint];
        cpv.musicPlay_yx = self.musicPlay_yx;
        cpv.musicPlay = self.musicPlay;
        cpv.checkPonitInfo = _checkPoints[i];
        cpv.nc = self.nc;
        CGRect frame = CGRectMake((i % 3) * (check_f + margin_horizon) + margin_horizon, (i / 3) * (check_f + margin_vertical) + margin_vertical, check_f, check_f);
        cpv.frame = frame;
        [self.scrollView addSubview:cpv];
    }
}

+(instancetype)checkPointPage{
    return [[NSBundle mainBundle]loadNibNamed:@"CheckPointPage" owner:nil options:nil][0];
}

@end

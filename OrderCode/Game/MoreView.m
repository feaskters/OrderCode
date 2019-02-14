//
//  MoreView.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+(instancetype)moreView{
    return [[NSBundle mainBundle]loadNibNamed:@"MoreView" owner:nil options:nil][0];
}

//点击competition
- (IBAction)competition:(UIButton *)sender {
    [self.delegate LSMoreViewCompetitionButtonClick];
}

//点击rank
- (IBAction)rank:(UIButton *)sender {
    [self.delegate LSMoreViewRankButtonClick];
}

@end

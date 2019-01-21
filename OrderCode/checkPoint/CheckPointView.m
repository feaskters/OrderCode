//
//  CheckPointView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CheckPointView.h"
#import "../Game/GameViewController.h"

@implementation CheckPointView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //是否可点击
    if ([_checkPonitInfo[@"enable"] boolValue]) {
        [self setUserInteractionEnabled:true];
        [self.level setBackgroundImage:[UIImage imageNamed:@"背景-设置2"] forState:UIControlStateNormal];
        [self setAlpha:1];
    }else
    {
        [self setUserInteractionEnabled:false];
         [self.level setBackgroundImage:[UIImage imageNamed:@"背景-设置3"] forState:UIControlStateNormal];
        [self setAlpha:0.5];
    }
    //是否有星星
    if ([_checkPonitInfo[@"is_star"] boolValue]) {
        UIImage *starImage = [UIImage imageNamed:@"星星-满"];
        [self.star setImage: starImage];
    }else
    {
        UIImage *starImage = [UIImage imageNamed:@"星星-空"];
        [self.star setImage: starImage];
    }
    //关卡等级
    NSString *levelImageName = [[NSString alloc]initWithFormat:@"%@",_checkPonitInfo[@"level"]];
    UIImage *levelImage = [UIImage imageNamed:levelImageName];
    [self.level setImage:levelImage forState:UIControlStateNormal];
}

+(instancetype)checkPoint{
    return [[NSBundle mainBundle]loadNibNamed:@"CheckPoint" owner:nil options:nil][0];
}

//开始关卡
- (IBAction)enterGame:(UIButton *)sender {
    [_musicPlay_yx play];
    GameViewController *gcv = [GameViewController gameView];
    gcv.musicPlay_yx = self.musicPlay_yx;
    gcv.musicPlay = self.musicPlay;
    gcv.checkPointInfo = self.checkPonitInfo;
    [self.nc presentViewController:gcv animated:YES completion:^{
        [self.musicPlay pause];
    }];
    
}


@end

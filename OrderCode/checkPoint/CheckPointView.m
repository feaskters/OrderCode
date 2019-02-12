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


+(instancetype)getCheckPoint{
    return [[NSBundle mainBundle]loadNibNamed:@"CheckPoint" owner:nil options:nil][0];
}

//开始关卡
- (IBAction)enterGame:(UIButton *)sender {
    [_musplay_yx play];
    GameViewController *gcv = [GameViewController gameView];
    gcv.musPlay_yx = self.musplay_yx;
    gcv.musplay = self.musplay;
    gcv.checkPointInfoMessage = self.checkPonitMessage;
    [self.navigationController presentViewController:gcv animated:YES completion:^{
        [self.musplay pause];
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //是否可点击
    if ([_checkPonitMessage[@"enable"] boolValue]) {
        [self setUserInteractionEnabled:true];
        [self.levelNumber setBackgroundImage:[UIImage imageNamed:@"背景-设置2"] forState:UIControlStateNormal];
        [self setAlpha:1];
    }else
    {
        [self setUserInteractionEnabled:false];
        [self.levelNumber setBackgroundImage:[UIImage imageNamed:@"背景-设置3"] forState:UIControlStateNormal];
        [self setAlpha:0.5];
    }
    //是否有星星
    if ([_checkPonitMessage[@"is_star"] boolValue]) {
        UIImage *starImage = [UIImage imageNamed:@"星星-满"];
        [self.shiningStar setImage: starImage];
    }else
    {
        UIImage *starImage = [UIImage imageNamed:@"星星-空"];
        [self.shiningStar setImage: starImage];
    }
    //关卡等级
    NSString *levelImageName = [[NSString alloc]initWithFormat:@"%@",_checkPonitMessage[@"level"]];
    UIImage *levelImage = [UIImage imageNamed:levelImageName];
    [self.levelNumber setImage:levelImage forState:UIControlStateNormal];
}

@end

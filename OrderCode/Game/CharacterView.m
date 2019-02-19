//
//  CharacterView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CharacterView.h"

@interface CharacterView()

@property NSMutableArray<UIImage *> *picturesup;//前进图片组
@property NSMutableArray<UIImage *> *picturesdown;//后退图片组
@property NSMutableArray<UIImage *> *picturesleft;//向左图片组
@property NSMutableArray<UIImage *> *picturesright;//向右图片组


@end

@implementation CharacterView


//前进
-(void)up{
    self.animationImages = self.picturesup;
    [self startAnimating];
    if ( self.frame.origin.y > 0 ) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 50, 50, 50);
        }];
    }
}
//后退
-(void)down{
    self.animationImages = self.picturesdown;
    [self startAnimating];
    if (self.frame.origin.y < 7 * 50 ) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 50, 50, 50);
        }];
    }
}
//向左
-(void)left{
    self.animationImages = self.picturesleft;
    [self startAnimating];
    if (self.frame.origin.x > 0 ) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x - 50, self.frame.origin.y, 50, 50);
        }];
    }
}
//向右
-(void)right{
    self.animationImages = self.picturesright;
    [self startAnimating];
    if ( self.frame.origin.x < 6 * 50) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x + 50, self.frame.origin.y, 50, 50);
        }];
    }
}
//竞赛向左
-(void)fast_left{
    self.animationImages = self.picturesleft;
    [self startAnimating];
    if (self.frame.origin.x > 0 ) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x - 50, self.frame.origin.y, 50, 50);
        }];
    }
}
//竞赛向右
-(void)fast_right{
    self.animationImages = self.picturesright;
    [self startAnimating];
    if ( self.frame.origin.x < 6 * 50) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x + 50, self.frame.origin.y, 50, 50);
        }];
    }
}
//竞赛前进
-(void)fast_up{
    self.animationImages = self.picturesup;
    [self startAnimating];
    if ( self.frame.origin.y > 0 ) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 50, 50, 50);
        }];
    }
}
//竞赛后退
-(void)fast_down{
    self.animationImages = self.picturesdown;
    [self startAnimating];
    if (self.frame.origin.y < 7 * 50 ) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 50, 50, 50);
        }];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载图片组
        self.picturesup = [NSMutableArray array];
        self.picturesdown = [NSMutableArray array];
        self.picturesleft = [NSMutableArray array];
        self.picturesright = [NSMutableArray array];
        for (int l = 1; l < 4; l++) {
            NSString *name = [NSString stringWithFormat:@"人物 前%d",l ];
            UIImage *image = [UIImage imageNamed:name];
            [self.picturesup addObject:image];
            
            NSString *name1 = [NSString stringWithFormat:@"人物 后%d",l ];
            UIImage *image1 = [UIImage imageNamed:name1];
            [self.picturesdown addObject:image1];
            
            NSString *name2 = [NSString stringWithFormat:@"人物 左%d",l ];
            UIImage *image2 = [UIImage imageNamed:name2];
            [self.picturesleft addObject:image2];
            
            NSString *name3 = [NSString stringWithFormat:@"人物 右%d",l ];
            UIImage *image3 = [UIImage imageNamed:name3];
            [self.picturesright addObject:image3];
        }
        self.animationDuration = 1;
        self.animationImages = self.picturesup;
        [self startAnimating];
    }
    return self;
}

+(instancetype)characterView{
    return [[NSBundle mainBundle]loadNibNamed:@"Character" owner:nil options:nil][0];
}


//获取当前坐标
-(NSArray *)location{
    NSArray *array = @[@(self.frame.origin.x / 50),@(self.frame.origin.y / 50)];
    return array;
}

@end

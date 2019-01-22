//
//  CharacterView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CharacterView.h"

@interface CharacterView()

@property NSMutableArray<UIImage *> *imagesup;//前进图片组
@property NSMutableArray<UIImage *> *imagesdown;//后退图片组
@property NSMutableArray<UIImage *> *imagesleft;//向左图片组
@property NSMutableArray<UIImage *> *imagesright;//向右图片组


@end

@implementation CharacterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载图片组
        self.imagesup = [NSMutableArray array];
        self.imagesdown = [NSMutableArray array];
        self.imagesleft = [NSMutableArray array];
        self.imagesright = [NSMutableArray array];
        for (int i = 1; i < 4; i++) {
            NSString *name = [NSString stringWithFormat:@"人物 前%d",i ];
            UIImage *image = [UIImage imageNamed:name];
            [self.imagesup addObject:image];
            
            NSString *name1 = [NSString stringWithFormat:@"人物 后%d",i ];
            UIImage *image1 = [UIImage imageNamed:name1];
            [self.imagesdown addObject:image1];
            
            NSString *name2 = [NSString stringWithFormat:@"人物 左%d",i ];
            UIImage *image2 = [UIImage imageNamed:name2];
            [self.imagesleft addObject:image2];
            
            NSString *name3 = [NSString stringWithFormat:@"人物 右%d",i ];
            UIImage *image3 = [UIImage imageNamed:name3];
            [self.imagesright addObject:image3];
        }
        self.animationDuration = 1;
        self.animationImages = self.imagesup;
        [self startAnimating];
    }
    return self;
}

+(instancetype)characterView{
    return [[NSBundle mainBundle]loadNibNamed:@"Character" owner:nil options:nil][0];
}

//前进
-(void)up{
    self.animationImages = self.imagesup;
    [self startAnimating];
    if ( self.frame.origin.y > 0 ) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 50, 50, 50);
        }];
    }
}
//后退
-(void)down{
    self.animationImages = self.imagesdown;
    [self startAnimating];
    if (self.frame.origin.y < 7 * 50 ) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 50, 50, 50);
        }];
    }
}
//向左
-(void)left{
    self.animationImages = self.imagesleft;
    [self startAnimating];
    if (self.frame.origin.x > 0 ) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x - 50, self.frame.origin.y, 50, 50);
        }];
    }
}
//向右
-(void)right{
    self.animationImages = self.imagesright;
    [self startAnimating];
    if ( self.frame.origin.x < 6 * 50) {
        [UIView animateWithDuration:1 animations:^{
            self.frame = CGRectMake(self.frame.origin.x + 50, self.frame.origin.y, 50, 50);
        }];
    }
}
//获取当前坐标
-(NSArray *)location{
    NSArray *array = @[@(self.frame.origin.x / 50),@(self.frame.origin.y / 50)];
    return array;
}

@end

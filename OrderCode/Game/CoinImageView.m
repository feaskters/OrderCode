//
//  CoinImageView.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CoinImageView.h"

@interface CoinImageView()

@property int position_x;
@property int position_y;
@property AVAudioPlayer *music_coin;
@property BOOL catch;

@end

@implementation CoinImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置frame
        self.position_x = arc4random() % 7;
        self.position_y = 0;
        CGRect frame = CGRectMake(self.position_x * 50, self.position_y * 50, 50, 50);
        self.frame = frame;
        //设置图片组
        NSMutableArray<UIImage *> *coins = [NSMutableArray array];
        for (int i = 0; i < 9; i ++) {
            NSString *name = [NSString stringWithFormat:@"右斜转00%d",i];
            UIImage *image = [UIImage imageNamed:name];
            [coins addObject:image];
        }
        [self setAnimationImages:coins];
        self.animationDuration = 1;
        [self startAnimating];
        //设置金币音效
        NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"金币" ofType:@"mp3"]];
        _music_coin = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        //初始化为为接到金币
        self.catch = false;
    }
    return self;
}

//获取当前坐标
-(NSArray *)location{
    NSArray *array = @[@((int)(self.frame.origin.x / 50)),@(((int)self.frame.origin.y / 50))];
    return array;
}

//金币下降
/*
 @parameter duration:下降动画时间 0 <= duration <= 1
 */
-(void)down :(double)duration{
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 50, 50, 50);
            //若超出边界则消失
            if (self.frame.origin.y >= 400) {
                [self removeFromSuperview];
            }
        }];
}

//吃到金币
-(void)catchCoin{
    _music_coin.volume = _musplay_yx.volume;
    self.catch = true;
    [_music_coin play];
    [self removeFromSuperview];
}

//是否吃到
-(BOOL)isCatch{
    return _catch;
}
@end

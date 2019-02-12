//
//  GameContainerView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "GameContainerView.h"
#import "CharacterView.h"

@interface GameContainerView()

@property CharacterView *character;

@end

@implementation GameContainerView

-(void)layoutSubviews{
    [super layoutSubviews];
    //添加地图块
    for (int k = 0; k < 8; k++) {
        for (int l = 0; l < 7; l++) {
            UIImageView *pictureView = [[UIImageView alloc]init];
            UIImage *picture = [[UIImage alloc]init];
            switch ([self.gameDetail[@"block"][k][l] integerValue]) {
                case 0:
                    picture = [UIImage imageNamed:@"上下垂直"];
                    break;
                case 1:
                    picture = [UIImage imageNamed:@"左上"];
                    break;
                case 2:
                    picture = [UIImage imageNamed:@"三叉-水平上"];
                    break;
                case 3:
                    picture = [UIImage imageNamed:@"右上"];
                    break;
                case 4:
                    picture = [UIImage imageNamed:@"三叉-垂直左"];
                    break;
                case 5:
                    picture = [UIImage imageNamed:@"水平"];
                    break;
                case 6:
                    picture = [UIImage imageNamed:@"三叉-垂直右"];
                    break;
                case 7:
                    picture = [UIImage imageNamed:@"左下"];
                    break;
                case 8:
                    picture = [UIImage imageNamed:@"三叉-水平下"];
                    break;
                case 9:
                    picture = [UIImage imageNamed:@"右下"];
                    break;
                case 10:
                    picture = [UIImage imageNamed:@"草地"];
                    break;
                case 11:
                    picture = [UIImage imageNamed:@"下-封顶"];
                    break;
                case 12:
                    picture = [UIImage imageNamed:@"右-封顶"];
                    break;
                case 13:
                    picture = [UIImage imageNamed:@"十字路口"];
                    break;
                case 14:
                    picture = [UIImage imageNamed:@"熊"];
                    break;
                case 15:
                    picture = [UIImage imageNamed:@"企鹅"];
                    break;
                case 16:
                    picture = [UIImage imageNamed:@"幽灵"];
                    break;
                case 17:
                    picture = [UIImage imageNamed:@"牛"];
                    break;
                default:
                    break;
            }
            CGRect frame = CGRectMake(l * 50, k * 50, 50, 50);
            pictureView.frame = frame;
            [pictureView setImage:picture];
            [self addSubview: pictureView];
        }
    }
    //添加终点
    UIImageView *pictureViewEnd = [[UIImageView alloc]init];
    NSMutableArray<UIImage *> *pictureEnds = [NSMutableArray array];
    for (int l = 1; l < 5; l ++) {
        NSString *pictureName = [NSString stringWithFormat:@"任意门 %d",l];
        UIImage *pictureEnd = [UIImage imageNamed:pictureName];
        [pictureEnds addObject:pictureEnd];
    }
    pictureViewEnd.animationImages = pictureEnds;
    pictureViewEnd.animationDuration = 1;
    CGRect frame = CGRectMake([self.gameDetail[@"终点"][0] integerValue] * 50, [self.gameDetail[@"终点"][1] integerValue] * 50, 50, 50);
    pictureViewEnd.frame = frame;
    [self addSubview:pictureViewEnd];
    [pictureViewEnd startAnimating];
    //添加起始人物
    frame = CGRectMake([self.gameDetail[@"起点"][0] integerValue] * 50, [self.gameDetail[@"起点"][1] integerValue] * 50, 50, 50);
    self.character = [[CharacterView alloc]initWithFrame: frame];
    [self addSubview:self.character];
    //初始化音效
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"移动1" ofType:@"mp3"]];
    _musPlay_move = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musPlay_move.volume = _musPlay_yx.volume;
    //初始化金币
    self.coinView = [[UIImageView alloc]init];
    NSMutableArray<UIImage *> *coins = [NSMutableArray array];
    for (int i = 0; i < 9; i ++) {
        NSString *name = [NSString stringWithFormat:@"右斜转00%d",i];
        UIImage *image = [UIImage imageNamed:name];
        [coins addObject:image];
    }
    frame = CGRectMake([self.gameDetail[@"金币"][0] integerValue] * 50, [self.gameDetail[@"金币"][1] integerValue] * 50, 50, 50);
    self.coinView.frame = frame;
    [self.coinView setAnimationImages:coins];
    [self addSubview:self.coinView];
    url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"金币" ofType:@"mp3"]];
    _musPlay_coin = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musPlay_coin.volume = _musPlay_yx.volume;
}


+(instancetype)gameContainer{
    return [[NSBundle mainBundle]loadNibNamed:@"GameContainerView" owner:nil options:nil][0];
}

-(NSArray *)move:(int)message{
    [_musPlay_move play];
    switch (message) {
        case 1:
            [self.character up];
            break;
        case 2:
            [self.character left];
            break;
        case 3:
            [self.character down];
              break;
        case 4:
            [self.character right];
              break;
        default:
            break;
    }
//    //判断金币
    NSArray *location = [self.character location];
//    if ([location isEqualToArray:self.gameDetail[@"金币"]]) {
//        [_musicPlay_coin play];
//        self.coinView.animationDuration = 1;
//        [self.coinView startAnimating];
//    }
    return location;
}

@end

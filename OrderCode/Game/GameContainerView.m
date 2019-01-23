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
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 7; j++) {
            UIImageView *imageview = [[UIImageView alloc]init];
            UIImage *image = [[UIImage alloc]init];
            switch ([self.gameDetail[@"block"][i][j] integerValue]) {
                case 0:
                    image = [UIImage imageNamed:@"上下垂直"];
                    break;
                case 1:
                    image = [UIImage imageNamed:@"左上"];
                    break;
                case 2:
                    image = [UIImage imageNamed:@"三叉-水平上"];
                    break;
                case 3:
                    image = [UIImage imageNamed:@"右上"];
                    break;
                case 4:
                    image = [UIImage imageNamed:@"三叉-垂直左"];
                    break;
                case 5:
                    image = [UIImage imageNamed:@"水平"];
                    break;
                case 6:
                    image = [UIImage imageNamed:@"三叉-垂直右"];
                    break;
                case 7:
                    image = [UIImage imageNamed:@"左下"];
                    break;
                case 8:
                    image = [UIImage imageNamed:@"三叉-水平下"];
                    break;
                case 9:
                    image = [UIImage imageNamed:@"右下"];
                    break;
                case 10:
                    image = [UIImage imageNamed:@"草地"];
                    break;
                case 11:
                    image = [UIImage imageNamed:@"下-封顶"];
                    break;
                case 12:
                    image = [UIImage imageNamed:@"右-封顶"];
                    break;
                case 13:
                    image = [UIImage imageNamed:@"十字路口"];
                    break;
                case 14:
                    image = [UIImage imageNamed:@"熊"];
                    break;
                case 15:
                    image = [UIImage imageNamed:@"企鹅"];
                    break;
                case 16:
                    image = [UIImage imageNamed:@"幽灵"];
                    break;
                case 17:
                    image = [UIImage imageNamed:@"牛"];
                    break;
                default:
                    break;
            }
            CGRect frame = CGRectMake(j * 50, i * 50, 50, 50);
            imageview.frame = frame;
            [imageview setImage:image];
            [self addSubview: imageview];
        }
    }
    //添加终点
    UIImageView *imageViewEnd = [[UIImageView alloc]init];
    NSMutableArray<UIImage *> *imageEnds = [NSMutableArray array];
    for (int i = 1; i < 5; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"任意门 %d",i];
        UIImage *imageEnd = [UIImage imageNamed:imageName];
        [imageEnds addObject:imageEnd];
    }
    imageViewEnd.animationImages = imageEnds;
    imageViewEnd.animationDuration = 1;
    CGRect frame = CGRectMake([self.gameDetail[@"终点"][0] integerValue] * 50, [self.gameDetail[@"终点"][1] integerValue] * 50, 50, 50);
    imageViewEnd.frame = frame;
    [self addSubview:imageViewEnd];
    [imageViewEnd startAnimating];
    //添加起始人物
    frame = CGRectMake([self.gameDetail[@"起点"][0] integerValue] * 50, [self.gameDetail[@"起点"][1] integerValue] * 50, 50, 50);
    self.character = [[CharacterView alloc]initWithFrame: frame];
    [self addSubview:self.character];
    //初始化音效
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"移动1" ofType:@"mp3"]];
    _musicPlay_move = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musicPlay_move.volume = _musicPlay_yx.volume;
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
    _musicPlay_coin = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musicPlay_coin.volume = _musicPlay_yx.volume;
}


+(instancetype)gameContainer{
    return [[NSBundle mainBundle]loadNibNamed:@"GameContainerView" owner:nil options:nil][0];
}

-(NSArray *)move:(int)order{
    [_musicPlay_move play];
    switch (order) {
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

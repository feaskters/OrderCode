//
//  CompetitionViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/12.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CompetitionViewController.h"
#import "../Game/CharacterView.h"

@interface CompetitionViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property CharacterView *character;
@end

@implementation CompetitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"游戏页面背景" ofType:@"mp3"]];
    _musPlay_bg = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musPlay_bg.volume = _musplay.volume;
    _musPlay_bg.numberOfLoops = -1;//无限循环
    [_musPlay_bg play];
    //初始化背景地图
    //随机地图块
    NSString *imageName = [NSString stringWithFormat:@"竞赛%d",arc4random() % 4 + 1];
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 7; j++) {
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            CGRect frame = CGRectMake(j*50, i*50, 50, 50);
            imageView.frame = frame;
            [self.gameView addSubview:imageView];
        }
    }
    //初始化人物
    CGRect frame = CGRectMake((arc4random() % 7) * 50, 50 * 7, 50, 50);
    self.character.frame = frame;
    self.character = [[CharacterView alloc]initWithFrame:frame];
    [self.gameView addSubview:self.character];
}

+ (instancetype)competitionView{
    return [[NSBundle mainBundle]loadNibNamed:@"competitionView" owner:nil options:nil][0];
}

//返回
- (IBAction)back:(UIButton *)sender {
    [_musPlay_yx play];
    [_musPlay_bg stop];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
 tag == 0 ->左
 tag == 1 ->右
 */
- (IBAction)btnClick:(UIButton *)sender {
    [_musPlay_yx play];
    if (sender.tag == 0) {
        [self.character competition_left];
    }else{
        [self.character competition_right];
    }
    NSLog(@"%@",[self.character location]);
}

//开始游戏
- (IBAction)start:(UIButton *)sender {
    [_musPlay_yx play];
    sender.hidden = YES;
}

@end

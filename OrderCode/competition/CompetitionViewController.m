//
//  CompetitionViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/12.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "CompetitionViewController.h"
#import "../Game/CharacterView.h"
#import "../Game/CoinImageView.h"
#import "../GameOver/GameOverCompetitionView.h"

@interface CompetitionViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property CharacterView *character;
@property NSTimer *timer_start;//产生金币的tiemr
@property (weak, nonatomic) IBOutlet UIView *lifeView;//hpview
@property int hp;
@property double duration_generate;//金币产生间隔
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
    NSURL *url2 = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"扣血" ofType:@"mp3"]];
    _musPlay_kx = [[AVAudioPlayer alloc]initWithContentsOfURL:url2 error:nil];
    _musPlay_kx.volume = _musPlay_yx.volume * 2;
    _musPlay_kx.numberOfLoops = 0;
    //初始化背景地图
    //随机地图块
    NSString *imageName = [NSString stringWithFormat:@"竞赛%d",arc4random() % 5 + 1];
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
    //初始化血量
    self.hp = 3;
    [self hpChange];
}

//hp变化
- (void)hpChange{
    //先清空lifeview
    for (UIView *subview in self.lifeView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSString *name = @"爱心";
    UIImage *image = [UIImage imageNamed:name];
    //血条宽
    double width = self.lifeView.frame.size.width;
    //间隔
    double space = (width - self.hp * 40) / (self.hp + 1);
    //判断血量
    if (self.hp > 0) {
        for (int i = 0; i < self.hp; i ++) {
            UIImageView *hpImageView = [[UIImageView alloc]initWithImage:image];
            CGRect frame = CGRectMake(i * 40 + (i + 1) * space, 10 * 0.5, 40, 40);
            hpImageView.frame = frame;
            [self.lifeView addSubview:hpImageView];
        }
    }else{
        [self.timer_start invalidate];
        self.timer_start = nil;
        //弹出结算页面
        [self result];
    }
}

//结算页面
-(void)result{
    GameOverCompetitionView *gocv = [GameOverCompetitionView gameOverCompetition];
    [gocv addScoreString:self.score.text];
    gocv.frame = self.view.frame;
    gocv.cvc = self;
    [self.view addSubview:gocv];
}

+ (instancetype)competitionView{
    return [[NSBundle mainBundle]loadNibNamed:@"competitionView" owner:nil options:nil][0];
}

//返回
- (IBAction)back:(UIButton *)sender {
    [_musPlay_yx play];
    [_musPlay_bg stop];
    [self.timer_start invalidate];
    self.timer_start = nil;
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
}

//定时产生金币
-(void)generateCoin:(double)duration{
    //初始化硬币
    CoinImageView *coin = [[CoinImageView alloc]init];
    coin.musplay_yx = self.musPlay_yx;
    [self.gameView addSubview:coin];
    //金币下降
    [NSTimer scheduledTimerWithTimeInterval:duration repeats:YES block:^(NSTimer * _Nonnull timer1) {
        [coin down:duration];
        //判断是否吃到金币
        if ([[self.character location] isEqualToArray: [coin location]]) {
            [coin catchCoin];
            //吃到金币后加分
            int score_number = [self.score.text intValue];
            score_number += 100;
            self.score.text = [NSString stringWithFormat:@"%d",score_number];
        }
        //判断金币越界,为保证金币音效正常播放，将范围调大
        if ([[coin location][1] integerValue] > 7) {
            //销毁计时器
            [timer1 invalidate];
            timer1 = nil;
            //若没被吃到，掉血
            if (![coin isCatch]) {
                //扣除血量
                if (self.hp > 0) {
                    self.hp -- ;
                    [self hpChange];
                }
                [self.musPlay_kx play];
            }
        }
        //若产生金币计时器销毁，销毁当前计时器
        if (![self.timer_start isValid]) {
            [timer1 invalidate];
            timer1 = nil;
        }
    }];
}

//开始游戏
- (IBAction)start:(UIButton *)sender {
    [_musPlay_yx play];
    sender.hidden = YES;
    double static duration_down = 1.5;
    duration_down = 1.5;
    self.duration_generate = 3;
    self.timer_start = [NSTimer scheduledTimerWithTimeInterval:0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //产生金币
        [self generateCoin:duration_down];
        
        //重设时间间隔
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.duration_generate]];
        //加速下降
        if (duration_down > 0.7) {
            duration_down = duration_down - 0.02;
        }
        //加速产生
        if (self.duration_generate > 1) {
            self.duration_generate -= 0.05;
        }
    }];
}

@end

//
//  PuzzleViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/18.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "PuzzleViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "../Game/CharacterView.h"
#import "PuzzleView.h"

@interface PuzzleViewController ()

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property CharacterView *character;
@property (nonatomic) PuzzleView *puzzleView;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (nonatomic) NSTimer *timer;//倒计时计时器

@end

@implementation PuzzleViewController

#pragma mark -懒加载

//懒加载puzzleView
- (PuzzleView *)puzzleView{
    if (_puzzleView == nil) {
        _puzzleView = [PuzzleView puzzleView];
        _puzzleView.frame = CGRectMake(50, 270, 200, 100);
    }
    return _puzzleView;
}

//懒加载计时器
- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            int leftTime = [self.second.text intValue];
            if (leftTime > 0) {
                --leftTime;
                self.second.text = [NSString stringWithFormat:@"%d",leftTime ];
            }else{
                NSLog(@"gameOver");
            }
        }];
    }
    return _timer;
}

-(void)viewWillAppear:(BOOL)animated{
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"游戏页面背景" ofType:@"mp3"]];
    self.musPlay_bg = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musPlay_bg.volume = _musplay.volume;
    _musPlay_bg.numberOfLoops = -1;//无限循环
    [_musPlay_bg play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化背景地图
    //随机地图块
    NSString *imageName = [NSString stringWithFormat:@"竞赛%d",arc4random() % 4 + 2];
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 7; j++) {
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            CGRect frame = CGRectMake(j*50, i*50, 50, 50);
            imageView.frame = frame;
            [self.gameView addSubview:imageView];
        }
    }
    //初始化数字
    for (int i = 0; i < 9; ++i ) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]] ];
        int x = i % 3;
        int y = i / 3;
        imageView.frame = CGRectMake(x * 100 + 50, y * 100, 50, 50);
        [self.gameView addSubview:imageView];
    }
    //初始化倒计时
    self.second.frame = CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 50, 100, 100);
    self.second.alpha = 0;

}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
}

+(instancetype)puzzleViewController{
    return [[NSBundle mainBundle]loadNibNamed:@"PuzzleViewController" owner:nil options:nil][0];
}
- (IBAction)back:(UIButton *)sender {
    [_musPlay_yx play];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*
 0 -> up
 1 -> left
 2 -> down
 3 -> right
 */
- (IBAction)direction:(UIButton *)sender {
    [_musPlay_yx play];
    switch (sender.tag) {
        case 0:
            [self.character competition_up];
            break;
        case 1:
            [self.character competition_left];
            break;
        case 2:
            [self.character competition_down];
            break;
        case 3:
            [self.character competition_right];
            break;
        default:
            break;
    }
}
- (IBAction)start:(UIButton *)sender {
    sender.hidden = YES;
    [_musPlay_yx play];
    //初始化人物
    CGRect frame = CGRectMake((arc4random() % 7) * 50, 50 * 7, 50, 50);
    self.character.frame = frame;
    self.character = [[CharacterView alloc]initWithFrame:frame];
    [self.gameView addSubview:self.character];
    //初始化问题框
    [self.gameView addSubview:self.puzzleView];
    //初始化倒计时
    [UIView animateWithDuration:1 animations:^{
        self.second.frame = CGRectMake(self.view.frame.size.width - 70, self.score.frame.origin.y, 50, 50);
        self.second.alpha = 1;
    } completion:^(BOOL finished) {
        //开始倒计时
        [self.timer fire];
    }];
}

- (IBAction)ok:(UIButton *)sender {
    [_musPlay_yx play];
    NSArray *array = [self.character location];
    //获取数字
    if ([@[@1,@3,@5] containsObject:array[0]] && [@[@0,@2,@4] containsObject:array[1]]) {
        int x = ([array[0] intValue] + 1) / 2;
        int y = [array[1] intValue] / 2 ;
        int num = x + y * 3;
        BOOL flag = [self.puzzleView resultWithB:num];
        //判断正误
        if (flag) {
            self.score.text = [NSString stringWithFormat:@"%d",([self.score.text intValue] + 100)];
            //奖励2秒
            self.second.text = [NSString stringWithFormat:@"%d",[self.second.text intValue] + 2];

        }else{
            //扣除5秒
            self.second.text = [NSString stringWithFormat:@"%d",[self.second.text intValue] -5];
        }
    }
}

@end

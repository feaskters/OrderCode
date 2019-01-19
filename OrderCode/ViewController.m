//
//  ViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MainViewController.h"

@interface ViewController (){
    //声明一个播放器
    AVAudioPlayer *_musicPlay;//音乐播放器1
    AVAudioPlayer *_musicPlay_yx;//音效播放器
}

@property (weak, nonatomic) IBOutlet UILabel *capital;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"柔和的风" ofType:@"mp3"]];
    _musicPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musicPlay.numberOfLoops = -1;//无限循环
    [_musicPlay play];
    
    NSURL *url_yx = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"点击按钮" ofType:@"mp3"]];
    _musicPlay_yx = [[AVAudioPlayer alloc]initWithContentsOfURL:url_yx error:nil];
    
}

/*
 设置标题
 */
-(void)setTitleName{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showMain"]) {
        MainViewController *main = [segue destinationViewController];
        main._musicPlay = _musicPlay;
        main._musicPlay_yx = _musicPlay_yx;
        _musicPlay = nil;
        [_musicPlay_yx play];
        _musicPlay_yx = nil;
    }
}

@end

//
//  GameViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property UIImageView *orderView;//指令图片view
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIScrollView *orderScrollView;
@property NSMutableArray *orderArray;//指令数组
@property UIImage *up;//上
@property UIImage *down;//下
@property UIImage *left;//左
@property UIImage *right;//右


@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//初始化
- (void) initAll{
    //初始化指令数组
    self.orderArray = [[NSMutableArray alloc]init];
    //初始化图片
    self.up = [UIImage imageNamed:@"上"];
    self.down = [UIImage imageNamed:@"下"];
    self.left = [UIImage imageNamed:@"左"];
    self.right = [UIImage imageNamed:@"右"];
}

-(void)viewWillAppear:(BOOL)animated{
    //设置图片
    NSString *levelName = [[NSString alloc]initWithFormat:@"%@",self.checkPointInfo[@"level"]];
      [self.levelImage setImage:[UIImage imageNamed:levelName]];
    [self initAll];
    //播放背景
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"游戏页面背景" ofType:@"mp3"]];
    _musicPlay_bg = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musicPlay_bg.volume = _musicPlay.volume;
    _musicPlay_bg.numberOfLoops = -1;//无限循环
    [_musicPlay_bg play];
    //设置scrollview
    self.orderScrollView.frame = CGRectMake(self.orderScrollView.frame.origin.x, self.orderScrollView.frame.origin.y, self.gameView.frame.size.width, 40);
    self.orderScrollView.scrollEnabled = YES; self.orderScrollView.contentSize = CGSizeMake(40, 36 * 40);
    
}

+(instancetype)gameView{
    return [[NSBundle mainBundle]loadNibNamed:@"GameView" owner:nil options:nil][0];
}
//返回
- (IBAction)back:(UIButton *)sender {
    [_musicPlay_yx play];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
 *按钮点击
 *tag-> 0 开始
        1 上
        2 左
        3 下
        4 右
        5 删除
        6 清空
 */
- (IBAction)click:(UIButton *)sender {
    [_musicPlay_yx play];
    switch (sender.tag) {
        case 0:
            
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            [self.orderArray addObject:@(sender.tag)];
            break;
        case 5:
            [self.orderArray removeLastObject];
            break;
        case 6:
            [self cleanOrderScrollViewn];
        default:
            break;
    }
    [self refreshOrderScrollView];
}

//清空scrollView
- (void)cleanOrderScrollViewn{
    self.orderView = nil;
    self.orderArray = nil;
    for (UIView *view in self.orderScrollView.subviews) {
        [view removeFromSuperview];
    }
    //重新初始化数组和view
    self.orderArray = [[NSMutableArray alloc]init];
}

//更新scrollView
- (void)refreshOrderScrollView{
    for (UIView *view in self.orderScrollView.subviews) {
        [view removeFromSuperview];
    }
    //判断数组的数量
    if (self.orderArray.count != 0) {
        for (int i = 0; i < self.orderArray.count; i++) {
            //创建uiimageview
            self.orderView = [[UIImageView alloc]init];
            switch ([self.orderArray[i] integerValue]) {
                case 1:
                    [_orderView setImage:self.up];
                    break;
                case 2:
                    [_orderView setImage:self.left];
                    break;
                case 3:
                    [_orderView setImage:self.down];
                    break;
                case 4:
                    [_orderView setImage:self.right];
                    break;
                default:
                    break;
            }
            CGRect frame = CGRectMake(40 * i + 10, 0, 40, 40);
            _orderView.frame = frame;
            [self.orderScrollView addSubview:_orderView];
        }
    }
}

@end

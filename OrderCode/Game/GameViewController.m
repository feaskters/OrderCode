//
//  GameViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "GameViewController.h"
#import "GameContainerView.h"
#import "../GameOver/GameOverView.h"

@interface GameViewController ()

@property UIImageView *orderView;//指令图片view
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIScrollView *orderScrollView;
@property NSMutableArray *orderArray;//指令数组
@property GameContainerView *gcv;
@property GameOverView *gov;
@property UIImage *up;//上
@property UIImage *down;//下
@property UIImage *left;//左
@property UIImage *right;//右
//按钮
@property (weak, nonatomic) IBOutlet UIButton *delete;
@property (weak, nonatomic) IBOutlet UIButton *upbtn;
@property (weak, nonatomic) IBOutlet UIButton *leftbtn;
@property (weak, nonatomic) IBOutlet UIButton *downbtn;
@property (weak, nonatomic) IBOutlet UIButton *rightbtn;
@property (weak, nonatomic) IBOutlet UIButton *cleanbtn;
@property (weak, nonatomic) IBOutlet UIButton *startbtn;



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
    NSString *levelName = [[NSString alloc]initWithFormat:@"%@",self.checkPointInfoMessage[@"level"]];
      [self.levelImage setImage:[UIImage imageNamed:levelName]];
    [self initAll];
    //播放背景
    //初始化音乐播放器
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"游戏页面背景" ofType:@"mp3"]];
    _musPlay_bg = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    _musPlay_bg.volume = _musplay.volume;
    _musPlay_bg.numberOfLoops = -1;//无限循环
    [_musPlay_bg play];
    //设置scrollview
    self.orderScrollView.frame = CGRectMake(self.orderScrollView.frame.origin.x, self.orderScrollView.frame.origin.y, self.gameView.frame.size.width, 40);
    self.orderScrollView.scrollEnabled = YES; self.orderScrollView.contentSize = CGSizeMake(36 * 40, 40);
    //初始化地图
    self.gcv = [GameContainerView gameContainer];
    self.gcv.gameDetail = self.checkPointInfoMessage;
    self.gcv.musPlay_yx = self.musPlay_yx;
    self.gcv.frame = CGRectMake(0, 0, self.gameView.frame.size.width, self.gameView.frame.size.height);
    [self.gameView addSubview:self.gcv];
    //初始化结算界面
    self.gov = [GameOverView gameOverView];
    self.gov.frame = self.view.frame;
    self.gov.gameDetail = self.checkPointInfoMessage;
}

+(instancetype)gameView{
    return [[NSBundle mainBundle]loadNibNamed:@"GameView" owner:nil options:nil][0];
}
//返回
- (IBAction)back:(UIButton *)sender {
    [_musPlay_yx play];
    [_musPlay_bg stop];
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
    [_musPlay_yx play];
    switch (sender.tag) {
        case 0:
            //开始执行指令
            if (self.orderArray.count != 0) {
                
                [self act];
            }
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            //超过25个指令给出提示
            if (_orderArray.count > 24) {
                CGRect frame1 = CGRectMake(_orderScrollView.frame.origin.x, _orderScrollView.frame.origin.y, _orderScrollView.frame.size.width, 40);
                UILabel * label = [[UILabel alloc]init];
                label.frame = frame1;
                [label setBackgroundColor:[UIColor whiteColor]];
                label.text = @"最多只能加入25条指令哦！";
                label.alpha = 0;
                label.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:label];
                [UIView animateWithDuration:1 animations:^{
                    label.alpha = 0.8;
                } completion:^(BOOL finished) {
                }];
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                } completion:^(BOOL finished) {
                    [label removeFromSuperview];
                }];
                
            }else{
                [self.orderArray addObject:@(sender.tag)];
            }
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



//执行指令
- (void)act{
    //禁止点击所有按钮
    self.upbtn.userInteractionEnabled = NO;
    self.downbtn.userInteractionEnabled = NO;
    self.leftbtn.userInteractionEnabled = NO;
    self.rightbtn.userInteractionEnabled = NO;
    self.startbtn.userInteractionEnabled = NO;
    self.delete.userInteractionEnabled = NO;
    self.cleanbtn.userInteractionEnabled = NO;
    
    //--------------------------------------------------
    for (int i = 0; i < self.orderArray.count; i++) {
        [NSTimer scheduledTimerWithTimeInterval:i repeats:NO block:^(NSTimer * _Nonnull timer) {
            int num = (int)[self.orderArray[0] integerValue];
            NSArray *location = [self.gcv move:num];
            if ([location isEqualToArray:self.checkPointInfoMessage[@"金币"]]) {
                [self.gcv.musPlay_coin play];
                self.gcv.coinView.animationDuration = 1;
                [self.gcv.coinView startAnimating];
                self.gov.is_star = 1;
            }
            if (self.orderArray.count > 0) {
                [self.orderArray removeObjectAtIndex:0];
                [self refreshOrderScrollView];
            }
            if(self.orderArray.count == 0){
                if ([location isEqualToArray:self.checkPointInfoMessage[@"终点"] ]) {
                    self.gov.is_clear = 1;
                }else{
                    self.gov.is_clear = 0;
                }
                [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
                    self.gov.gvc = self;
                    [self.view addSubview:self.gov];
                    [timer invalidate];
                }];
            }
            [timer invalidate];
        }];
    }
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
    _orderScrollView.contentOffset = CGPointMake(0, 0);
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
            //越界后滚动到相应位置
            if (40 * i  + 10 > _orderScrollView.frame.size.width) {
                _orderScrollView.contentOffset = CGPointMake(40 * i + 50 - self.orderScrollView.frame.size.width, 0);
            }else{
                _orderScrollView.contentOffset = CGPointMake(0, 0);
            }
            
        }
    }
}

@end

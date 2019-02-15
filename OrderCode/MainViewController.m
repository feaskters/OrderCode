//
//  MainViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Setting/SettingView.h"
#import "checkPoint/CheckPointPageView.h"
#import "TeachingViewController.h"
#import "competition/CompetitionViewController.h"
#import "Game/MoreView.h"
#import "db/UserDb.h"
#import "rank/RankViewController.h"

@interface MainViewController ()<LSMoreViewDelegate>

@property UIImageView *teach;
@property NSInteger scWidth;
@property NSInteger scHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property CheckPointPageView *cppv;
@property UIView *moreView;
@property UIImageView *moreImageView;
@property (nonatomic) MoreView *moreViewContent;//moreview的内容

@end

@implementation MainViewController

//懒加载moreViewContent
- (MoreView *)moreViewContent{
    if (_moreViewContent == nil) {
        _moreViewContent = [MoreView moreView];
        _moreViewContent.frame = CGRectMake(0, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
    }
    return _moreViewContent;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TeachingViewController *tvc = [segue destinationViewController];
    tvc.musplay_yx = self._musicPlay_yx;
}


//关卡选择页面
- (void)addSelectCheckPointPage{
    //沙盒路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
     NSString *fileName = [documentPath stringByAppendingPathComponent:@"CheckPoint.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fileName]) {
        //加载关卡数据
        NSString *path = [[NSBundle mainBundle]pathForResource:@"CheckPoint" ofType:@"plist"];
        if (![fileManager copyItemAtPath:path toPath:fileName error:nil]) {
            NSLog(@"plist文件移动失败");
        }

    }
    NSArray *array = [NSArray arrayWithContentsOfFile:fileName];
        //加载选择页面
    self.cppv = [CheckPointPageView checkPointPage];
    self.cppv.musplay_yx = self._musicPlay_yx;
    self.cppv.musplay = self._musicPlay;
    self.cppv.checkPointsSetting = array;
    self.cppv.navigationcontroller = self;
    CGRect frame = CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
    self.cppv.frame = frame;
    [self.mainScrollView addSubview:self.cppv];
}

//弹出设置页面
- (IBAction)setting:(UIButton *)sender {
    [__musicPlay_yx play];
    CGRect frame = CGRectMake(10, self.scHeight / 8, self.scWidth - 20, self.scHeight / 1.3);
    SettingView *view = [SettingView settingView];
    view.frame = frame;
    view.musplay = self._musicPlay;
    view.musplay_yx = self._musicPlay_yx;
    [self.view addSubview:view];
}
//更多
- (IBAction)more:(UIButton *)sender {
    self.moreView.frame = self.mainScrollView.frame;
    [__musicPlay_yx play];
    if ([sender.titleLabel.text isEqualToString:@"BACK"] || [sender.titleLabel.text isEqualToString:@"返回"]) {
        if ([sender.titleLabel.text isEqualToString:@"BACK"]) {
            [sender setTitle:@"MORE" forState:UIControlStateNormal];
            [sender setTitle:@"MORE" forState:UIControlStateHighlighted];
        }else{
            [sender setTitle:@"更多" forState:UIControlStateNormal];
            [sender setTitle:@"更多" forState:UIControlStateHighlighted];
        }
        //动画消失背景
        [UIView animateWithDuration:1 animations:^{
            self.moreImageView.frame = CGRectMake(0, 0, self.moreView.frame.size.width, 0);
            self.moreViewContent.alpha = 0;
        } completion:^(BOOL finished) {
            if (self.moreImageView.frame.size.height == 0 && self.moreViewContent.alpha == 0) {
                [self.moreImageView removeFromSuperview];
                [self.moreView removeFromSuperview];
                [self.moreViewContent removeFromSuperview];
            }
        }];
    }else{
        //改变按钮文字
        if ([sender.titleLabel.text isEqualToString:@"MORE"]) {
            [sender setTitle:@"BACK" forState:UIControlStateNormal];
            [sender setTitle:@"BACK" forState:UIControlStateHighlighted];
        }else{
            [sender setTitle:@"返回" forState:UIControlStateNormal];
            [sender setTitle:@"返回" forState:UIControlStateHighlighted];
        }
        //添加背景和内容
        [self.view addSubview:self.moreView];
        [self.moreView addSubview:self.moreImageView];
        [self.moreView addSubview:self.moreViewContent];
        self.moreViewContent.frame = CGRectMake(0, 0, self.moreView.frame.size.width, self.moreView.frame.size.height);
        self.moreViewContent.alpha = 0;
        //动画显示背景
        [UIView animateWithDuration:1 animations:^{
            self.moreImageView.frame = CGRectMake(0, 0, self.moreView.frame.size.width, self.moreView.frame.size.height);
            self.moreViewContent.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

//教程页面
- (IBAction)teach:(UIButton *)sender {
    [__musicPlay_yx play];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scWidth = self.view.frame.size.width;
    self.scHeight = self.view.frame.size.height;
    //更多view
    self.moreView = [[UIView alloc]init];
    self.moreView.frame = CGRectMake(self.mainScrollView.frame.origin.x, self.mainScrollView.frame.origin.y, self.scWidth - 20, _scHeight - 200);
    self.moreView.backgroundColor = nil;
    //view的背景
    UIImage *image = [UIImage imageNamed:@"背景-设置2"];
    self.moreImageView = [[UIImageView alloc]initWithImage:image];
    self.moreImageView.frame = CGRectMake(0, 0, self.moreView.frame.size.width, 20);
    //moreView的内容
    self.moreViewContent = [MoreView moreView];
    //设置moreview代理
    self.moreViewContent.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [__musicPlay pause];
    [self.cppv removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated{
    [__musicPlay play];
    [self addSelectCheckPointPage];
}


#pragma mark LSMoreViewDelegate

//排行榜
-(void)LSMoreViewRankButtonClick{
    [self._musicPlay_yx play];
    RankViewController *rvc = [[RankViewController alloc]init];
    rvc.musicPlay_yx = self._musicPlay_yx;
    [self presentViewController:rvc animated:YES completion:^{
        
    }];
}

//竞赛模式
-(void)LSMoreViewCompetitionButtonClick{
    [self._musicPlay_yx play];
    CompetitionViewController *cvc = [CompetitionViewController competitionView];
    cvc.musPlay_yx = self._musicPlay_yx;
    cvc.musplay = self._musicPlay;
    [self presentViewController:cvc animated:YES completion:^{
        
    }];
}

@end

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

@interface MainViewController ()

@property UIImageView *teach;
@property NSInteger scWidth;
@property NSInteger scHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property CheckPointPageView *cppv;
@property UIView *moreView;
@property UIImageView *moreImageView;

@end

@implementation MainViewController


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
    [__musicPlay_yx play];
    if ([sender.titleLabel.text isEqualToString:@"BACK"]) {
        [sender setTitle:@"MORE" forState:UIControlStateNormal];
        [sender setTitle:@"MORE" forState:UIControlStateHighlighted];
        //动画消失背景
        [UIView animateWithDuration:1 animations:^{
            self.moreImageView.frame = CGRectMake(0, 0, self.moreView.frame.size.width, 0);
        } completion:^(BOOL finished) {
        }];
    }else{
        [sender setTitle:@"BACK" forState:UIControlStateNormal];
        [sender setTitle:@"BACK" forState:UIControlStateHighlighted];
        [self.view addSubview:self.moreView];
        [self.moreView addSubview:self.moreImageView];
        //动画显示背景
        [UIView animateWithDuration:1 animations:^{
            self.moreImageView.frame = CGRectMake(0, 0, self.moreView.frame.size.width, self.moreView.frame.size.height);
        } completion:^(BOOL finished) {
        }];
    }
    
}

//教程页面
- (IBAction)teach:(UIButton *)sender {
    [__musicPlay_yx play];
}

//竞赛模式
- (IBAction)competition:(UIButton *)sender {
    [__musicPlay_yx play];
    CompetitionViewController *cvc = [CompetitionViewController competitionView];
    cvc.musPlay_yx = self._musicPlay_yx;
    cvc.musplay = self._musicPlay;
    [self presentViewController:cvc animated:YES completion:^{
        
    }];
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
    UIImage *image = [UIImage imageNamed:@"更多菜单"];
    self.moreImageView = [[UIImageView alloc]initWithImage:image];
    self.moreImageView.frame = CGRectMake(0, 0, self.moreView.frame.size.width, 20);
}

-(void)viewDidDisappear:(BOOL)animated{
    [__musicPlay pause];
    [self.cppv removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated{
    [__musicPlay play];
    [self addSelectCheckPointPage];
}
@end

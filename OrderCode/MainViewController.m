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
#import "TeachViewController.h"

@interface MainViewController ()

@property UIImageView *teach;
@property NSInteger screenWidth;
@property NSInteger screenHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property CheckPointPageView *cppv;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenWidth = self.view.frame.size.width;
    self.screenHeight = self.view.frame.size.height;
}

-(void)viewDidDisappear:(BOOL)animated{
    [__musicPlay pause];
    [self.cppv removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated{
    [__musicPlay play];
    [self addSelectCheckPointPage];
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
    self.cppv.musicPlay_yx = self._musicPlay_yx;
    self.cppv.musicPlay = self._musicPlay;
    self.cppv.checkPoints = array;
    self.cppv.nc = self;
    CGRect frame = CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
    self.cppv.frame = frame;
    [self.mainScrollView addSubview:self.cppv];
}

//弹出设置页面
- (IBAction)setting:(UIButton *)sender {
    [__musicPlay_yx play];
    CGRect frame = CGRectMake(10, self.screenHeight / 8, self.screenWidth - 20, self.screenHeight / 1.3);
    SettingView *view = [SettingView settingView];
    view.frame = frame;
    view.musicPlay = self._musicPlay;
    view.musicPlay_yx = self._musicPlay_yx;
    [self.view addSubview:view];
}

//教程页面
- (IBAction)teach:(UIButton *)sender {
    [__musicPlay_yx play];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TeachViewController *tvc = [segue destinationViewController];
    tvc.musicPlay_yx = self._musicPlay_yx;
}

@end

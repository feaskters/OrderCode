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

@interface MainViewController ()

@property NSInteger screenWidth;
@property NSInteger screenHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenWidth = self.view.frame.size.width;
    self.screenHeight = self.view.frame.size.height;
}

- (void)viewDidAppear:(BOOL)animated{
    [self addSelectCheckPointPage];
}

//关卡选择页面
- (void)addSelectCheckPointPage{
    //加载关卡数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"CheckPoint" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //加载选择页面
    CheckPointPageView *cppv = [CheckPointPageView checkPointPage];
    cppv.musicPlay_yx = self._musicPlay_yx;
    cppv.checkPoints = array;
    CGRect frame = CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
    cppv.frame = frame;
    [self.mainScrollView addSubview:cppv];
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

//加载关卡选择页面

@end

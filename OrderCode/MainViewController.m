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

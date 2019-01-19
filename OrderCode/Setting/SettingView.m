//
//  SettingView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "SettingView.h"


@interface SettingView()
@property (weak, nonatomic) IBOutlet UISlider *volume;

@end

@implementation SettingView

+(instancetype)settingView{
     SettingView *view = [[NSBundle mainBundle]loadNibNamed:@"SettingView" owner:nil options:nil][0];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]){
        self.volume.value = _musicPlay.volume;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (IBAction)silent:(UIButton *)sender {
    //判断当期是否为静音
    if ([sender.titleLabel.text isEqualToString:@"静音"]) {
        //改变slider位置
        self.volume.value = 0;
        [_musicPlay setVolume:0];
        [sender setTitle:@"取消静音" forState:UIControlStateNormal];
    }else{
        self.volume.value = 0.5;
        [_musicPlay setVolume:0.5];
           [sender setTitle:@"静音" forState:UIControlStateNormal];
    }
}

//滑动音量
- (IBAction)changeVolume:(UISlider *)sender {
    [_musicPlay setVolume:sender.value];
}

//f设置完成
- (IBAction)back:(UIButton *)sender {
    _musicPlay = nil;
    [_musicPlay_yx play];
    _musicPlay_yx = nil;
    [self removeFromSuperview];
}

@end

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
@property (weak, nonatomic) IBOutlet UISlider *volume_yx;
@property (weak, nonatomic) IBOutlet UIButton *mute;

@end

@implementation SettingView

+(instancetype)settingView{
     SettingView *view = [[NSBundle mainBundle]loadNibNamed:@"SettingView" owner:nil options:nil][0];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]){
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
           self.volume.value = _musicPlay.volume;
           self.volume_yx.value = _musicPlay_yx.volume;
    if (self.volume_yx.value == 0.0 && self.volume.value == 0.0) {
        [self.mute setTitle:@"取消静音" forState:UIControlStateNormal] ;
    }
}

- (IBAction)silent:(UIButton *)sender {
    //判断当期是否为静音
    if ([sender.titleLabel.text isEqualToString:@"静音"]) {
        //改变slider位置
        self.volume.value = 0;
        self.volume_yx.value = 0;
        [_musicPlay setVolume:0];
        [_musicPlay_yx setVolume:0];
        [sender setTitle:@"取消静音" forState:UIControlStateNormal];
    }else{
        self.volume.value = 0.5;
        self.volume_yx.value = 0.5;
        [_musicPlay setVolume:0.5];
        [_musicPlay_yx setVolume:0.5];
           [sender setTitle:@"静音" forState:UIControlStateNormal];
    }
}

//滑动音量
- (IBAction)changeVolume:(UISlider *)sender {
    [_musicPlay setVolume:sender.value];
}
- (IBAction)changeVolume_yx:(UISlider *)sender {
    [_musicPlay_yx setVolume:sender.value];
}

//f设置完成
- (IBAction)back:(UIButton *)sender {
    _musicPlay = nil;
    [_musicPlay_yx play];
    _musicPlay_yx = nil;
    [self removeFromSuperview];
}

@end

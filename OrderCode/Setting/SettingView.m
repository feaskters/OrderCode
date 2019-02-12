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

@property NSString *muteString;
@property NSString *unmuteString;
@end

@implementation SettingView

+(instancetype)settingView{
     SettingView *view = [[NSBundle mainBundle]loadNibNamed:@"SettingView" owner:nil options:nil][0];
    return view;
}


- (IBAction)silent:(UIButton *)sender {
    //判断当期是否为静音
    if ([sender.titleLabel.text isEqualToString:self.muteString]) {
        //改变slider位置
        self.volume.value = 0;
        self.volume_yx.value = 0;
        [_musplay setVolume:0];
        [_musplay_yx setVolume:0];
        [sender setTitle:self.unmuteString forState:UIControlStateNormal];
    }else{
        self.volume.value = 0.5;
        self.volume_yx.value = 0.5;
        [_musplay setVolume:0.5];
        [_musplay_yx setVolume:0.5];
           [sender setTitle:self.muteString forState:UIControlStateNormal];
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]){
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.muteString = NSLocalizedString(@"静音", nil);
    self.unmuteString = NSLocalizedString(@"取消静音", nil);
    self.volume.value = _musplay.volume;
    self.volume_yx.value = _musplay_yx.volume;
    if (self.volume_yx.value == 0.0 && self.volume.value == 0.0) {
        [self.mute setTitle:self.unmuteString forState:UIControlStateNormal] ;
    }
}


//滑动音量
- (IBAction)changeVolume:(UISlider *)sender {
    [_musplay setVolume:sender.value];
}
- (IBAction)changeVolume_yx:(UISlider *)sender {
    [_musplay_yx setVolume:sender.value];
}

//f设置完成
- (IBAction)back:(UIButton *)sender {
    _musplay = nil;
    [_musplay_yx play];
    _musplay_yx = nil;
    [self removeFromSuperview];
}

@end

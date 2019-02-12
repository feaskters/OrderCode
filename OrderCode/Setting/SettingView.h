//
//  SettingView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingView : UIView
//音乐播放器对象
@property AVAudioPlayer *musplay;

//音乐播放器对象
@property AVAudioPlayer *musplay_yx;

+(instancetype)settingView;

@end

NS_ASSUME_NONNULL_END

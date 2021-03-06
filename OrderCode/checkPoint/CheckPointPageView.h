//
//  CheckPointPageView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckPointPageView : UIView

@property UIViewController *navigationcontroller;//main的navigationcontroller

@property AVAudioPlayer *musplay;
@property AVAudioPlayer *musplay_yx;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property NSArray *checkPointsSetting;

+(instancetype)checkPointPage;

@end

NS_ASSUME_NONNULL_END

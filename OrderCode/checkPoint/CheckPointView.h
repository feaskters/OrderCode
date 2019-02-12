//
//  CheckPointView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/19.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckPointView : UIView

@property UIViewController *navigationController;//main的navigationcontroller
@property AVAudioPlayer *musplay;
@property AVAudioPlayer *musplay_yx;
@property (weak, nonatomic) IBOutlet UIImageView *shiningStar;
@property (weak, nonatomic) IBOutlet UIButton *levelNumber;

@property NSDictionary *checkPonitMessage;

+(instancetype)getCheckPoint;

@end

NS_ASSUME_NONNULL_END

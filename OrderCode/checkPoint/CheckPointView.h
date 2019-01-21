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

@property AVAudioPlayer *musicPlay_yx;
@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UIButton *level;

@property NSDictionary *checkPonitInfo;

+(instancetype)checkPoint;

@end

NS_ASSUME_NONNULL_END

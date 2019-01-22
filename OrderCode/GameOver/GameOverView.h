//
//  GameOverView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "../Game/GameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameOverView : UIView

@property AVAudioPlayer *musicPlay_yx;
@property NSDictionary *gameDetail;
@property int is_star;
@property int is_clear;
@property GameViewController *gvc;

+(instancetype)gameOverView;

@end

NS_ASSUME_NONNULL_END

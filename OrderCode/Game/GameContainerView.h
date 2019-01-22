//
//  GameContainerView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface GameContainerView : UIView


@property AVAudioPlayer *musicPlay_coin;
@property AVAudioPlayer *musicPlay_yx;
@property AVAudioPlayer *musicPlay_move;
@property NSDictionary *gameDetail;
+(instancetype)gameContainer;
//移动并返回当前位置
-(NSArray *)move:(int)order;
@end

NS_ASSUME_NONNULL_END

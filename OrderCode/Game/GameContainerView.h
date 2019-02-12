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


@property UIImageView *coinView;
@property AVAudioPlayer *musPlay_coin;
@property AVAudioPlayer *musPlay_yx;
@property AVAudioPlayer *musPlay_move;
@property NSDictionary *gameDetail;
+(instancetype)gameContainer;
//移动并返回当前位置
-(NSArray *)move:(int)message;
@end

NS_ASSUME_NONNULL_END
